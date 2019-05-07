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
        resetSession()
    }
    
    @objc func didTapOnScene(_ recognizer: UITapGestureRecognizer) {
        let touch = recognizer.location(in: sceneView)
        let hits = sceneView.hitTest(touch, types: .existingPlaneUsingExtent)
        
        guard let hit = hits.first else {
            print("Hit test didn't find any plane")
            return
        }
        
        let cube = viewModel.createCube(of: 0.05)

        let height = (cube.geometry as? SCNBox)?.height ?? 0
        cube.position = SCNVector3(hit.worldTransform.columns.3.x, hit.worldTransform.columns.3.y + Float(height/2), hit.worldTransform.columns.3.z)
        
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
