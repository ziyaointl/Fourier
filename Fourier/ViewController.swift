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
import SpriteKit

class ViewController: UIViewController, AudioManagerDelegate {
    private var audioManager = AudioManager()
    private var spectrumView: SpectrumView?
    private var scene: SCNScene!
    private var materials = Materials()
    private var spectrumGraph3D: SpectrumGraph3D!
    private var cameraController: CustomCameraController!
    private var descriptionState: ViewState = .hidden
    private var titleAnimation: UIViewPropertyAnimator!
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var mainUIView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    private func setup(subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subView)
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: view.topAnchor),
            subView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    private func setup(scene: SCNScene) {
        // Set up enviornment lighting
        let lightMap = #imageLiteral(resourceName: "studio021")
        scene.lightingEnvironment.contents = lightMap
        scene.lightingEnvironment.intensity = 2.0
        scene.background.contents = #colorLiteral(red: 0.9027006662, green: 0.9027006662, blue: 0.9027006662, alpha: 1)
        
        // Set up camera
        let cameraNode = SCNNode()
        let cameraOrbitNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.wantsHDR = true
        cameraNode.camera?.wantsExposureAdaptation = false
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 25)
        cameraOrbitNode.position = SCNVector3(x: 0, y: 0, z: -8)
        scene.rootNode.addChildNode(cameraOrbitNode)
        cameraOrbitNode.addChildNode(cameraNode)
        cameraController = CustomCameraController(for: cameraOrbitNode)
        
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
        spectrumGraph3D = SpectrumGraph3D(numberOfColumns: 15, widthPerColumn: 1, columnOffset: 0.2)
        scene.rootNode.addChildNode(spectrumGraph3D.rootNode)
        
        // Set up light
        let light = SCNLight()
        light.castsShadow = true
        light.type = .spot
        light.intensity = 300
        light.spotOuterAngle = 90.0
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(13, 10, -13)
        lightNode.eulerAngles = SCNVector3(-2.096, -0.40739, -0.6852)
        scene.rootNode.addChildNode(lightNode)
        
        // Add constraints (does not work)
        // let constraint = SCNLookAtConstraint(target: scene.rootNode)
        // constraint.isGimbalLockEnabled = true
        // lightNode.constraints?.append(constraint)
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        if descriptionState == .shown {
            titleAnimation.isReversed = true
            descriptionState = .hidden
        } else {
            titleAnimation.isReversed = false
            descriptionState = .shown
        }
        
        titleAnimation.startAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioManager.delegate = self
        scene = SCNScene()
        setup(scene: scene)
        sceneView.scene = scene
        sceneView.showsStatistics = true
        
        // Gesture Recognizer
        let panGestureRecognizer = UIPanGestureRecognizer(target: cameraController, action: #selector(cameraController.handlePanGesture(sender:)))
        mainUIView.addGestureRecognizer(panGestureRecognizer)
        
        // Animation
        titleAnimation = UIViewPropertyAnimator.init(duration: 1.0, curve: .easeInOut, animations: { [weak self] in
            self?.titleLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self?.titleLabel.center = CGPoint(x: 180, y: 353)
            self?.descriptionLabel.alpha = 1.0
            self?.continueButton.alpha = 1.0
        })
        titleAnimation.pausesOnCompletion = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let url = Bundle.main.url(forResource: "Julie_Maxwells_Starry_Sky", withExtension: "m4a") {
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

enum ViewState {
    case hidden
    case shown
}

