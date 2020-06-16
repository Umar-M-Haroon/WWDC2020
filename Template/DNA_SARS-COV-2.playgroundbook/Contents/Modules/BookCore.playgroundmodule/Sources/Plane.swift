//
//  Plane.swift
//  DNARTest
//
//  Created by Umar Haroon on 5/11/20.
//  Copyright © 2020 Umar Haroon. All rights reserved.
//

import Foundation
#if !targetEnvironment(macCatalyst)
import ARKit
import SceneKit

class Plane: SCNNode {
    var anchor: ARPlaneAnchor
    var planeGeometry: SCNPlane
    init(with anchor: ARPlaneAnchor) {
        self.anchor = anchor
        self.planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        let planeNode = SCNNode(geometry: self.planeGeometry)
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(Float(.pi / 2.0), -1.0, 0.0, 0.0)
        planeNode.isHidden = true
        super.init()
        self.addChildNode(planeNode)
    }
    func update(anchor: ARPlaneAnchor) {
        self.planeGeometry.width = CGFloat(anchor.extent.x)
        self.planeGeometry.height = CGFloat(anchor.extent.z)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
