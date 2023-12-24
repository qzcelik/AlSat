//
//  IntroViewController.swift
//  FormTest1
//
//  Created by ibrahim özçelik on 24.12.2023.
//

import UIKit
import SnapKit

class IntroViewController: UIViewController {

    
    let introImage : UIImage = {
        let image = UIImage(named: ConstantVariable.introBGPath)
        return image!
    }()
    
    let introImageView : UIImageView = {
        let imageView = UIImageView()
       return imageView
    }()
    
    let introLabel : UILabel = {
        let label = UILabel()
        label.text = "Uygulama Giriş Yazısı"
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        return label
    }()
    
    let startButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Başla", for: [])
        button.setTitleColor(UIColor.systemBlue, for: [])
        button.backgroundColor = .lightText
        button.layer.cornerRadius = 10
        return button
        
    }()
    
    let introView : UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        initUI()
        setConstrait()
    }
    
    func initUI()
    {   
        introImageView.image = introImage
        introImageView.sizeToFit()
        introView.addSubview(introImageView)
        introView.addSubview(introLabel)
        introView.addSubview(startButton)
        view.addSubview(introView)
        
        startButton.addTarget(self, action: #selector(startApp) , for: .touchUpInside)
    }
    
    @objc func startApp()
    {
        DispatchQueue.main.async { [weak self] in
            self?.present(TabBarHomeViewController(), animated: true, completion: nil)
        }
    }
    
    func setConstrait()
    {
        introView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        introLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(100)
        }
        
        introImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(introLabel).offset(200)
        }
    }
    

 
}
