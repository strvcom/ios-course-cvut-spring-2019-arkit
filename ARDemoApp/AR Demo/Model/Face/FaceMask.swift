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
    enum Texture {
        case basic(color: UIColor)
        case metalic(color: UIColor)
        case zombie
    }
    
    var faceGeometry: ARSCNFaceGeometry? {
        return geometry as? ARSCNFaceGeometry
    }
    
    private let zombieDiffusePath = "face.scnassets/Materials/Diffuse.png"
    private let zombieNormalPath = "face.scnassets/Materials/Normal.png"

    init(geometry: ARSCNFaceGeometry, texture: Texture) {
        super.init()
        
        let material = createMaterial(for: texture)
        geometry.materials = [material]
        
        self.geometry = geometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func update(with anchor: ARFaceAnchor) {
        faceGeometry?.update(from: anchor.geometry)
    }
    
    func update(with texture: Texture) {
        let material = createMaterial(for: texture)
        faceGeometry?.materials = [material]
    }
}

// MARK: Private methods
private extension FaceMask {
    func createMaterial(for texture: Texture) -> SCNMaterial {
        let material = SCNMaterial()
        material.lightingModel = .physicallyBased
        
        switch texture {
        case .basic(let color):
            material.diffuse.contents = color
            material.roughness.contents = NSNumber(value: 1)
            material.metalness.contents = NSNumber(value: 0)
        case .metalic(let color):
            material.diffuse.contents = color
            material.roughness.contents = NSNumber(value: 0)
            material.metalness.contents = NSNumber(value: 1)
        case .zombie:
            material.diffuse.contents = zombieDiffusePath
            material.normal.contents = zombieNormalPath
        }
        
        return material
    }
}
