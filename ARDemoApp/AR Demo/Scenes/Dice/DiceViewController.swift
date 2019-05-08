//
//  DiceViewController.swift
//  AR Demo
//
//  Created by Jan on 06/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class DiceViewController: UIViewController, NibNameIdentifiable {
    @IBOutlet private weak var sceneView: ARSCNView!
    
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: DiceViewModeling!
    
    private let planeColor = UIColor.red.withAlphaComponent(0.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: Actions
private extension DiceViewController {
    @objc func didTapOnResetButton() {
        removeDiceFromScene()
        resetSession()
    }
    
    @objc func didTapOnScene(_ recognizer: UITapGestureRecognizer) {
        guard let frame = self.sceneView.session.currentFrame else {
            print("Unable to get current frame")
            return
        }
        
        let touch = recognizer.location(in: sceneView)
        let hits = sceneView.hitTest(touch, types: .existingPlaneUsingExtent)
        
        guard let hit = hits.first else {
            print("Hit test didn't find any plane")
            return
        }
        
        stopPlaneDetection()
        removeDiceFromScene()
        
        let cube = viewModel.createCube(of: 0.05)
        
        let deviceTransform = SCNMatrix4(frame.camera.transform)
        let hitTrannsform = SCNMatrix4(hit.worldTransform)

        cube.position = SCNVector3(deviceTransform.m41, deviceTransform.m42, deviceTransform.m43)
        cube.eulerAngles = SCNVector3(Double.random(in: 0...Double.pi), Double.random(in: 0...Double.pi), Double.random(in: 0...Double.pi))
        
        let throwDirection = SCNVector3(
            hitTrannsform.m41 - deviceTransform.m41,
            hitTrannsform.m42 - deviceTransform.m42,
            hitTrannsform.m43 - deviceTransform.m43
        )
        cube.physicsBody?.resetTransform()
        cube.physicsBody?.applyForce(throwDirection, asImpulse: true)
        
        sceneView.scene.rootNode.addChildNode(cube)
    }
}

// MARK: AR scene managing
extension DiceViewController: ARSceneManaging {
    func resetSession() {
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.worldAlignment = .gravity
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func stopPlaneDetection() {
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.worldAlignment = .gravity
        configuration.planeDetection = []
        
        sceneView.session.run(configuration)
    }
    
    func removeDiceFromScene() {
        for node in sceneView.scene.rootNode.childNodes where node.name == viewModel.diceNodeName {
            node.removeFromParentNode()
        }
    }
}

// MARK: ARSceneViewDelegate
extension DiceViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let anchor = anchor as? ARPlaneAnchor else {
            return
        }
        
        DispatchQueue.main.async {
            let plane = self.viewModel.createPlaneNode(for: anchor, with: self.planeColor)
            node.addChildNode(plane)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let anchor = anchor as? ARPlaneAnchor else {
            return
        }
        
        DispatchQueue.main.async {
            node.childNodes.forEach({ self.viewModel.update(planeNode: $0, for: anchor) })
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else {
            return
        }
        
        node.childNodes.forEach({ $0.removeFromParentNode() })
    }
}

// MARK: Setup
private extension DiceViewController {
    func setup() {
        navigationItem.title = NSLocalizedString("DICE_GAME", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("RESET", comment: ""), style: .plain, target: self, action: #selector(self.didTapOnResetButton))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnScene(_:)))
        sceneView.addGestureRecognizer(tap)
        
        sceneView.delegate = self

        resetSession()
    }
}
