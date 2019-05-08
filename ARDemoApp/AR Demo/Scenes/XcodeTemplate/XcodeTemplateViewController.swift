//
//  ViewController.swift
//  jkfjdlfjsdjls
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class XcodeTemplateViewController: UIViewController, ARSCNViewDelegate, NibNameIdentifiable {

    @IBOutlet private var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("XCODE_TEMPLATE", comment: "")
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        // swiftlint:disable:next force_unwrapping
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
