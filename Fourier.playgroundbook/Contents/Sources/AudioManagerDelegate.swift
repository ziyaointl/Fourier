//
//  AudioManagerDelegate.swift
//  Fourier
//
//  Created by Blocry Glass on 3/16/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation
import AVFoundation

public protocol AudioManagerDelegate: NSObjectProtocol {
    func didFourierTransform(_ audioManager: AudioManager, output: Array<Float>)
}
