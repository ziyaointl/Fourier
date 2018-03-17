//
//  Materials.swift
//  Fourier
//
//  Created by Blocry Glass on 3/17/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation
import SceneKit

struct Materials {
    let physicallyBasedWhiteMaterial = SCNMaterial()
    
    init() {
        physicallyBasedWhiteMaterial.lightingModel = .physicallyBased
        physicallyBasedWhiteMaterial.diffuse.contents = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        physicallyBasedWhiteMaterial.roughness.contents = 0.85
        physicallyBasedWhiteMaterial.metalness.contents = 0.0
    }
}
