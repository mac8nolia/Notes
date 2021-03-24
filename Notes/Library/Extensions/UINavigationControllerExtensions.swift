//
//  UINavigationControllerExtensions.swift
//  Notes
//
//  Created by Ольга on 24.03.2021.
//

import UIKit

extension UINavigationController {
    
    /**
     Supplements popViewController with completion handler
     */
    func popViewController(animated: Bool, completion: @escaping  () -> ()) {
        popViewController(animated: animated)
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
