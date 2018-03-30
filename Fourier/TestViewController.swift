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
        let subViewController = WaveformViewController()
        self.view.addAndCenterSubview(subView: subViewController.view, subViewHeight: 126, horizontalInset: 20)
    }
}
