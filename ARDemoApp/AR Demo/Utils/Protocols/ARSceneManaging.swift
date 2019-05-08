//
//  ARSceneManaging.swift
//  AR Demo
//
//  Created by Jan on 06/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import Foundation
import ARKit

protocol ARSceneManaging: ARSessionDelegate {
    func resetSession()
}

extension UIViewController {
    @objc func session(_ session: ARSession, didFailWithError error: Error) {
        print("ARSession error - \(error)")
    }
    
    @objc func sessionWasInterrupted(_ session: ARSession) {
        print("ARSession was interrupted")
    }
    
    @objc func sessionInterruptionEnded(_ session: ARSession) {
        print("ARSession interruption ended")
        
        if let self = self as? ARSceneManaging {
            self.resetSession()
        }
    }
    
    @objc func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print("ARSession tracking state changed: \(camera.trackingState)")
    }
}
