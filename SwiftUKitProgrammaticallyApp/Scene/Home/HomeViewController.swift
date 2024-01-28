//
//  HomeViewController.swift
//  FormTest1
//
//  Created by ibrahim özçelik on 23.12.2023.
//

import UIKit
import SnapKit
import Alamofire

class HomeViewController: UIViewController {
    
    let profilButton : UIButton = {
        let profile = UIButton()
        profile.setImage(UIImage(systemName: "person"), for: [])
        profile.tintColor = .systemIndigo
        profile.layer.cornerRadius = ConstantVariable.cornerRadius
        profile.layer.borderWidth = 1
        profile.layer.borderColor  = UIColor.systemIndigo.cgColor
        return profile
    }()
    
    let messageLabel : UILabel = {
        let label = UILabel()
        label.text = "Hoş Geldin"
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
        button.tintColor = .systemOrange
        return button
    }()  
    
    let notificationButton2 : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bell" ), for: [])
        button.tintColor = .systemOrange
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
        view.layer.cornerRadius = ConstantVariable.cornerRadius
        view.layer.borderWidth  = 1
        return view
    }()
    
    let searchButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: [])
        button.tintColor = .systemOrange
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
    
    let scroolView : UIScrollView = {
        let scroolView = UIScrollView()
        scroolView.showsVerticalScrollIndicator = false
        return scroolView
    }()
    
    let contentView : UIView = {
       let view = UIView()
       
       return view
    }()
    
    let newsContainer : UIView = {
        let view = UIView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Ana Sayfa"
        topViewInfo.addSubview(profilButton)
        topViewInfo.addSubview(messageLabel)
        topViewInfo.addSubview(userNameLabel)
        
        topIconsView.addSubview(notificationButton)
        topIconsView.addSubview(notificationButton2)
        
        topView.addSubview(topIconsView)
        topView.addSubview(topViewInfo)
        
        searchView.addSubview(searchButton)
        searchView.addSubview(inputField)
        
        contentView.addSubview(topView)
        contentView.addSubview(searchView)
        contentView.addSubview(containerProductView)
        contentView.addSubview(newsContainer)
        
        scroolView.addSubview(contentView)
        view.addSubview(scroolView)
        
        ProductService().request(url : "productGetData.php",parameters:nil){(result) -> () in
            self.generateHorizontalMenu(result: (result as? [ProductModel])!)
        }
        
        notificationButton.addTarget(self, action: #selector(notificationScreen), for: .touchUpInside)
        notificationButton2.addTarget(self, action: #selector(notificationScreen), for: .touchUpInside)
        
        addConstrait()
        generateNewsView()
        dismissKeyboard()
    }
    
    @objc func notificationScreen()
    {
        
        let alert = UIAlertController(title: "title", message: "did load", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func dismissKeyboard()
    {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    func generateNewsView()
    {
        let newsView = NewsView()
        newsView.willMove(toParent: self)
        newsContainer.addSubview(newsView.view)
        newsView.view.frame = self.newsContainer.bounds
        self.addChild(newsView)
        newsView.didMove(toParent: self)
    }
    
    
    func generateHorizontalMenu(result : [ProductModel])
    {
        let productView = ProductVerticalViewController(tableCount: 5,dataArray: result)
        productView.willMove(toParent: self)
        self.containerProductView.addSubview(productView.view)
        productView.view.frame = self.containerProductView.bounds
        self.addChild(productView)
        productView.didMove(toParent: self)
    }
    
    func addConstrait()
    {
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scroolView)
            make.left.right.equalTo(view)
            make.width.equalTo(scroolView)
            make.height.equalTo(1100)
        }
        
        scroolView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        containerProductView.snp.makeConstraints { make in
            make.width.equalTo(scroolView)
            make.height.equalTo(200)
            make.topMargin.equalTo(newsContainer).offset(220)
            make.left.right.equalTo(scroolView).offset(5)
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
            make.height.equalTo(50)
            make.right.equalTo(1)
            make.centerY.equalTo(topView)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.width.height.equalTo(75)
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        notificationButton2.snp.makeConstraints { make in
            make.width.height.equalTo(75)
            make.leftMargin.equalTo(notificationButton).offset(40)
            make.centerY.equalToSuperview()
        }
       
        
        topView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalTo(scroolView)
            make.top.equalTo(scroolView).offset(10)
        }
        
        searchView.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(40)
            make.top.equalTo(topView).offset(60)
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
        
        newsContainer.snp.makeConstraints { make in
            make.topMargin.equalTo(searchView).offset(50)
            make.centerX.equalTo(scroolView)
        }
        
    }
}
