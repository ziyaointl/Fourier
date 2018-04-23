//
//  FunctionGenerator.swift
//  Fourier
//
//  Created by Ziyao Zhang on 3/29/18.
//  Copyright © 2018 Ziyao Zhang. All rights reserved.
//

import Foundation

public class FunctionGenerator {
    private static let yMultiplier = 30
    private static let xMultiplier = 0.05
    private static let baseFrequency = 440
    
    public static func generateSineForPlotting(withFrequency frequency: Int) -> ((Double) -> Double) {
        let generatedFunction: (Double) -> Double = { x in
            let x = x * xMultiplier * (Double(frequency) / Double(baseFrequency))
            return sin(x) * Double(yMultiplier)
        }
        return generatedFunction
    }
    
    public static func generatePianoA4ForPlotting() -> ((Double) -> Double) {
        let buffer = AudioManager.getBufferOf(fileWithURL: Constants.Resources.PianoNoteURL)
        let currentFunc: (Double) -> Double = { x in
            if UInt32(x) > buffer.frameCapacity {
                return 0.0
            }
            return Double(buffer.floatChannelData![0][Int(x)] * 200)
        }
        return currentFunc
    }
}
