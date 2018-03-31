//
//  WaveFormAndFFTViewController.swift
//  Fourier
//
//  Created by Blocry Glass on 3/31/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import UIKit

public class WaveFormAndFFTViewController: UIViewController, AudioManagerDelegate {
    public var mediaType = MediaType.file(Constants.Resources.PianoNoteURL)
    private var mainView: WaveFormAndFFTView!
    private var plotView: PlotView!
    private var waveFormView: WaveformView!
    private var waveFormViewController: WaveformViewController!
    
    override public func loadView() {
        super.loadView()
        mainView = WaveFormAndFFTView()
        view = mainView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        waveFormViewController = WaveformViewController()
        mainView.waveFormView.fillSelfWith(subView: waveFormViewController.view)
        self.waveFormView = waveFormViewController.view as! WaveformView!
        
        plotView = mainView.plotView
        plotView.backgroundColor = Constants.Colors.LightGray
        plotView.contentMode = .redraw
        
        waveFormViewController.mediaType = mediaType
        switch mediaType {
        case let .frequency(frequency):
            waveFormViewController.titleText = String(frequency) + " Hz"
            waveFormViewController.currentFunction = FunctionGenerator.generateSineForPlotting(withFrequency: 440)
        case .file(_):
            waveFormViewController.titleText = Constants.StringLiterals.PianoA4
            waveFormViewController.currentFunction = FunctionGenerator.generatePianoA4ForPlotting()
        }
        waveFormViewController.fftResultReceiver = self
    }
    
    public func didFourierTransform(_ audioManager: AudioManager, output: Array<Float>) {
        DispatchQueue.main.async { [weak self] in
            self?.plotView.currentFunction = { x in
                let x = Int(x)
                if x < output.count {
                    return Double(output[x]) * 0.6
                }
                return 0.0
            }
            self?.plotView.layer.setNeedsDisplay()
        }
    }
}
