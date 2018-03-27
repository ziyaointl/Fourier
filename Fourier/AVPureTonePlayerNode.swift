//
//  AVPureTonePlayerNode.swift
//  Fourier
//
//  Created by Blocry Glass on 3/27/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation
import AVFoundation

class AVPureTonePlayerNode: AVAudioPlayerNode {
    public var frequency = 440.0
    public var format: AVAudioFormat!
    
    private let bufferCapacity: AVAudioFrameCount = 1024
    private let sampleRate = 44100.0
    private let amplitude = 0.25
    private let numberOfBuffers = 4
    private var isStopped = true
    private var theta = 0.0
    
    override public init() {
        super.init()
        format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)
    }
    
    private func getBuffer() -> AVAudioPCMBuffer {
        let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: bufferCapacity)!
        
        let firstFramePointer = buffer.floatChannelData![0]
        let thetaPerSecond = 2.0 * .pi * frequency
        let thetaPerSample = thetaPerSecond / sampleRate
        
        for frameIndex in 0..<bufferCapacity {
            firstFramePointer[Int(frameIndex)] = Float(sin(theta) * amplitude)
            theta += thetaPerSample
            
            // Prevent theta from increasing indefinitely
            // sin(2 * .pi + theta) = sin(theta)
            if theta > 2.0 * .pi {
                theta -= 2.0 * .pi
            }
        }
        
        // Set the number filled frames in the buffer
        buffer.frameLength = bufferCapacity
        return buffer
    }
    
    private func scheduleBuffer() {
        let buffer = getBuffer()
        scheduleBuffer(buffer, completionHandler: { [weak self] in
            if self != nil && (self?.isPlaying)! {
                self?.scheduleBuffer()
            }
        })
    }
    
    override public func play() {
        if isStopped {
            for _ in 0..<numberOfBuffers {
                scheduleBuffer()
            }
        }
        isStopped = false
        super.play()
    }
}
