//
//  NewsView.swift
//  FormTest1
//
//  Created by ibrahim özçelik on 23.12.2023.
//

import UIKit
import SnapKit

struct NewsView {

    let view : UIView = {
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
    
    init()
    {
        view.addSubview(buttonNews)
        constrait()
    }
  
    func constrait()
    {
        buttonNews.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(200)
            make.centerX.equalToSuperview()
        }
        
    }
    
    
  
    
   

}
