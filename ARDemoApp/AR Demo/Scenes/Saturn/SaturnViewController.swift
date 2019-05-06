//
//  SaturnViewController.swift
//  AR Demo
//
//  Created by Jan on 06/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class SaturnViewController: UIViewController, NibNameIdentifiable {
    @IBOutlet private weak var sceneView: ARSCNView!
    
    private let sceneName = "saturn.scnassets/saturn.scn"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: Setup
private extension SaturnViewController {
    func setup() {
        navigationItem.title = NSLocalizedString("SATURN", comment: "")
        
        loadScene()
        
        resetSession()
    }
    
    func loadScene() {
        if let scene = SCNScene(named: sceneName) {
            sceneView.scene = scene
        }
    }
    
    func resetSession() {
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.worldAlignment = .gravity
        
        sceneView.session.run(configuration, options: [.resetTracking])
    }
}
