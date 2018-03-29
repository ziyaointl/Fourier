//
//  WaveformViewController.swift
//  Fourier
//
//  Created by Blocry Glass on 3/29/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import UIKit

public class WaveformViewController: UIViewController, WaveformViewDelegate {
    struct Icon {
        static let play = ""
        static let pause = ""
    }
    
    public var mediaType = MediaType.frequency(440)
    public var titleText: String = "Title" {
        didSet {
            if let label = titleLabel {
                label.text = titleText
            }
        }
    }
    private var mainView: WaveformView!
    private var titleLabel: UILabel!
    private var playButton: UIButton!
    private var plotView: PlotView!
    private var isPlaying = false
    private var audioManager = AudioManager()
    
    override public func loadView() {
        super.loadView()
        mainView = WaveformView()
        view = mainView
        mainView.delegate = self
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        plotView = mainView.plotView
        plotView.includeNegativeYAxis = true
        plotView.contentMode = .redraw
        plotView.currentFunction = {x in
            let x = 0.1 * x
            return sin(x) * 30
        }
        
        playButton = mainView.playButton
        playButton.titleLabel?.font = UIFont(name: "Ionicons", size: 50)!
        playButton.layer.borderColor = #colorLiteral(red: 0.3627791107, green: 0.3627791107, blue: 0.3627791107, alpha: 1)
        playButton.layer.cornerRadius = playButton.bounds.width / 2
        playButton.layer.borderWidth = 2.0
        
        titleLabel = mainView.title
        titleLabel.text = titleText
        titleLabel.textColor = #colorLiteral(red: 0.3627791107, green: 0.3627791107, blue: 0.3627791107, alpha: 1)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public func playButtonPressed(sender: UIButton) {
        if isPlaying {
            playButton.setTitle(Icon.play, for: .normal)
            playButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)
            pauseAudio()
        } else {
            playButton.setTitle(Icon.pause, for: .normal)
            playButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
            playAudio()
            startAnimation()
        }
        isPlaying = !isPlaying
    }
    
    private func startAnimation() {
        let animationBlock: () -> Void = {[weak self] in
            self?.plotView.offset += 30 * .pi
        }
        func animate() {
            if self.isPlaying {
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: animationBlock, completion: { _ in
                    animate()
                })
            }
        }
        DispatchQueue.main.async {
            animate()
        }
    }
    
    private func playAudio() {
        switch mediaType {
        case let .frequency(frequency):
            audioManager.play(pureToneWithFrequency: frequency)
        case let .file(url):
            break
        }
    }
    
    private func pauseAudio() {
        switch mediaType {
        case let .frequency(frequency):
            audioManager.pause(pureToneWithFrequency: frequency)
        case let .file(url):
            break
        }
    }
}

public enum MediaType {
    case frequency(Int)
    case file(String)
}
