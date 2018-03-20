//
//  SpectrumGraph3D.swift
//  Fourier
//
//  Created by Blocry Glass on 3/17/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation
import SceneKit

class SpectrumGraph3D: SpectrumGraph {
    var rootNode = SCNNode()
    private var columns3D = [SCNBox]()
    private var columnNodes = [SCNNode]()
    private var materials = Materials()
    
    override init(numberOfColumns: UInt, widthPerColumn: Float, columnOffset: Float) {
        super.init(numberOfColumns: numberOfColumns, widthPerColumn: widthPerColumn, columnOffset: columnOffset)
        for column in columns {
            // Create column node
            let columnNode = createColumnNode(width: CGFloat(widthPerColumn), height: CGFloat(column.height))
            // Move column to the right position
            columnNode.position = SCNVector3(x: Float(column.centerPosition), y: 0.0, z: 0.0)
            // Add columnNode to rootNode
            rootNode.addChildNode(columnNode)
        }
    }
    
    override func updateColumnHeights(heightList: [Float]) {
        super.updateColumnHeights(heightList: heightList)
        
        SCNTransaction.animationDuration = 0.1
        SCNTransaction.begin()
        for index in columns.indices {
            columns3D[index].height = CGFloat(columns[index].height)
            columnNodes[index].pivot = SCNMatrix4MakeTranslation(0, Float(-columns[index].height / 2), 0)
        }
        SCNTransaction.commit()
    }
    
    private func createColumnNode(width: CGFloat, height: CGFloat) -> SCNNode {
        // Initialize
        let box = SCNBox(width: width, height: height, length: width, chamferRadius: 0.05)
        let boxNode = SCNNode()
        columns3D.append(box)
        columnNodes.append(boxNode)
        boxNode.geometry = box
        
        // Apply material
        box.firstMaterial = materials.physicallyBasedWhiteMaterial
        
        // Move pivot to the bottom of the column
        boxNode.pivot = SCNMatrix4MakeTranslation(0, Float(-(box.height/2)), 0)

        return boxNode
    }
}
