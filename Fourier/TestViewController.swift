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
        let waveformTableViewController = WaveformTableViewController()
        view.addSubview(waveformTableViewController.view)
        func createWave(withFrequency frequency: Int) {
            waveformTableViewController.addWaveForm(withFrequency: frequency)
        }
        createWave(withFrequency: 440)
        createWave(withFrequency: 880)
        createWave(withFrequency: 1320)
    }
}
