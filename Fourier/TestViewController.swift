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
        let viewController = WaveFormAndFFTViewController()
        self.view.addAndCenterSubview(subView: viewController.view, subViewHeight: Constants.Table.RowHeight * 2 + 30, horizontalInset: 30)
    }
}
