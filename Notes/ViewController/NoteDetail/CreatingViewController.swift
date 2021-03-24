//
//  CreatingViewController.swift
//  Notes
//
//  Created by Ольга on 19.03.2021.
//

import UIKit

typealias CompletionHandler = (_ title: String, _ text: String, _ image: UIImage?) -> ()

class CreatingViewController: UIViewController {
    
    private var noteTitle = ""
    
    private var noteText = ""
    
    private var image: UIImage?
    
    private lazy var imagePickerManager = ImagePickerManager(controller: self)
    
    var completionHandler: CompletionHandler?
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = NoteCreateView(controller: self)
                
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Создать", style: UIBarButtonItem.Style.plain, target: self, action: #selector(createNoteAction))
    }
}

// MARK: - Actions handler

extension CreatingViewController {
    
    @objc func createNoteAction() {
        if noteTitle.isEmpty {
            if noteText.isEmpty {
                showAlertWith(message: "Введите название и текст заметки")
            } else {
                showAlertWith(message: "Введите название заметки")
            }
        } else if noteText.isEmpty {
            showAlertWith(message: "Введите текст заметки")
        } else {
            // Return data to MainViewController for creating new Note
            navigationController?.popViewController(animated: true, completion: {
                guard let cb = self.completionHandler else { return }
                cb(self.noteTitle, self.noteText, self.image)
            })
        }
    }
    
    private func showAlertWith(message: String) {
        let alert = UIAlertController(title: "Недостаточно данных", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

// MARK: - Image view handler

extension CreatingViewController {
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        imagePickerManager.pickImage() { [unowned self] image in
            self.image = image
            guard let creatingView = self.view as? NoteCreateView else { return }
            creatingView.set(image: image)
        }
    }
}

// MARK: - Text field handler

extension CreatingViewController {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        noteTitle = textField.text!
    }
}

// MARK: - Text View Delegate

extension CreatingViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        noteText = textView.text
    }
}

