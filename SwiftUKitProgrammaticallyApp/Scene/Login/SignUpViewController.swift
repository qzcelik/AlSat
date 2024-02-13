//
//  LoginViewController.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 9.01.2024.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {

    let loginLabel : UILabel = {
       let label = UILabel()
        label.text = "Yeni Kayıt"
        label.font = .systemFont(ofSize: 50)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    
    let userNameTextBox : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Kullanıcı Adı Girin"
        textField.textColor = .white
        textField.textAlignment = .center
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = ConstantVariable.cornerRadius
        return textField
    }()
    
    let userPassTextBox : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Kullanıcı Şifre Girin"
        textField.textAlignment = .center
        textField.textColor = .white
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = ConstantVariable.cornerRadius
        return textField
    }()
    
    let userMailTextBox : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Mail Adresi Girin"
        textField.textAlignment = .center
        textField.textColor = .white
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = ConstantVariable.cornerRadius
        return textField
    }()
    
    let submitButton : UIButton = {
       let button = UIButton()
        button.setTitle("Tamam", for: [])
        button.tintColor = .black
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = ConstantVariable.cornerRadius
        button.setTitleColor(UIColor.white, for: [])
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        prepareUI()
    }

}

extension SignUpViewController
{
    func prepareUI()
    {
        view.addSubview(loginLabel)
        view.addSubview(userNameTextBox)
        view.addSubview(userPassTextBox)
        view.addSubview(submitButton)
        view.addSubview(userMailTextBox)
        
        submitButton.addTarget(self, action: #selector(loginRequest), for: .touchUpInside)
        constraint()
        dismissKeyboard()
    }
   
    func dismissKeyboard()
    {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    @objc func loginRequest()
    {
        let username : String = userNameTextBox.text!
        let password : String = userPassTextBox.text!
        let mail : String = userMailTextBox.text!
        
        if(username != "" && password != "" && mail != "")
        {
            let parameters: [String: Any] = [
                "username": username,
                "userpass": password,
                "mail" : mail
            ]
            
            userRequest(parameters: parameters)
        }
        else
        {
            warningPanel(title: "Uyarı", message: "Boş Alanları Doldurun")
        }
    }
    
    func warningPanel(title: String, message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func userRequest(parameters : [String:Any])
    {
        UserService().request(url:"userAdd.php",parameters: parameters,method:.post) { (result) -> () in
            
            var userData = result[0] as? UserModel
             
            if(userData?.id == "0")
            {
                self.warningPanel(title: "Uyarı", message: "Kullanıcı Mevcut")
            }
            else
            {
                self.present(IntroViewController(), animated: true)
            }
            
        }
    }

    func constraint()
    {
        loginLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.topMargin.equalToSuperview().offset(150)
        }
        
        userNameTextBox.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(loginLabel).offset(75)
        }
        
        userPassTextBox.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(userNameTextBox).offset(50)
        } 
        
        userMailTextBox.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(userPassTextBox).offset(50)
        }
        
        submitButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(userMailTextBox).offset(75)
        }
        
    
      
    }
}
