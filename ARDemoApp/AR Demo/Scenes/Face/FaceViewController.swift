//
//  FaceViewController.swift
//  AR Demo
//
//  Created by Jan on 08/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class FaceViewController: UIViewController, NibNameIdentifiable {
    @IBOutlet private weak var sceneView: ARSCNView!
    
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: FaceViewModeling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: AR Scene managing
extension FaceViewController: ARSceneManaging {
    func resetSession() {
        let configuration = ARFaceTrackingConfiguration()
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

// MARK: Setup
private extension FaceViewController {
    func setup() {
        navigationItem.title = NSLocalizedString("FACE_TRACKING", comment: "")
        
        sceneView.session.delegate = self
        
        resetSession()
    }
}
