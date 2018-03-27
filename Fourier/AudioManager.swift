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
    private var pureTonePlayerNodes = [Int: AVPureTonePlayerNode]()
    public weak var delegate: AudioManagerDelegate?
    public var installTap = false
    
    public func play(fileWithURL url: URL) {
        if let inputFile = try? AVAudioFile(forReading: url) {
            let buffer = AVAudioPCMBuffer(pcmFormat: inputFile.processingFormat, frameCapacity: AVAudioFrameCount(inputFile.length))!
            try? inputFile.read(into: buffer)
            let audioNode = AVAudioPlayerNode()
            audioEngine.attach(audioNode)
            audioEngine.connect(audioNode, to: audioEngine.mainMixerNode, format: buffer.format)
            audioNode.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)
            
            // Install tap
            if installTap {
                let bufferSize: UInt32 = 4000
                let mixerNode = audioEngine.mainMixerNode
                mixerNode.installTap(onBus: 0, bufferSize: bufferSize, format: mixerNode.outputFormat(forBus: 0)) { (buffer, time) in
                    buffer.frameLength = bufferSize
                    self.fftHelper.fourierTransform(buffer: buffer, audioManager: self) // possible memory cycle
                }
            }
            
            // Start Playing
            try? audioEngine.start()
            audioNode.play()
        }
    }
    
    public func play(pureToneWithFrequency frequency: Int) {
        // Create audio node if it does not exist
        if pureTonePlayerNodes[frequency] == nil {
            let node = AVPureTonePlayerNode()
            node.frequency = Double(frequency)
            audioEngine.attach(node)
            audioEngine.connect(node, to: audioEngine.mainMixerNode, format: node.format)
            pureTonePlayerNodes[frequency] = node
        }
        try? audioEngine.start()
        pureTonePlayerNodes[frequency]?.play()
    }
}
