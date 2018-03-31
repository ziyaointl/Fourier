//
//  TestViewController.swift
//  Fourier
//
//  Created by Blocry Glass on 3/26/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let waveFormViewController = WaveformViewController()
        let fileURL = Bundle.main.url(forResource: "Piano A4", withExtension: ".m4a")!
        waveFormViewController.mediaType = .file(fileURL)
        
        let buffer = AudioManager.getBufferOf(fileWithURL: fileURL)
        print(buffer.frameLength)
        print(buffer.frameCapacity)
        let currentFunc: (Double) -> Double = { x in
            if UInt32(x) > buffer.frameCapacity {
                return 0.0
            }
            return Double(buffer.floatChannelData![0][Int(x)] * 200)
        }
        waveFormViewController.currentFunction = currentFunc
        self.view.addAndCenterSubview(subView: waveFormViewController.view, subViewHeight: Constants.Table.RowHeight, horizontalInset: 30)
    }
}
