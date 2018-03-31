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
    private static let audioEngine = AVAudioEngine()
    private let fftHelper = FFTHelper()
    private let pureTonePlayerNode = AVPureTonePlayerNode()
    private let audioFilePlayerNode = AVAudioPlayerNode()
    public weak var delegate: AudioManagerDelegate?
    public var installTap = false
    
    public init() {
        AudioManager.audioEngine.attach(pureTonePlayerNode)
        AudioManager.audioEngine.connect(pureTonePlayerNode, to: AudioManager.audioEngine.mainMixerNode, format: pureTonePlayerNode.format)
        AudioManager.audioEngine.attach(audioFilePlayerNode)
        AudioManager.audioEngine.connect(audioFilePlayerNode, to: AudioManager.audioEngine.mainMixerNode, format: audioFilePlayerNode.outputFormat(forBus: 0))
    }
    
    public func getBufferOf(fileWithURL url: URL) -> AVAudioPCMBuffer {
        if let inputFile = try? AVAudioFile(forReading: url) {
            return AVAudioPCMBuffer(pcmFormat: inputFile.processingFormat, frameCapacity: AVAudioFrameCount(inputFile.length))!
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
            
            // Install tap
            // If true, a delegate is required to accept the FFT result
            if installTap {
                let bufferSize: UInt32 = 4000
                let mixerNode = AudioManager.audioEngine.mainMixerNode
                mixerNode.installTap(onBus: 0, bufferSize: bufferSize, format: mixerNode.outputFormat(forBus: 0)) { [weak self] (buffer, time) in
                    buffer.frameLength = bufferSize
                    self?.fftHelper.fourierTransform(buffer: buffer, audioManager: self!)
                }
            }
            
            // Start Playing
            try? AudioManager.audioEngine.start()
            audioFilePlayerNode.play()
        }
    }
    
    public func pause() {
        pureTonePlayerNode.pause()
        audioFilePlayerNode.pause()
    }
    
    public func play(pureToneWithFrequency frequency: Int) {
        pureTonePlayerNode.frequency = Double(frequency)
        try? AudioManager.audioEngine.start()
        pureTonePlayerNode.play()
    }
}
