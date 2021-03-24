//
//  DetailViewController.swift
//  Notes
//
//  Created by Ольга on 19.03.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var noteTitle: String!
    
    var noteText: String!
    
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = noteTitle
        
        self.view = NoteDetailView(title: noteTitle, text: noteText, image: image)
    }
}
