//
//  FaceMask.swift
//  AR Demo
//
//  Created by Jan on 08/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import ARKit
import SceneKit

class FaceMask: SCNNode {
    var faceGeometry: ARSCNFaceGeometry? {
        return geometry as? ARSCNFaceGeometry
    }
    
    init(geometry: ARSCNFaceGeometry, color: UIColor) {
        super.init()
        
        let material = geometry.firstMaterial
        material?.lightingModel = .physicallyBased
        material?.diffuse.contents = color
        
        self.geometry = geometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func update(with anchor: ARFaceAnchor) {
        faceGeometry?.update(from: anchor.geometry)
    }
}
