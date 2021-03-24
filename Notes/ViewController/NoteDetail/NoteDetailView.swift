//
//  NoteDetailView.swift
//  Notes
//
//  Created by Ольга on 22.03.2021.
//

import UIKit

final class NoteDetailView: NoteView {

    init(title: String, text: String, image: UIImage?) {
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = title
            label.numberOfLines = 0
            label.font = AppFont.defaultBoldFont(size: 24)
            return label
        }()
        
        let textLabel: UILabel = {
            let label = UILabel()
            label.text = text
            label.numberOfLines = 0
            label.font = AppFont.defaultRegularFont(size: 17)
            return label
        }()
        
        let photoView: UIImageView = {
            let view = UIImageView()
            if let photo = image {
                view.image = photo
            } else {
                view.image = AppImage.defaultPhoto
            }
            view.contentMode = .scaleAspectFit
            return view
        }()
        
        super.init(title: titleLabel, text: textLabel, photo: photoView)
    }
}
