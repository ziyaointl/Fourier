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
        waveFormViewController.mediaType = .frequency(440)
        waveFormViewController.titleText = String(440) + " Hz"
        waveFormViewController.currentFunction = SineFunctionGenerator.generateSineForPlotting(withFrequency: 440)
        self.view.addAndCenterSubview(subView: waveFormViewController.view, subViewHeight: Constants.Table.RowHeight, horizontalInset: 20)
    }
}
