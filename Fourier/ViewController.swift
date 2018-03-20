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
    
    func setup(scene: SCNScene) {
        // Set up enviornment lighting
        let lightMap = #imageLiteral(resourceName: "studio021")
        scene.lightingEnvironment.contents = lightMap
        scene.lightingEnvironment.intensity = 2.0
        scene.background.contents = #colorLiteral(red: 0.9027006662, green: 0.9027006662, blue: 0.9027006662, alpha: 1)
        
        // Set up camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.wantsHDR = true
        cameraNode.camera?.exposureOffset = 2
        cameraNode.camera?.wantsExposureAdaptation = false
        cameraNode.position = SCNVector3(x:0, y:1, z:10)
        cameraNode.camera?.screenSpaceAmbientOcclusionIntensity = 1.0
        scene.rootNode.addChildNode(cameraNode)
        
        // Set originNode
        let modelOriginNode = SCNNode()
        scene.rootNode.addChildNode(modelOriginNode)
        
        // Set up floor
        let floor = SCNFloor()
        let floorNode = SCNNode(geometry: floor)
        modelOriginNode.addChildNode(floorNode)
        floorNode.geometry?.firstMaterial = materials.physicallyBasedWhiteMaterial
        floor.reflectivity = 0
        
        // Set up spectrum
        spectrumGraph3D = SpectrumGraph3D(numberOfColumns: 10, widthPerColumn: 1, columnOffset: 0.2)
        scene.rootNode.addChildNode(spectrumGraph3D.rootNode)
        
        // Set up light
        let light = SCNLight()
        light.castsShadow = true
        light.type = .spot
        light.intensity = 300
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(-10, 10, 10)
        lightNode.eulerAngles = SCNVector3(-0.671183, -0.40739, 0.30485)
        lightNode.geometry = SCNBox(width: 0.1, height: 1, length: 0.1, chamferRadius: 0.0)
        scene.rootNode.addChildNode(lightNode)
        
        // Add constraints (does not work)
        // let constraint = SCNLookAtConstraint(target: scene.rootNode)
        // constraint.isGimbalLockEnabled = true
        // lightNode.constraints?.append(constraint)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioManager.delegate = self
        scene = SCNScene()
        setup(scene: scene)
        sceneView = SCNView()
        setup(subView: sceneView)
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
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
