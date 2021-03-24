//
//  UITextViewExtensions.swift
//  Notes
//
//  Created by Ольга on 21.03.2021.
//

import UIKit

/**
 Supplements UITextView with custom placeholder
 */
extension UITextView {

    private class PlaceholderLabel: UILabel { }

    private var placeholderLabel: PlaceholderLabel {
        if let label = subviews.compactMap( { $0 as? PlaceholderLabel }).first {
            return label
        } else {
            let label = PlaceholderLabel()
            label.font = font
            label.textColor = AppColor.placeholderText
            addSubview(label)
            return label
        }
    }

    var placeholder: String {
        get {
            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.text ?? ""
        }
        set {
            let placeholderLabel = self.placeholderLabel
            placeholderLabel.text = newValue
            placeholderLabel.numberOfLines = 0
            placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
                placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
                self.trailingAnchor.constraint(equalTo: placeholderLabel.trailingAnchor, constant: 7)
            ])
            textStorage.delegate = self
        }
    }
}

extension UITextView: NSTextStorageDelegate {

    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
}
