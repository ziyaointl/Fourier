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
        let subView = PlotView()
        subView.backgroundColor = Constants.Colors.Background
        subView.includeNegativeYAxis = true
        subView.currentFunction = SineFunctionGenerator.generateSineForPlotting(withFrequency: 440)
        self.view.addAndCenterSubview(subView: subView, subViewHeight: 126, horizontalInset: 20)
    }
}
