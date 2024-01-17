//
//  ProfilViewController.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 3.01.2024.
//

import UIKit
import SnapKit

 
class ProfilViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
  
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
    
    let productAddView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    func prepareUI()
    {
        title = "Profil"
        view.backgroundColor = .white
        productAddView.addSubview(addProductButton)
        productAddView.addSubview(addProductLabel)
        view.addSubview(productAddView)
        view.addSubview(productAddContainer)

        addProductButton.addTarget(self, action: #selector(openAddProductView), for: .touchUpInside)
        constraint()
    }
    
    func generateNewProductAddView()
    {
        let productAddView = ProductAddViewController()
        productAddView.willMove(toParent: self)
        self.productAddContainer.addSubview(productAddView.view)
        productAddView.view.frame = self.productAddContainer.bounds
        self.addChild(productAddView)
        productAddView.didMove(toParent: self)
    }
    
 
    
    @objc func openAddProductView()
    {
        generateNewProductAddView()
    }
 
    func constraint()
    {
        productAddContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(500)
            make.width.equalTo(300)
        }
        
        productAddView.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.height.equalTo(50)
            make.topMargin.equalToSuperview().offset(20)
            make.leftMargin.equalToSuperview().offset(20)
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
  
    }

}
