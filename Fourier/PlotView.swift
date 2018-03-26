//
//  PlotView.swift
//  Fourier
//
//  Created by Blocry Glass on 3/26/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import UIKit

public class PlotView: UIView {
    public var currentFunction: ((Double) -> Double)!
    public var includeNegativeYAxis = false
    
    private var minX: Double {
        return Double(self.bounds.minX)
    }
    private var maxX: Double {
        return Double(self.bounds.maxX)
    }
    
    override public func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let maxY = includeNegativeYAxis ? self.bounds.maxY / 2 : self.bounds.maxY
        path.move(to: CGPoint(x: minX, y: Double(maxY) - currentFunction(minX)))
        for x in Int(minX)...Int(maxX) {
            path.addLine(to: CGPoint(x: Double(x), y: Double(maxY) - currentFunction(Double(x))))
        }
        path.lineWidth = 1.0
        path.stroke()
    }
}
