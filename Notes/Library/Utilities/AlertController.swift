//
//  AlertController.swift
//  Notes
//
//  Created by Ольга on 24.03.2021.
//

import UIKit

/**
 Lets avoid system bugs with UIAlertController's constraints
 */
class AlertController: UIAlertController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweakProblemWidthConstraints()
    }
    
    func tweakProblemWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints {
                // Identify the problem constraint
                // Check that it's priority 1000 - which is the cause of the conflict.
                if constraint.firstAttribute == .width &&
                    constraint.constant == -16 &&
                    constraint.priority.rawValue == 1000 {
                    // Let the framework know it's okay to break this constraint
                    constraint.priority = UILayoutPriority(rawValue: 999)
                }
            }
        }
    }
}
