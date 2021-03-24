//
//  Colors.swift
//  Notes
//
//  Created by Ольга on 22.03.2021.
//

import UIKit

struct AppColor {
    
    static var background: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    
    static var cell: UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray5
        } else {
            return UIColor(red: 229.0/255, green: 229.0/255, blue: 234.0/255, alpha: 1.0)
        }
    }
    
    static var placeholderText: UIColor {
        if #available(iOS 13.0, *) {
            return .placeholderText
        } else {
            return UIColor(red: 199.0/255, green: 199.0/255, blue: 205.0/255, alpha: 1.0)
        }
    }
    
    static var placeholderBorder: CGColor {
        return placeholderText.cgColor
    }
}
