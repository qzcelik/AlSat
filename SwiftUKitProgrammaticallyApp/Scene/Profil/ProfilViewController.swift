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
        button.tintColor = .systemOrange
        button.backgroundColor = .systemFill
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    func prepareUI()
    {
        view.backgroundColor = .white
        view.addSubview(productAddContainer)
        view.addSubview(addProductButton)
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
        
        addProductButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.topMargin.equalToSuperview().offset(20)
            make.leftMargin.equalToSuperview().offset(20)
        }
  
    }

}
