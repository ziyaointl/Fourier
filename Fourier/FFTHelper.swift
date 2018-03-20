//
//  FFTHelper.swift
//  Fourier
//
//  Created by Blocry Glass on 3/20/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation
import Accelerate
import AVFoundation

class FFTHelper {
    private var fftSetup: FFTSetup!
    private var frameCountLog2 = vDSP_Length(0)
    
    deinit {
        if fftSetup != nil {
            vDSP_destroy_fftsetup(fftSetup)
        }
    }
    
    func fourierTransform(buffer: AVAudioPCMBuffer, audioManager: AudioManager) {
        let frameCount = buffer.frameLength
        let currentFrameCountInLog2 = vDSP_Length(log2(Double(frameCount)))
        if fftSetup == nil || self.frameCountLog2 < currentFrameCountInLog2 {
            fftSetup = vDSP_create_fftsetup(currentFrameCountInLog2, FFTRadix(FFT_RADIX2))
            frameCountLog2 = currentFrameCountInLog2
        }

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
        vDSP_fft_zrip(fftSetup, &output, 1, currentFrameCountInLog2, FFTDirection(FFT_FORWARD))
        
        var spectrum = [Float]()
        for i in 1..<Int(frameCount / 2) {
            spectrum.append(sqrt((pow(output.imagp[i], 2) + pow(output.imagp[i], 2))))
        }
        
        audioManager.delegate?.didFourierTransform(audioManager, output: spectrum)
    }
}
