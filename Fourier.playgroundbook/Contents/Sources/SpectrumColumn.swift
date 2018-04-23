//
//  SpectrumColumn.swift
//  Fourier
//
//  Created by Ziyao Zhang on 3/17/18.
//  Copyright © 2018 Ziyao Zhang. All rights reserved.
//

import Foundation

public struct SpectrumColumn {
    private let initialHeight = Float(0)
    private var heightDelta: Float
    var height: Float {
        get {
            return initialHeight + heightDelta
        }
        set {
            heightDelta = newValue
        }
    }
    let width: Float
    let position: Float
    var centerPosition: Float {
        return position + width / 2
    }
    
    init(position: Float, width: Float, height: Float) {
        self.position = position
        self.width = width
        self.heightDelta = height
    }
}
