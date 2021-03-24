//
//  CALayerExtensions.swift
//  Notes
//
//  Created by Ольга on 21.03.2021.
//

import UIKit

extension CALayer {
    
    /**
     Setups layer's border with specified color
     */
    func setupBorder(color: CGColor) {
        borderColor = color
        cornerRadius = 5
        borderWidth = 1
    }
}
