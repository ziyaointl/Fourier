//
//  PianoNoteViewController.swift
//  Fourier
//
//  Created by Blocry Glass on 3/31/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import UIKit

public class PianoNoteViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        let waveFormViewController = WaveformViewController()
        waveFormViewController.titleText = "Grand Piano 440Hz (A4)"
        let fileURL = Bundle.main.url(forResource: "Piano A4", withExtension: ".m4a")!
        waveFormViewController.mediaType = .file(fileURL)
        let buffer = AudioManager.getBufferOf(fileWithURL: fileURL)
        let currentFunc: (Double) -> Double = { x in
            if UInt32(x) > buffer.frameCapacity {
                return 0.0
            }
            return Double(buffer.floatChannelData![0][Int(x)] * 200)
        }
        waveFormViewController.currentFunction = currentFunc
        self.view.fillSelfWith(subView: waveFormViewController.view)
    }

}
