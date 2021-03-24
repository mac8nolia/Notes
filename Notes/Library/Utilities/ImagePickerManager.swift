//
//  ImagePickerManager.swift
//  Notes
//
//  Created by Ольга on 20.03.2021.
//

import UIKit
import Photos

/**
 Lets to user choose photo from gallery or camera
 */
class ImagePickerManager: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var picker = UIImagePickerController()
    
    private let actionSheetController = AlertController(title: "Выберите фото", message: nil, preferredStyle: .actionSheet)
    
    private unowned let viewController: UIViewController
    
    private var pickImageCallback : ((UIImage) -> ())?
    
    init(controller: UIViewController) {
        viewController = controller
        super.init()

        let cameraAction: UIAlertAction = UIAlertAction(title: "Камера", style: .default) { [weak self] action -> Void in
            self?.openCamera()
        }

        let galleryAction: UIAlertAction = UIAlertAction(title: "Галерея", style: .default) { [weak self] action -> Void in
            self?.openGallery()
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Отмена", style: .cancel) { action -> Void in }

        actionSheetController.addAction(cameraAction)
        actionSheetController.addAction(galleryAction)
        actionSheetController.addAction(cancelAction)
        
        picker.delegate = self
        checkPermission()
    }

    func pickImage(_ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback
        viewController.present(actionSheetController, animated: true)
    }
    
    private func openCamera(){
        actionSheetController.dismiss(animated: true, completion: nil)
        if (UIImagePickerController.isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            viewController.present(picker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: nil, message: "У вас нет камеры", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openGallery(){
        actionSheetController.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        viewController.present(picker, animated: true, completion: nil)
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                if newStatus ==  PHAuthorizationStatus.authorized {
                        /* do stuff here */
                }
            })
        default: break
        }
    }
     
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            picker.dismiss(animated:true, completion: nil)
            return
        }
        let newImage = resize(image: image)
        picker.dismiss(animated:true) { [weak self] in
            self?.pickImageCallback?(newImage)
        }
    }
}

// MARK: - Utilities

extension ImagePickerManager {
    
    func resize(image: UIImage, newHeigth: CGFloat = 150.0) -> UIImage {
        var newImage: UIImage
        
        let ratio: CGFloat = image.size.width / image.size.height
        let newWidth = newHeigth * ratio
        let size = CGSize(width: newWidth, height: newHeigth)
        
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeigth))
        newImage = UIGraphicsGetImageFromCurrentImageContext()! // ???
        UIGraphicsEndImageContext()
        
        return newImage
    }
}


