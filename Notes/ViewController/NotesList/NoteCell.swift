//
//  NoteCell.swift
//  Notes
//
//  Created by Ольга on 19.03.2021.
//

import UIKit

class NoteCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.defaultBoldFont(size: 17)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.defaultRegularFont(size: 14)
        label.numberOfLines = 2
        return label
    }()
    
    private let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.roundCorners(corners: [.bottomRight,.topRight, .bottomLeft, .topLeft], radius: 7)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let disclosure: UIImageView = {
        let disclosure = UIImageView()
        disclosure.image = UIImage(named:"disclosure")
        return disclosure
    }()
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.cell
        view.roundCorners(corners: [.bottomRight,.topRight, .bottomLeft, .topLeft], radius: 10)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupBackView()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackView() {
        
        // Add of backView subviews
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(titleLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(descriptionLabel)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(photoView)
        
        disclosure.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(disclosure)
        
        // Layout of backView subviews
        NSLayoutConstraint.activate([
            
            // X axis
            photoView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            photoView.widthAnchor.constraint(equalToConstant: 70),
            titleLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 10),
            disclosure.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            disclosure.widthAnchor.constraint(equalToConstant: 10),
            backView.trailingAnchor.constraint(equalTo: disclosure.trailingAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            // Y axis
            photoView.topAnchor.constraint(greaterThanOrEqualTo: backView.topAnchor, constant: 10),
            photoView.heightAnchor.constraint(equalToConstant: 70),
            backView.bottomAnchor.constraint(greaterThanOrEqualTo: photoView.bottomAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: backView.centerYAnchor),
            backView.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            disclosure.centerYAnchor.constraint(equalTo: backView.centerYAnchor)
        ])
    }
    
    private func setupCell() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backView)

        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 10),
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            contentView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 5),
        ])
    }
}

// MARK: - Update UI

extension NoteCell {
    
    func show(title: String, text: String, image: UIImage?) {
        titleLabel.text = title
        descriptionLabel.text = text
        photoView.image = image
    }
}
