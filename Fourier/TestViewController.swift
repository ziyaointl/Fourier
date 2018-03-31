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
        self.view.addAndCenterSubview(subView: waveFormViewController.view, subViewHeight: Constants.Table.RowHeight, horizontalInset: 30)
    }
}
