//
//  CustomCameraController.swift
//  Fourier
//
//  Created by Ziyao Zhang on 3/22/18.
//  Copyright © 2018 Ziyao Zhang. All rights reserved.
//

import Foundation
import SceneKit

public class CustomCameraController {
    var previousWidthRatio: Float = 0.0
    var previousHeightRatio: Float = 0.0
    var lookAtNode: SCNNode!
    let maximumHeightRatio: Float = 0.41
    let minimumHeightRatio: Float = 0.23
    var initialHeightRatio: Float {
        return (maximumHeightRatio + minimumHeightRatio) / 2
    }
    
    public init(for node: SCNNode) {
        lookAtNode = node
        // Initialize position
        lookAtNode.eulerAngles.x = -Float.pi * maximumHeightRatio
        previousHeightRatio = maximumHeightRatio
    }
    
    @objc public func handlePanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: sender.view!)
        let heightRatio = Float(translation.y) / Float(sender.view!.frame.size.height) + previousHeightRatio
        if heightRatio < maximumHeightRatio && heightRatio > minimumHeightRatio {
            lookAtNode.eulerAngles.x = -Float.pi * heightRatio
            if (sender.state == .ended) {
                previousHeightRatio = heightRatio
            }
        } else if (sender.state == .ended) {
            previousHeightRatio = lookAtNode.eulerAngles.x / (-Float.pi)
        }
    }
}
