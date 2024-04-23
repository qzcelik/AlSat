//
//  TestViewController.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 2.01.2024.
//

import UIKit
import SnapKit

class TestViewController: UIViewController {

    
    let button : UIButton = {
        let button = UIButton()
        button.setTitle("test", for: [])
        button.backgroundColor = .red
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(button)
        button.addTarget(self, action: #selector(clkc), for: .touchUpInside)
        constrait()
    }
    
   @objc func clkc()
    {
     print("click test")
    }
    
    func constrait()
    {
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(300)
        }
    }

    

}
