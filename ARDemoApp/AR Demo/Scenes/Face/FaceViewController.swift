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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
         UIApplication.shared.isIdleTimerDisabled = false
    }
}

// MARK: Actions
private extension FaceViewController {
    @objc func didTapOnResetButton() {
        resetSession()
    }
}

// MARK: AR Scene managing
extension FaceViewController: ARSceneManaging {
    func resetSession() {
        let configuration = ARFaceTrackingConfiguration()
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

// MARK: ARSceneViewDelegate
extension FaceViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARFaceAnchor else {
            return
        }
        
        guard let device = renderer.device,
            let mask = viewModel.createFaceMask(with: device, color: .red) else {
            return
        }
        
        DispatchQueue.main.async {
            node.addChildNode(mask)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARFaceAnchor else {
            return
        }
        
        DispatchQueue.main.async {
            node.childNodes.forEach({ $0.removeFromParentNode() })
        }
    }
}

// MARK: Setup
private extension FaceViewController {
    func setup() {
        navigationItem.title = NSLocalizedString("FACE_TRACKING", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("RESET", comment: ""), style: .plain, target: self, action: #selector(self.didTapOnResetButton))

        sceneView.delegate = self
        
        resetSession()
    }
}
