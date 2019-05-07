//
//  DiceViewModeling.swift
//  AR Demo
//
//  Created by Jan on 06/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

protocol DiceViewModeling {
    var diceNodeName: String { get }
    
    func createPlaneNode(for anchor: ARPlaneAnchor, with color: UIColor) -> SCNNode
    func update(planeNode: SCNNode, for anchor: ARPlaneAnchor)
    func createCube(of size: CGFloat) -> SCNNode
}
