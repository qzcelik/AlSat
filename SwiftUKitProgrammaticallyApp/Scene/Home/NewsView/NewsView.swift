//
//  NewsView.swift
//  FormTest1
//
//  Created by ibrahim özçelik on 23.12.2023.
//

import UIKit
import SnapKit

class NewsView : UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
   
    let viewProduct : UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let buttonNews : UIButton = {
        
        let button = UIButton()
        button.setTitle("NEWS", for: [])
        button.setBackgroundImage(.introBg, for: [])
        button.layer.cornerRadius = ConstantVariable.cornerRadius
        return button
    }()
    
    func initView()
    {
        viewProduct.addSubview(buttonNews)
        view.addSubview(viewProduct)
        buttonNews.addTarget(self, action: #selector(clickNews), for: .touchUpInside)
        constrait()
    }
   
    @objc func clickNews()
    {
      print("click test")
    }
    
    func constrait()
    {
        buttonNews.snp.makeConstraints { make in
            make.width.equalTo(400)
            make.height.equalTo(200)
            make.centerX.equalToSuperview()
        }
        
    }
   
    
    
    
  
    
   

}
