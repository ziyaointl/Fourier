//
//  CustomCameraController.swift
//  Fourier
//
//  Created by Blocry Glass on 3/22/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation
import SceneKit

class CustomCameraController {
    var previousWidthRatio: Float = 0.0
    var previousHeightRatio: Float = 0.0
    var lookAtNode: SCNNode!
    
    init(for node: SCNNode) {
        lookAtNode = node
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: sender.view!)
        let widthRatio = Float(translation.x) / Float(sender.view!.frame.size.width) + previousWidthRatio
        let heightRatio = Float(translation.y) / Float(sender.view!.frame.size.height) + previousHeightRatio
        lookAtNode.eulerAngles.y = Float(-2 * Double.pi) * widthRatio
        lookAtNode.eulerAngles.x = Float(-2 * Double.pi) * heightRatio
        if (sender.state == .ended) {
            previousWidthRatio = widthRatio
            previousHeightRatio = heightRatio
        }
    }
}
