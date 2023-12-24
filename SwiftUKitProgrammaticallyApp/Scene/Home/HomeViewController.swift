//
//  HomeViewController.swift
//  FormTest1
//
//  Created by ibrahim özçelik on 23.12.2023.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    
    let profilButton : UIButton = {
        
        let profile = UIButton()
        profile.setImage(UIImage(systemName: "person"), for: [])
        profile.tintColor = .black
        profile.layer.cornerRadius = 5
        profile.layer.borderWidth = 1
        return profile
    }()
    
    let messageLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Welcome"
        label.textColor = .black
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    let userNameLabel : UILabel = {
        
        let label  = UILabel()
        label.text = "Ibrahim Ozcelik"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        return label
        
    }()
    
    let notificationButton : UIButton = {
       
        let button = UIButton()
        button.setImage(UIImage(systemName: "basket" ), for: [])
        button.tintColor = .black
        
        return button
    }()  
    
    let notificationButton2 : UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "bell" ), for: [])
        button.tintColor = .black
        return button
    }()
    
    let notificationButton3 : UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "star" ), for: [])
        button.tintColor = .black
        return button
    }()
    
    let topView : UIView = {
       
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()  
    
 
    let topViewInfo : UIView = {
        
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    let topIconsView : UIView = {
      
        let view = UIView()
        return view
        
    }()
    
    let searchView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 7
        view.layer.borderWidth  = 1
        return view
    }()
    
    let searchButton : UIButton = {
       
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: [])
        button.tintColor = .black
        return button
        
    }()
    
    let inputField : UITextField = {
       
        let inputField = UITextField()
        inputField.placeholder = "Arama"
        return inputField
    }()
    
    let containerProductView : UIView = {
       
        let containerView = UIView()
        return containerView
        
    }()
    
    let containerProductTableView : UIView = {
        let view = UIView()
        return view
    }()
    
    //var newsView: UIView = NewsView().view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Ana Sayfa"
        topViewInfo.addSubview(profilButton)
        topViewInfo.addSubview(messageLabel)
        topViewInfo.addSubview(userNameLabel)
        
        topIconsView.addSubview(notificationButton)
        topIconsView.addSubview(notificationButton2)
        topIconsView.addSubview(notificationButton3)
        
        topView.addSubview(topIconsView)
        topView.addSubview(topViewInfo)
        
        searchView.addSubview(searchButton)
        searchView.addSubview(inputField)
        
        view.addSubview(topView)
        view.addSubview(searchView)
        
        //view.addSubview(newsView)
        view.addSubview(containerProductView)
        view.addSubview(containerProductTableView)
        
        let productView = ProductVerticalViewController()
        productView.willMove(toParent: self)
        containerProductView.addSubview(productView.view)
        productView.view.frame = containerProductView.bounds
        addChild(productView)
        productView.didMove(toParent: self)
        
        let productTableView = ProductTableView()
        productTableView.willMove(toParent: self)
        containerProductTableView.addSubview(productTableView.view)
        productTableView.view.frame = containerProductTableView.bounds
        addChild(productTableView)
        productTableView.didMove(toParent: self)
        
        addConstrait()
        
    }
    
    func addConstrait()
    {
        
        containerProductTableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(400)
            make.topMargin.equalTo(containerProductView).offset(150)
        }
        
        containerProductView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.topMargin.equalTo(searchView).offset(100)
        }
        
        profilButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.left.equalTo(5)
            make.centerY.equalTo(topView)
        }
        
        
        messageLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.left.equalTo(profilButton).offset(50)
            make.top.equalTo(topView).offset(5)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.left.equalTo(profilButton).offset(50)
            make.top.equalTo(messageLabel).offset(15)
        }
        
        topIconsView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.right.equalTo(10)
            make.centerY.equalTo(topView)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        notificationButton2.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.leftMargin.equalTo(notificationButton).offset(25)
            make.centerY.equalToSuperview()
        }
        
        notificationButton3.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.leftMargin.equalTo(notificationButton2).offset(25)
            make.centerY.equalToSuperview()
        }
   
        
        topView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalToSuperview()
            make.topMargin.equalTo(10)
        }
        
        searchView.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(40)
            make.top.equalTo(topView).offset(70)
            make.centerX.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        inputField.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
            make.left.equalTo(searchButton).offset(50)
        }
        
        /*newsView.snp.makeConstraints { make in
            make.top.equalTo(searchView).offset(60)
            make.centerX.equalToSuperview()
        }*/
        
       
    }
    

    

}
