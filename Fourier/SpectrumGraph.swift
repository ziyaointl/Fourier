//
//  SpectrumGraph.swift
//  Fourier
//
//  Created by Blocry Glass on 3/17/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation

class SpectrumGraph {
    var columns = [SpectrumColumn]()
    
    init(numberOfColumns: UInt, widthPerColumn: Float, columnOffset: Float) {
        let graphWidth: Float
        if numberOfColumns == 0 {
            print("Illegal number of columns")
            return
        } else if numberOfColumns == 1{
            graphWidth = Float(widthPerColumn)
        } else {
            graphWidth = widthPerColumn * Float(numberOfColumns) + columnOffset * Float(numberOfColumns - 1)
        }
        
        var currentPosition = -(graphWidth / 2)
        for _ in 0..<numberOfColumns {
            columns.append(SpectrumColumn(position: currentPosition, width: Float(widthPerColumn), height: 0.0))
            currentPosition += widthPerColumn + columnOffset
        }
    }
    
}
