//
//  SpectrumGraph3D.swift
//  Fourier
//
//  Created by Blocry Glass on 3/17/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation
import SceneKit

public class SpectrumGraph3D: SpectrumGraph {
    public var rootNode = SCNNode()
    private var columns3D = [SCNShape]()
    private var columnNodes = [SCNNode]()
    private var materials = Materials()
    
    public override init(numberOfColumns: UInt, widthPerColumn: Float, columnOffset: Float) {
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
    
    public override func updateColumnHeights(heightList: [Float]) {
        super.updateColumnHeights(heightList: heightList)
        
        SCNTransaction.animationDuration = 0.1
        SCNTransaction.begin()
        for index in columns.indices {
            columns3D[index].extrusionDepth = CGFloat(columns[index].height)
            columnNodes[index].pivot = SCNMatrix4MakeTranslation(0, 0, Float((columns[index].height)/2))
        }
        SCNTransaction.commit()
    }
    
    private func createColumnNode(width: CGFloat, height: CGFloat) -> SCNNode {
        // Initialize
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: width), cornerRadius: 0.1)
        let shape = SCNShape(path: path, extrusionDepth: width)
        let boxNode = SCNNode()
        shape.chamferMode = .both
        columns3D.append(shape)
        boxNode.geometry = shape
        columnNodes.append(boxNode)
        boxNode.pivot = SCNMatrix4MakeTranslation(0, 0, Float(height/2))
        
        // Apply material
        shape.firstMaterial = materials.physicallyBasedWhiteMaterial

        return boxNode
    }
}
