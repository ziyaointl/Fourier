//
//  SKMainUI.swift
//  Fourier
//
//  Created by Blocry Glass on 3/23/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation
import SpriteKit

class SKMainUI: SKScene {
    var state = UIState.hidden
    let animationDuration = 0.5
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.isPaused = false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if let touchedNode = self.nodes(at: touch.location(in: self)).first {
            if touchedNode.name == "infoButton" {
                infoButtonClicked()
            }
        }
        super.touchesEnded(touches, with: event)
    }
    
    private func infoButtonClicked() {
        let fadeIn = SKAction.fadeIn(withDuration: animationDuration)
        let fadeOut = SKAction.fadeOut(withDuration: animationDuration)
        let moveToDescription = SKAction.move(to: CGPoint(x: -357, y: 71), duration: animationDuration)
        let moveFromDescription = SKAction.move(to: CGPoint(x: -115,y: 227), duration: animationDuration)
        let scale = SKAction.scale(to: 0.4, duration: animationDuration)
        let scaleBack = SKAction.scale(to: 1.0, duration: animationDuration)
        let titleAnimation = SKAction.group([moveToDescription, scale])
        let titleAnimationReverse = SKAction.group([moveFromDescription, scaleBack])
        fadeIn.timingMode = .easeInEaseOut
        fadeOut.timingMode = .easeInEaseOut
        scale.timingMode = .easeInEaseOut
        scaleBack.timingMode = .easeInEaseOut
        moveToDescription.timingMode = .easeInEaseOut
        moveFromDescription.timingMode = .easeInEaseOut
        
        let titleNode = self.childNode(withName: "title")
        let descriptionNode = self.childNode(withName: "description")
        if state == .hidden {
            titleNode?.removeAllActions()
            titleNode?.run(titleAnimation) {
                descriptionNode?.removeAllActions()
                descriptionNode?.run(fadeIn)
            }
            state = .shown
        } else {
            descriptionNode?.removeAllActions()
            descriptionNode?.run(fadeOut) {
                titleNode?.removeAllActions()
                titleNode?.run(titleAnimationReverse)
            }
            state = .hidden
        }
    }
}

enum UIState {
    case shown
    case hidden
}
