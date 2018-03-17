//
//  AudioManager.swift
//  Fourier
//
//  Created by Blocry Glass on 3/16/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation
import AVFoundation
import Accelerate

class AudioManager {
    private let audioEngine = AVAudioEngine()
    private let audioNode = AVAudioPlayerNode()
    weak var delegate: AudioManagerDelegate?
    
    init() {
        audioEngine.attach(audioNode)
    }
    
    func play(fileWithURL url: URL) {
        if let inputFile = try? AVAudioFile(forReading: url) {
            let buffer = AVAudioPCMBuffer(pcmFormat: inputFile.processingFormat, frameCapacity: AVAudioFrameCount(inputFile.length))!
            try? inputFile.read(into: buffer)
            audioEngine.connect(audioNode, to: audioEngine.mainMixerNode, format: buffer.format)
            audioNode.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)
            
            // Install tap
            let bufferSize: UInt32 = 1024
            let mixerNode = audioEngine.mainMixerNode
            mixerNode.installTap(onBus: 0, bufferSize: bufferSize, format: mixerNode.outputFormat(forBus: 0)) { (buffer, time) in
                buffer.frameLength = bufferSize
                self.fourierTransform(buffer: buffer) // possible memory cycle
            }
            
            // Start Playing
            try? audioEngine.start()
            audioNode.play()
        }
    }
    
    func fourierTransform(buffer: AVAudioPCMBuffer) {
        let frameCount = buffer.frameLength
        let frameCountInLog2 = vDSP_Length(log2(Double(frameCount)))
        if let fftSetup = vDSP_create_fftsetup(frameCountInLog2, FFTRadix(FFT_RADIX2)) {
            var realp = [Float](repeating: 0.0, count: Int(frameCount / 2))
            var imagp = [Float](repeating: 0.0, count: Int(frameCount / 2))
            var output = DSPSplitComplex(realp: &realp, imagp: &imagp)
            
            // Apply Window Function
            var window = [Float](repeating: 0, count: Int(frameCount))
            vDSP_hann_window(&window, vDSP_Length(frameCount), Int32(vDSP_HANN_NORM))
            vDSP_vmul((buffer.floatChannelData?.pointee)!, 1, window, 1, (buffer.floatChannelData?.pointee)!, 1, vDSP_Length(frameCount))
            
            buffer.floatChannelData?.pointee.withMemoryRebound(to: DSPComplex.self, capacity: Int(frameCount)) { bufferAsComplexArray in
                let bufferAsComplexArray : UnsafeMutablePointer<DSPComplex> = bufferAsComplexArray
                vDSP_ctoz(bufferAsComplexArray, 2, &output, 1, vDSP_Length(frameCount / 2))
            }
            
            // Perform FFT
            vDSP_fft_zrip(fftSetup, &output, 1, frameCountInLog2, FFTDirection(FFT_FORWARD))
            
            var spectrum = [Float]()
            for i in 1..<Int(frameCount / 2) {
                spectrum.append(sqrt((pow(output.imagp[i], 2) + pow(output.imagp[i], 2))))
            }
            
            delegate?.didFourierTransform(self, output: spectrum)
            
            vDSP_destroy_fftsetup(fftSetup)
        } else {
            print("Not enough memory to setup fft")
        }
    }
}
