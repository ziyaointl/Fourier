//
//  ViewController.swift
//  Fourier
//
//  Created by Blocry Glass on 3/15/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import UIKit
import AVFoundation
import Accelerate

class ViewController: UIViewController, AudioManagerDelegate {
    private var audioManager = AudioManager()

    @IBOutlet private weak var spectrumView: SpectrumView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let url = Bundle.main.url(forResource: "Mirror", withExtension: "mp3") {
            audioManager.play(fileWithURL: url)
        }
    }
    
    // MARK: AudioManager Delegation
    
    func didFourierTransform(_ audioManager: AudioManager, output: Array<Float>) {
        if spectrumView != nil {
            spectrumView.points = output
            DispatchQueue.main.async {
                self.spectrumView.setNeedsDisplay()
            }
        }
    }


}


//   if let url = Bundle.main.url(forResource: "Mirror", withExtension: "mp3") {
//   if let url = Bundle.main.url(forResource: "MDK - Fingerbang", withExtension: "mp3") {
//   if let url = Bundle.main.url(forResource: "Fouler_lhorizon", withExtension: "mp3") {
//   if let url = Bundle.main.url(forResource: "440and173", withExtension: "m4a") {
