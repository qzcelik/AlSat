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
        //button.configuration = .filled()
        button.backgroundColor = .blue
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 1
        button.layer.shadowOffset = CGSize(width: -1, height: 1)
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 10
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
