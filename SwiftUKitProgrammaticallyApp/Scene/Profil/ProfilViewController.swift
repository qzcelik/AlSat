//
//  ProfilViewController.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 3.01.2024.
//

import UIKit
import SnapKit


class ProfilViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let imgV : UIImageView = {
       let image = UIImageView()
        return image
    }()
    
    let productTitle : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ürün Başlık Girin"
        textField.textAlignment = .center
        textField.textColor = .white
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = ConstantVariable.cornerRadius
        return textField
    }()
    
    let productInfo : UITextView = {
        let textField = UITextView()
        textField.textAlignment = .center
        textField.textColor = .systemBackground
        textField.layer.borderWidth = 2
        textField.textColor = .black
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = ConstantVariable.cornerRadius
        return textField
    }()
    
    let productPrice : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ürün Fiyat Girin"
        textField.textAlignment = .center
        textField.textColor = .white
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = ConstantVariable.cornerRadius
        return textField
    }()
    
    var sendImage : UIButton = {
        let button = UIButton()
        button.setTitle("Ürün Ekle", for: [])
        button.backgroundColor = .systemRed
        return button
    }()
    
   
    var multipartRequest = MultipartService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    func prepareUI()
    {
        view.backgroundColor = .systemOrange
        view.addSubview(imgV)
        view.addSubview(sendImage)
        view.addSubview(productTitle)
        view.addSubview(productInfo)
        view.addSubview(productPrice)
 
        
        let photoClick = UITapGestureRecognizer(target: self, action: #selector(openCamera))
        
        imgV.image = UIImage(systemName: "camera")
        imgV.addGestureRecognizer(photoClick)
        imgV.isUserInteractionEnabled = true
        
        constraint()
        dismissKeyboard()
        
        sendImage.addTarget(self, action: #selector(sendDataToServer), for: .touchUpInside)
 
    }
    
    func warningPanel(title: String, message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func dismissKeyboard()
    {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    @objc func sendDataToServer()
    {
        let fileName : String? = productTitle.text
        if(productTitle.text != "" && productInfo.text != "" && productPrice.text != "" && imgV.image != nil)
        {
            MultipartService().uploadImageToServer(image: imgV.image!, fileName: fileName!, productTitle: productTitle.text!, productDescription: productInfo.text, productPrice: productPrice.text!) { result in
                    switch result {
                    case .success(let message):
                        print("Image uploaded successfully. Message: \(message)")
                    case .failure(let error):
                        print("Image upload failed with error: \(error.localizedDescription)")
                    }
            }
        }
        else
        {
            warningPanel(title: "Uyarı", message: "Boş Alanları Doldurun")
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
            
            make.width.equalTo(300)
            make.height.equalTo(250)
            make.centerX.equalToSuperview()
            make.topMargin.equalToSuperview().offset(25)
        }
  
      productTitle.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(imgV).offset(250)
            
        }
        
        productInfo.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(150)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(productTitle).offset(50)
            
        } 
        
        productPrice.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(productInfo).offset(175)
            
        }
        
    
        sendImage.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(productPrice).offset(100)
        }
        
     
    }

}
