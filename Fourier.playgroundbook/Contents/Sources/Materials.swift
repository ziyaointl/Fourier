//
//  Materials.swift
//  Fourier
//
//  Created by Blocry Glass on 3/17/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation
import SceneKit

public struct Materials {
    public let physicallyBasedWhiteMaterial = SCNMaterial()
    
    public init() {
        physicallyBasedWhiteMaterial.lightingModel = .physicallyBased
        physicallyBasedWhiteMaterial.diffuse.contents = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        physicallyBasedWhiteMaterial.roughness.contents = 0.85
        physicallyBasedWhiteMaterial.metalness.contents = 0.0
    }
}
