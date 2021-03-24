//
//  NoteView.swift
//  Notes
//
//  Created by Ольга on 22.03.2021.
//

import UIKit

class NoteView: UIView {

    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = AppColor.background
        return view
    }()
        
    private let containerView = UIView()
    
    let title: UIView
    
    let text: UIView
    
    let photo: UIImageView
    
    init(title: UIView, text: UIView, photo: UIImageView) {
        self.title = title
        self.text = text
        self.photo = photo
        super.init(frame: CGRect.zero)
        
        setupView()
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        //Add of subviews
        self.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(photo)
        containerView.addSubview(title)
        containerView.addSubview(text)
        
        // Layout of subviews
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        photo.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        
        // Layout of scrollView and containerView
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        let heightConstraint = containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(rawValue: 250)
        heightConstraint.isActive = true
        
        // Layout of containerView's subviews
        NSLayoutConstraint.activate([
            // X axis
            photo.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            containerView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 15),
            title.leadingAnchor.constraint(equalTo: photo.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: photo.trailingAnchor),
            text.leadingAnchor.constraint(equalTo: photo.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: photo.trailingAnchor),
            
            // Y axis
            photo.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            photo.heightAnchor.constraint(lessThanOrEqualToConstant: 150),
            title.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 30),
            text.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30)
        ])
        
        let bottomConstraint = containerView.bottomAnchor.constraint(equalTo: text.bottomAnchor, constant: 15)
        bottomConstraint.priority = UILayoutPriority(rawValue: (text.contentHuggingPriority(for: .vertical).rawValue - 1))
        bottomConstraint.isActive = true
    }
}
