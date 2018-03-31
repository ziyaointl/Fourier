//
//  ToneComparisonViewController.swift
//  Fourier
//
//  Created by Blocry Glass on 3/31/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import UIKit

public class ToneComparisonViewController: UIViewController {
    public var stackView: UIStackView!
    public var scrollView: UIScrollView!
    
    override public func loadView() {
        super.loadView()
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stackView.frame.size.width = scrollView.frame.width
        scrollView.contentSize = stackView.bounds.size
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView()
        self.view.fillSelfWith(subView: scrollView, inset: 30)
        self.view.backgroundColor = Constants.Colors.LightGray
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        let frequencyViewController = WaveFormAndFFTViewController()
        frequencyViewController.mediaType = .frequency(440)
        let pianoViewController = WaveFormAndFFTViewController()
        stackView.addArrangedSubview(frequencyViewController.view)
        stackView.addArrangedSubview(pianoViewController.view)
        
        stackView.frame.size.height = Constants.ViewHeight.WaveFormAndFFTView * 2
        stackView.spacing = 30
        
        scrollView.backgroundColor = Constants.Colors.LightGray
        scrollView.contentSize = stackView.bounds.size
        scrollView.addSubview(stackView)
    }

}
