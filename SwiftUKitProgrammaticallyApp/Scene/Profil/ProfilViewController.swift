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
    
    var sendImage : UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: [])
        button.backgroundColor = .red
        return button
    }()
    
    var multipartRequest = MultipartService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imgV)
        view.addSubview(sendImage)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openCamera))
        view.addGestureRecognizer(gesture)
        constraint()
        
        sendImage.addTarget(self, action: #selector(sendImageToServer), for: .touchUpInside)
    }
    
    @objc func sendImageToServer()
    {
        
        
            let fileName = "example"
            let fileDate = "2024-01-08"
        MultipartService().uploadImageToServer(image: imgV.image!, fileName: fileName, fileDate: fileDate) { result in
                switch result {
                case .success(let message):
                    print("Image uploaded successfully. Message: \(message)")
                case .failure(let error):
                    print("Image upload failed with error: \(error.localizedDescription)")
                }
        }
        
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
    }
    
    func constraint()
    {
        imgV.snp.makeConstraints {make in
            
            make.width.height.equalTo(300)
            make.center.equalToSuperview()
        }
        
        sendImage.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(100)
        }
        
    }

}
