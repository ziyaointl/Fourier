//
//  SpectrumView.swift
//  Fourier
//
//  Created by Ziyao Zhang on 3/15/18.
//  Copyright © 2018 Ziyao Zhang. All rights reserved.
//

import UIKit

// How to use SpectrumView
//
// In viewDidLoad()
//        spectrumView = SpectrumView()
//        setup(subView: spectrumView!)
// In didFourierTransform()
//        if spectrumView != nil {
//            spectrumView!.points = output
//            DispatchQueue.main.async {
//                self.spectrumView!.setNeedsDisplay()
//            }
//        }

class SpectrumView: UIView {

    var points = [Float]()
    
    override func draw(_ rect: CGRect) {
        let offset: CGFloat = 30
        UIColor.black.setFill()
        UIColor.black.setStroke()
        if points.count > 0 {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: CGFloat(offset), y: CGFloat(0)))
            for i in 0..<points.count {
                path.addLine(to: CGPoint(x: log10(CGFloat(i + 1)) * 200 + 3 * offset, y: CGFloat(self.points[i])))
                
            }
            path.lineWidth = 1
            path.stroke()
        }
    }

}
