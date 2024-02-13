//
//  ProfilViewController.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 3.01.2024.
//

import UIKit
import SnapKit

 
class ProfilViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, ProductDelegate {
   
    
    func productAddViewVisibility(visiblity: Bool) {
        self.productAddContainer.isHidden = visiblity
  }
    
  
    let productAddContainer : UIView = {
       let view = UIView()
       return view
        
    }()
    
    let addProductButton : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "plus.rectangle"), for: [])
        button.tintColor = .white
        return button
    }()
    
    let addProductLabel : UILabel = {
       let label = UILabel()
        label.text = "Ürün Ekle"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
       return label
    }()
    
    let messageButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: [])
        button.tintColor = .white
        return button
    }()
    
    let messageLabel : UILabel = {
       let label = UILabel()
        label.text = "Mesaj"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
       return label
    }()
    
    let messageView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        return view
    }()
    
    let productAddView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        return view
    }()
    
    let viewProfil : UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        return view
    }()
    
    let addedProductContainer : UIView = {
       let view = UIView()
       return view
    }()
    
    let profilPhoto : UIImageView = {
      let image = UIImageView()
        image.image = UIImage(systemName: "person.crop.circle.fill")
        image.tintColor = .white
       
        image.layer.cornerRadius = 100
      return image
    }()
    
    let productAddViewController = ProductAddViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
 
    var productTableView : ProductTableView!
    var refreshControl = UIRefreshControl();
    
    @objc func refreshTableView()
    {
        let parameters : [String:Any] = [
            "userId" : LoginViewController.user.id!
        ]
        ProductService().request(url :"productGetMyData.php", parameters: parameters,method:.post){(result) -> () in
                self.productTableView.updateData(prodcutTable: (result as? [ProductModel])!)
        }
        self.productTableView.tableViewVertical.refreshControl?.endRefreshing()
    }
    
   
    
    func prepareUI()
    {
        productAddViewController.delegate = self
        title = "Profil"
        view.backgroundColor = .white
        
        messageView.addSubview(messageLabel)
        messageView.addSubview(messageButton)
        
        productAddView.addSubview(addProductButton)
        productAddView.addSubview(addProductLabel)
        viewProfil.addSubview(profilPhoto)
        
        view.addSubview(addedProductContainer)
        view.addSubview(viewProfil)
        view.addSubview(productAddView)
        view.addSubview(messageView)
        view.addSubview(productAddContainer)
        
       
        self.productAddContainer.isHidden = true
        addProductButton.addTarget(self, action: #selector(openAddProductView), for: .touchUpInside)
        constraint()
        generateProductList()
    }
    
   
    
    func generateProductList()
      {
          let parameter  : [String:Any] = [
            "userId" : LoginViewController.user.id! as Any
        ]
       
          ProductService().request(url : "productGetMyData.php",parameters:parameter,method: .post){(result) -> () in
              self.productTableView = ProductTableView(prodcutTable: (result as? [ProductModel])! , viewController: ConstantEnums.Views.productDetail)
              self.productTableView.willMove(toParent: self)
              self.addedProductContainer.addSubview(self.productTableView.view)
              self.productTableView.view.frame = self.addedProductContainer.bounds
              self.addChild(self.productTableView)
              self.productTableView.didMove(toParent: self)
              
              self.productTableView.tableViewVertical.refreshControl = self.refreshControl
              self.refreshControl.addTarget(self, action:#selector(self.refreshTableView), for: .valueChanged)
         }
      }

    
    func generateNewProductAddView()
    {
        if(self.productAddContainer.subviews.isEmpty)
        { 
            productAddViewController.willMove(toParent: self)
            self.productAddContainer.addSubview(productAddViewController.view)
            productAddViewController.view.frame = self.productAddContainer.bounds
            self.addChild(productAddViewController)
            productAddViewController.didMove(toParent: self)
        }
       
    }
    
 
    
    @objc func openAddProductView()
    {
        self.productAddContainer.isHidden = false
        generateNewProductAddView()
    }
 
    func constraint()
    {
        viewProfil.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(300)
            make.centerX.equalToSuperview()
            make.topMargin.equalToSuperview()
        }
        
        profilPhoto.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottomMargin.equalToSuperview().offset(-20)
        }
        
        productAddContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(500)
            make.width.equalTo(300)
        }
        
        productAddView.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.height.equalTo(50)
            make.topMargin.equalTo(viewProfil).offset(225)
            make.leftMargin.equalTo(viewProfil).offset(60)
        }
        
        messageView.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.height.equalTo(50)
            make.topMargin.equalTo(viewProfil).offset(225)
            make.leftMargin.equalTo(productAddView).offset(150)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.leftMargin.equalTo(messageButton).offset(52)
            make.centerY.equalTo(messageButton)
        }
        
        messageButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.topMargin.equalToSuperview()
            make.leftMargin.equalToSuperview()
        }
        
        addProductButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.topMargin.equalToSuperview()
            make.leftMargin.equalToSuperview()
        }
        
        addProductLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.leftMargin.equalTo(addProductButton).offset(52)
            make.centerY.equalTo(addProductButton)
        }
        
        addedProductContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(500)
            make.topMargin.equalTo(messageView).offset(75)
            make.centerX.equalToSuperview()
        }
  
    }

}
