//
//  LoginViewController.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 9.01.2024.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    let loginLabel : UILabel = {
       let label = UILabel()
        label.text = "Giriş"
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

extension LoginViewController
{
    func prepareUI()
    {
        view.addSubview(loginLabel)
        view.addSubview(userNameTextBox)
        view.addSubview(userPassTextBox)
        view.addSubview(submitButton)
        submitButton.addTarget(self, action: #selector(loginRequest), for: .touchUpInside)
        constraint()
    }
    
    @objc func loginRequest()
    {
      print("test")
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
        
        submitButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(userPassTextBox).offset(75)
        }
    }
}
