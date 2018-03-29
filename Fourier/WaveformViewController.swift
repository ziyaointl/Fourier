//
//  WaveformViewController.swift
//  Fourier
//
//  Created by Blocry Glass on 3/29/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import UIKit

public class WaveformViewController: UIViewController, WaveformViewDelegate {
    struct Icons {
        static let play = ""
        static let pause = ""
    }
    
    private var mainView: WaveformView!
    private var playButton: UIButton!
    private var isPlaying = false
    
    override public func loadView() {
        super.loadView()
        mainView = WaveformView()
        view = mainView
        mainView.delegate = self
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let plotView = mainView.plotView!
        plotView.includeNegativeYAxis = true
        plotView.contentMode = .redraw
        plotView.currentFunction = {x in
            let x = 0.1 * x
            return sin(x) * 30
        }
        
        playButton = mainView.playButton!
        playButton.titleLabel?.font = UIFont(name: "Ionicons", size: 50)!
        playButton.layer.borderColor = #colorLiteral(red: 0.3627791107, green: 0.3627791107, blue: 0.3627791107, alpha: 1)
        playButton.layer.cornerRadius = playButton.bounds.width / 2
        playButton.layer.borderWidth = 2.0
        
        let title = mainView.title!
        title.textColor = #colorLiteral(red: 0.3627791107, green: 0.3627791107, blue: 0.3627791107, alpha: 1)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public func playButtonPressed(sender: UIButton) {
        if isPlaying {
            playButton.setTitle(Icons.play, for: .normal)
            playButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)
        } else {
            playButton.setTitle(Icons.pause, for: .normal)
            playButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        }
        isPlaying = !isPlaying
    }
}
