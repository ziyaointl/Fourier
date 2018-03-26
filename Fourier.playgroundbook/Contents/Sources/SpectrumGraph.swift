//
//  SpectrumGraph.swift
//  Fourier
//
//  Created by Blocry Glass on 3/17/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation

public class SpectrumGraph {
    var columns = [SpectrumColumn]()
    
    init(numberOfColumns: UInt, widthPerColumn: Float, columnOffset: Float) {
        let graphWidth: Float
        if numberOfColumns == 0 {
            print("Illegal number of columns")
            return
        } else if numberOfColumns == 1 {
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
    
    func updateColumnHeights(heightList: [Float]) {
        var bins = [Double](repeating: 0.0, count: columns.count)
        let e = 2.71828
        let base = pow(e, log(Double(heightList.count))/Double(columns.count))
        var heightIndex = 0
        var currBinSize = 0
        for i in 1...columns.count {
            let maxHeightIndex = pow(base, Double(i))
            while heightIndex <= Int(maxHeightIndex) && currBinSize < 10 {
                bins[i - 1] += Double(heightList[heightIndex])
                heightIndex += 1
                currBinSize += 1
            }
            bins[i - 1] /= Double(currBinSize)
            bins[i - 1] = log2(bins[i - 1] + 2) * 3.0 - 2.8
            currBinSize = 0
            heightIndex = Int(maxHeightIndex)
        }
        
        for i in columns.indices {
            columns[i].height = Float(bins[i])
        }
    }
}
