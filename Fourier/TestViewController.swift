//
//  TestViewController.swift
//  Fourier
//
//  Created by Ziyao Zhang on 3/26/18.
//  Copyright © 2018 Ziyao Zhang. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(image: Constants.Resources.EquationImage)
        imageView.contentMode = .scaleAspectFit
        self.view.fillSelfWith(subView: imageView)
    }
}
