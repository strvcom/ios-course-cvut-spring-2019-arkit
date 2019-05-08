//
//  FaceViewModel.swift
//  AR Demo
//
//  Created by Jan on 08/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import ARKit

class FaceViewModel: FaceViewModeling {
    let environmentPath = "face.scnassets/Materials/Environment.jpg"
    weak var device: MTLDevice?
    
    private let faceMaskColor: UIColor
    private var texture: FaceMask.Texture
    
    lazy var faceMask: FaceMask? = {
        guard let device = device else {
            return nil
        }
        let mask = createFaceMask(with: device, texture: self.texture)
        return mask
    }()
    
    init() {
        let color = UIColor.yellow
        faceMaskColor = color
        texture = .basic(color: color)
    }
    
    func loopFaceMaskTexture() {
        let nextTexture: FaceMask.Texture
        
        switch texture {
        case .basic:
            nextTexture = .metalic(color: faceMaskColor)
        case .metalic:
            nextTexture = .zombie
        case .zombie:
            nextTexture = .basic(color: faceMaskColor)
        }
        
        texture = nextTexture
        faceMask?.update(with: texture)
    }
}

// MARK: Private methods
private extension FaceViewModel {
    func createFaceMask(with device: MTLDevice, texture: FaceMask.Texture) -> FaceMask? {
        guard let geometry = ARSCNFaceGeometry(device: device) else {
            print("Unable to create face geometry")
            return nil
        }
        
        return FaceMask(geometry: geometry, texture: texture)
    }
}
