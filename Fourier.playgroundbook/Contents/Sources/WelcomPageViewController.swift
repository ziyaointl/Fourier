import UIKit
import SceneKit

public class WelcomPageViewController: UIViewController, AudioManagerDelegate {
    private var audioManager = AudioManager()
    private var scene: SCNScene!
    private var materials = Materials()
    private var spectrumGraph3D: SpectrumGraph3D!
    private var cameraController: CustomCameraController!
    private var sceneView: SCNView!
    
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
        cameraNode.camera?.exposureOffset = -0.8
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 25)
        cameraOrbitNode.position = SCNVector3(x: 0, y: 5, z: -8)
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
    
    public override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        audioManager.delegate = self
        audioManager.installTap = true
        scene = SCNScene()
        setup(scene: scene)
        sceneView = SCNView()
        sceneView.scene = scene
        setup(subView: sceneView)
        
        // Gesture Recognizer
        let panGestureRecognizer = UIPanGestureRecognizer(target: cameraController, action: #selector(cameraController.handlePanGesture(sender:)))
        view.addGestureRecognizer(panGestureRecognizer)
        
        // Audio
        if let url = Bundle.main.url(forResource: "Mike_Durek_A_Cool_Rainy_Night", withExtension: "mp3") {
            audioManager.play(fileWithURL: url, completionHandler: nil)
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: AudioManager Delegation
    
    public func didFourierTransform(_ audioManager: AudioManager, output: Array<Float>) {
        if sceneView != nil {
            spectrumGraph3D.updateColumnHeights(heightList: output)
        }
    }
    
}
