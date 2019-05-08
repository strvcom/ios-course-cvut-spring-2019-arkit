//
//  EyeballMask.swift
//  AR Demo
//
//  Created by Jan on 08/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import ARKit
import SceneKit

class EyeballMask: SCNNode {
    var faceGeometry: ARSCNFaceGeometry? {
        return geometry as? ARSCNFaceGeometry
    }
    
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var leftEyeball: SCNNode!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var rightEyeball: SCNNode!

    private let eyeBallRadius: CGFloat = 0.02
    private var pupilRadius: CGFloat {
        return eyeBallRadius/3
    }

    init(geometry: ARSCNFaceGeometry) {
        super.init()
        
        geometry.firstMaterial?.colorBufferWriteMask = []
        self.geometry = geometry
        
        leftEyeball = createEyeball()
        rightEyeball = createEyeball()
        
        addChildNode(leftEyeball)
        addChildNode(rightEyeball)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func update(with anchor: ARFaceAnchor) {
        faceGeometry?.update(from: anchor.geometry)
        updateEyeballs(with: anchor)
    }
}

// MARK: Private methods
private extension EyeballMask {
    func createEyeball() -> SCNNode {
        let eyeball = SCNSphere(radius: eyeBallRadius)
        
        let material = SCNMaterial()
        material.lightingModel = .physicallyBased
        material.diffuse.contents = UIColor.white
        material.roughness.contents = NSNumber(value: 0)
        material.metalness.contents = NSNumber(value: 0.5)

        eyeball.materials = [material]
        
        let node = SCNNode(geometry: eyeball)
        
        let pupilNode = createPupil()
        pupilNode.position = SCNVector3(0, 0, eyeBallRadius)
        node.addChildNode(pupilNode)
        
        return node
    }
    
    func createPupil() -> SCNNode {
        let pupil = SCNSphere(radius: pupilRadius)
        
        let material = SCNMaterial()
        material.lightingModel = .physicallyBased
        material.diffuse.contents = UIColor.black
        material.roughness.contents = NSNumber(value: 0)
        material.metalness.contents = NSNumber(value: 1)
        
        pupil.materials = [material]
        
        let node = SCNNode(geometry: pupil)
        return node
    }
    
    func updateEyeballs(with anchor: ARFaceAnchor) {
        let leftEyeMatrix = SCNMatrix4(anchor.leftEyeTransform)
        let rightEyeMatrix = SCNMatrix4(anchor.rightEyeTransform)
        
        update(eyeball: leftEyeball, with: leftEyeMatrix)
        update(eyeball: rightEyeball, with: rightEyeMatrix)
    }
    
    func update(eyeball: SCNNode, with transform: SCNMatrix4) {
        eyeball.transform = transform
        eyeball.position.z += Float(eyeBallRadius/2)
    }
}
