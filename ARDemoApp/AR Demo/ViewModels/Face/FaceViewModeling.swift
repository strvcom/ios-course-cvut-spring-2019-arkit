//
//  FaceViewModeling.swift
//  AR Demo
//
//  Created by Jan on 08/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import ARKit

protocol FaceViewModeling {
    func createFaceMask(with device: MTLDevice, color: UIColor) -> FaceMask?
}
