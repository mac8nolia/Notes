//
//  Fonts.swift
//  Notes
//
//  Created by Ольга on 19.03.2021.
//

import UIKit

struct AppFont {
    
    static func defaultRegularFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
    }

    static func defaultBoldFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
    }
}
