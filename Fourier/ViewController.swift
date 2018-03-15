//
//  ViewController.swift
//  Fourier
//
//  Created by Blocry Glass on 3/15/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import UIKit
import AVFoundation
import Accelerate

class ViewController: UIViewController {

    var audioEngine = AVAudioEngine()
    var audioNode = AVAudioPlayerNode()
    @IBOutlet weak var spectrumView: SpectrumView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initializeAudioEngine()
        playAudio()
    }
    
    func initializeAudioEngine() {
        audioEngine.attach(audioNode)
        if let url = Bundle.main.url(forResource: "Mirror", withExtension: "mp3") {
//        if let url = Bundle.main.url(forResource: "MDK - Fingerbang", withExtension: "mp3") {
//        if let url = Bundle.main.url(forResource: "Fouler_lhorizon", withExtension: "mp3") {
//        if let url = Bundle.main.url(forResource: "440and173", withExtension: "m4a") {
            if let inputFile = try? AVAudioFile(forReading: url) {
                let buffer = AVAudioPCMBuffer(pcmFormat: inputFile.processingFormat, frameCapacity: AVAudioFrameCount(inputFile.length))!
                try? inputFile.read(into: buffer)
                audioEngine.connect(audioNode, to: audioEngine.mainMixerNode, format: buffer.format)
                audioNode.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: self.success)
                
                //Install tap
                let bufferSize: UInt32 = 1024
                let mixerNode = audioEngine.mainMixerNode
                mixerNode.installTap(onBus: 0, bufferSize: bufferSize, format: mixerNode.outputFormat(forBus: 0)) { (buffer, time) in
                    buffer.frameLength = bufferSize
                    self.fourierTransform(buffer: buffer) // possible memory cycle
                }
                
            }
        }
    }
    
    func fourierTransform(buffer: AVAudioPCMBuffer) {
        if spectrumView != nil {
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
                
                spectrumView.points = spectrum
                DispatchQueue.main.async {
                    self.spectrumView.setNeedsDisplay()
                }
                vDSP_destroy_fftsetup(fftSetup)
            } else {
                print("Not enough memory to setup fft")
            }
        }
    }
    
    func playAudio() {
        try? audioEngine.start()
        audioNode.play()
    }
    
    func success() {
        print("success")
    }


}

