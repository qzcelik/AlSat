//
//  ProfilViewController.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 3.01.2024.
//

import UIKit
import SnapKit

class ProfilViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var imgV : UIImageView = {
       let image = UIImageView()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imgV)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openCamera))
        view.addGestureRecognizer(gesture)
        constraint()
    }
    
    
    @objc func openCamera()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        imagePicker.showsCameraControls = true
        present(imagePicker,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage  
        self.imgV.image = image
        picker.dismiss(animated: true, completion: nil)
        print("TAKE PHOTO")
    }
    
    func constraint()
    {
        imgV.snp.makeConstraints {make in
            
            make.width.height.equalTo(300)
            make.center.equalToSuperview()
        }
        
    }

}
