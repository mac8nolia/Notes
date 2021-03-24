//
//  FirstChildView.swift
//  Notes
//
//  Created by Ольга on 22.03.2021.
//

import UIKit

final class NoteCreateView: NoteView {
    
    private unowned let controller: CreatingViewController

    init(controller: CreatingViewController) {
        self.controller = controller
        
        let titleField: UITextField = {
            let titleField = UITextField()
            titleField.font = AppFont.defaultRegularFont(size: 15)
            titleField.attributedPlaceholder = NSAttributedString(string: "Введите название", attributes: [NSAttributedString.Key.foregroundColor: AppColor.placeholderText])
            titleField.borderStyle = UITextField.BorderStyle.roundedRect
            titleField.layer.setupBorder(color: AppColor.placeholderBorder)

            titleField.returnKeyType = .done
            titleField.clearButtonMode = .whileEditing
            
            titleField.addTarget(nil, action:#selector(changeResponder), for:.editingDidEndOnExit)
            titleField.addTarget(controller, action: #selector(CreatingViewController.textFieldDidChange(_:)), for: .editingChanged)
            return titleField
        }()
        
        let textView: UITextView = {
            let textView = UITextView()
            textView.isScrollEnabled = false
            textView.font = AppFont.defaultRegularFont(size: 15)
            textView.placeholder = "Введите текст"
            textView.layer.setupBorder(color: AppColor.placeholderBorder)
            
            textView.delegate = controller
            return textView
        }()
        
        let photoView: UIImageView = {
            let view = UIImageView(image: AppImage.defaultPhoto)
            view.contentMode = .scaleAspectFit
            view.layer.setupBorder(color: AppColor.placeholderBorder)
            
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(CreatingViewController.handleTap(_:))))
            return view
        }()
        
        super.init(title: titleField, text: textView, photo: photoView)
        
        // Set view as observer for keyboard's actions to interactive scroll
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)

        scrollView.keyboardDismissMode = .interactive
    }
}

// MARK: - Update UI

extension NoteCreateView {
    
    /**
     Updates image chosen by user
     */
    func set(image: UIImage) {
        photo.image = image
    }
}

// MARK: - Actions handler

extension NoteCreateView {
    
    @objc func changeResponder(sender: UITextField) {
        sender.resignFirstResponder()
        text.becomeFirstResponder()
    }
}

// MARK: - Keyboard's actions handler

extension NoteCreateView {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}


