//
//  ViewController.swift
//  Fourier
//
//  Created by Blocry Glass on 3/15/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import UIKit
import AVFoundation
import SceneKit

class ViewController: UIViewController, AudioManagerDelegate {
    private var audioManager = AudioManager()
    private var spectrumView: SpectrumView?
    private var sceneView: SCNView!
    private var scene: SCNScene!
    private var materials = Materials()
    private var spectrumGraph3D: SpectrumGraph3D!
    
    func setup(subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = .gray
        view.addSubview(subView)
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: view.topAnchor),
            subView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let url = Bundle.main.url(forResource: "MDK - Fingerbang", withExtension: "mp3") {
            audioManager.play(fileWithURL: url)
        }
    }
    
    // MARK: AudioManager Delegation
    
    func didFourierTransform(_ audioManager: AudioManager, output: Array<Float>) {
        if sceneView != nil {
            spectrumGraph3D.updateColumnHeights(heightList: output)
        }
    }

}


//   if let url = Bundle.main.url(forResource: "Mirror", withExtension: "mp3") {
//   if let url = Bundle.main.url(forResource: "MDK - Fingerbang", withExtension: "mp3") {
//   if let url = Bundle.main.url(forResource: "Fouler_lhorizon", withExtension: "mp3") {
//   if let url = Bundle.main.url(forResource: "440and173", withExtension: "m4a") {
