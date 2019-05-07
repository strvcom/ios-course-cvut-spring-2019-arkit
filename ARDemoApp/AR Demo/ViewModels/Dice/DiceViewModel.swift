//
//  DiceViewModel.swift
//  AR Demo
//
//  Created by Jan on 06/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class DiceViewModel: DiceViewModeling {
    private let diceMaterialPath = "dice.scnassets/Materials/Cube"
    private let diceNodeName = "dice"
    
    func createPlaneNode(for anchor: ARPlaneAnchor, with color: UIColor) -> SCNNode {
        let plane = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        
        let material = SCNMaterial()
        material.diffuse.contents = color
        
        plane.materials = [material]
        
        let node = SCNNode(geometry: plane)
        positionAndTransform(planeNode: node, for: anchor)
        
        return node
    }
    
    func update(planeNode: SCNNode, for anchor: ARPlaneAnchor) {
        guard let plane = planeNode.geometry as? SCNPlane else {
            print("Node \(planeNode) doesn't contain a plane")
            return
        }
        
        plane.width = CGFloat(anchor.extent.x)
        plane.height = CGFloat(anchor.extent.z)
        
        positionAndTransform(planeNode: planeNode, for: anchor)
    }
    
    func createCube(of size: CGFloat) -> SCNNode {
        let size: CGFloat = 0.1
        let box = SCNBox(width: size, height: size, length: size, chamferRadius: 0)
        
        let materials = Array(1...6).map({ index -> SCNMaterial in
            let material = SCNMaterial()
            material.diffuse.contents = "\(self.diceMaterialPath)\(index).png"
            return material
        })
        box.materials = materials
        
        let node = SCNNode(geometry: box)
        
        return node
    }
}

// MARK: Private methods
private extension DiceViewModel {
    func positionAndTransform(planeNode: SCNNode, for anchor: ARPlaneAnchor) {
        planeNode.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        
        switch anchor.alignment {
        case .horizontal:
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
        case .vertical:
            break
        @unknown default:
            break
        }
    }
}
