//
//  FaceViewModel.swift
//  AR Demo
//
//  Created by Jan on 08/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import ARKit

class FaceViewModel: FaceViewModeling {
    func createFaceMask(with device: MTLDevice, color: UIColor) -> FaceMask? {
        guard let geometry = ARSCNFaceGeometry(device: device) else {
            print("Unable to create face geometry")
            return nil
        }
        
        return FaceMask(geometry: geometry, color: color)
    }
}
