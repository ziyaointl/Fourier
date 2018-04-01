//
//  PlotView.swift
//  Fourier
//
//  Created by Ziyao Zhang on 3/26/18.
//  Copyright © 2018 Ziyao Zhang. All rights reserved.
//

import UIKit

public class PlotView: UIView {
    override public class var layerClass: AnyClass {
        return PlotLayer.self
    }
    
    @objc private var plotLayer: PlotLayer {
        return layer as! PlotLayer
    }
    
    @objc public dynamic var offset: CGFloat = 0.0 {
        didSet {
            plotLayer.offset = offset
        }
    }
    
    public var currentFunction: ((Double) -> Double)! {
        didSet {
            plotLayer.currentFunction = currentFunction
        }
    }
    
    public var includeNegativeYAxis: Bool = false {
        didSet {
            plotLayer.includeNegativeYAxis = includeNegativeYAxis
        }
    }
    
    override public func action(for layer: CALayer, forKey event: String) -> CAAction? {
        if event == #keyPath(offset) {
            // Check to see if there's a running animation block
            if let action = super.action(for: layer, forKey: #keyPath(backgroundColor)) as? CAAnimation {
                let animation = CABasicAnimation()
                animation.keyPath = event
                animation.fromValue = plotLayer.offset
                animation.toValue = offset
                animation.beginTime = action.beginTime
                animation.duration = action.duration
                animation.speed = action.speed
                animation.timeOffset = action.timeOffset
                animation.repeatCount = action.repeatCount
                animation.repeatDuration = action.repeatDuration
                animation.autoreverses = action.autoreverses
                animation.fillMode = action.fillMode
                animation.timingFunction = action.timingFunction
                animation.delegate = action.delegate
                self.layer.add(animation, forKey: event)
            }
        }
        return super.action(for: layer, forKey: event)
    }
}

public class PlotLayer: CALayer {
    @NSManaged var offset: CGFloat
    public var includeNegativeYAxis = false
    public var currentFunction: ((Double) -> Double) = {x in return 0.0}
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        if let layer = layer as? PlotLayer {
            offset = layer.offset
            currentFunction = layer.currentFunction
            includeNegativeYAxis = layer.includeNegativeYAxis
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public class func needsDisplay(forKey key: String) -> Bool {
        if (key == #keyPath(offset)) {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
    
    override public func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        UIGraphicsPushContext(ctx)
        
        let path = UIBezierPath()
        let maxY = includeNegativeYAxis ? self.bounds.maxY / 2 : self.bounds.maxY
        let minX = self.bounds.minX
        let maxX = self.bounds.maxX
        path.move(to: CGPoint(x: Double(minX), y: Double(maxY) - currentFunction(Double(minX + offset))))
        for x in Int(minX)...Int(maxX) {
            path.addLine(to: CGPoint(x: Double(x), y: Double(maxY) - currentFunction(Double(x) + Double(offset))))
        }
        path.lineWidth = 1.0
        path.stroke()
        
        UIGraphicsPopContext()
    }
}
