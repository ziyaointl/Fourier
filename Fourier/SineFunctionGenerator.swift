//
//  SineFunctionGenerator.swift
//  Fourier
//
//  Created by Blocry Glass on 3/29/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation

public class SineFunctionGenerator {
    private static let yMultiplier = 30
    private static let xMultiplier = 0.05
    private static let baseFrequency = 440
    
    public static func generateSineForPlotting(withFrequency frequency: Int) -> ((Double) -> Double) {
        let generatedFunction: (Double) -> Double = { x in
            let x = x * xMultiplier * Double(frequency / baseFrequency)
            return sin(x) * Double(yMultiplier)
        }
        return generatedFunction
    }
}
