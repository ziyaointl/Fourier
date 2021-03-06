//
//  WaveformViewController.swift
//  Fourier
//
//  Created by Ziyao Zhang on 3/29/18.
//  Copyright © 2018 Ziyao Zhang. All rights reserved.
//

import UIKit

public class WaveformViewController: UIViewController, WaveformViewDelegate {
    private struct Icon {
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
    public var currentFunction: (Double) -> Double = {x in return 0.0} {
        didSet {
            if let plot = plotView {
                plot.currentFunction = currentFunction
            }
        }
    }
    public var fftResultReceiver: AudioManagerDelegate! {
        didSet {
            audioManager.installTap = true
            audioManager.delegate = fftResultReceiver
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
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playButton.layer.cornerRadius = playButton.bounds.width / 2
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Load font
        if !UIFont.familyNames.contains("Ionicons") {
            let url = Bundle.main.url(forResource: "ionicons", withExtension: "ttf")! as CFURL
            CTFontManagerRegisterFontsForURL(url, CTFontManagerScope.process, nil)
        }
        
        plotView = mainView.plotView
        plotView.includeNegativeYAxis = true
        plotView.contentMode = .redraw
        plotView.currentFunction = currentFunction
        
        playButton = mainView.playButton
        playButton.titleLabel?.font = UIFont(name: "Ionicons", size: 50)!
        playButton.layer.borderColor = Constants.Colors.DarkGray.cgColor
        playButton.layer.borderWidth = 2.0
        
        titleLabel = mainView.title
        titleLabel.text = titleText
        titleLabel.textColor = Constants.Colors.DarkGray
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
            self?.plotView.offset += 1600 * .pi
        }
        func animate() {
            if self.isPlaying {
                UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveLinear, .allowUserInteraction], animations: animationBlock, completion: { _ in
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
            audioManager.play(fileWithURL: url, completionHandler: { [weak self] in
                DispatchQueue.main.async {
                    self?.plotView.offset = 0
                }
            })
        }
    }
    
    private func pauseAudio() {
        audioManager.pause()
    }
}

public enum MediaType {
    case frequency(Int)
    case file(URL)
}

