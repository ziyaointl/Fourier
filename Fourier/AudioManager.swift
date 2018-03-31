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

public class AudioManager {
    private let audioEngine = AVAudioEngine()
    private let fftHelper = FFTHelper()
    private let pureTonePlayerNode = AVPureTonePlayerNode()
    private let audioFilePlayerNode = AVAudioPlayerNode()
    public weak var delegate: AudioManagerDelegate?
    public var installTap = false
    
    public init() {
        audioEngine.attach(pureTonePlayerNode)
        audioEngine.connect(pureTonePlayerNode, to: audioEngine.mainMixerNode, format: pureTonePlayerNode.format)
        audioEngine.attach(audioFilePlayerNode)
        audioEngine.connect(audioFilePlayerNode, to: audioEngine.mainMixerNode, format: audioFilePlayerNode.outputFormat(forBus: 0))
    }
    
    public static func getBufferOf(fileWithURL url: URL) -> AVAudioPCMBuffer {
        if let inputFile = try? AVAudioFile(forReading: url) {
            let buffer = AVAudioPCMBuffer(pcmFormat: inputFile.processingFormat, frameCapacity: AVAudioFrameCount(inputFile.length))!
            try? inputFile.read(into: buffer)
            return buffer
        }
        return AVAudioPCMBuffer()
    }
    
    public func play(fileWithURL url: URL, completionHandler: AVAudioNodeCompletionHandler?) {
        if let inputFile = try? AVAudioFile(forReading: url) {
            let buffer = AVAudioPCMBuffer(pcmFormat: inputFile.processingFormat, frameCapacity: AVAudioFrameCount(inputFile.length))!
            try? inputFile.read(into: buffer)
            
            func scheduleBuffer() {
                audioFilePlayerNode.scheduleBuffer(buffer, at: nil, options: [], completionHandler: {
                    completionHandler?()
                    scheduleBuffer()
                })
            }
            scheduleBuffer()
            
            tryToInstallTap()
            
            // Start Playing
            try? audioEngine.start()
            audioFilePlayerNode.play()
        }
    }
    
    public func pause() {
        pureTonePlayerNode.pause()
        audioFilePlayerNode.pause()
    }
    
    public func play(pureToneWithFrequency frequency: Int) {
        pureTonePlayerNode.frequency = Double(frequency)
        tryToInstallTap()
        try? audioEngine.start()
        pureTonePlayerNode.play()
    }
    
    private func tryToInstallTap() {
        // Install tap
        // If true, a delegate is required to accept the FFT result
        if installTap {
            let bufferSize: UInt32 = 4000
            let mixerNode = audioEngine.mainMixerNode
            mixerNode.installTap(onBus: 0, bufferSize: bufferSize, format: mixerNode.outputFormat(forBus: 0)) { [weak self] (buffer, time) in
                buffer.frameLength = bufferSize
                self?.fftHelper.fourierTransform(buffer: buffer, audioManager: self!)
            }
            installTap = false
        }
    }
}
