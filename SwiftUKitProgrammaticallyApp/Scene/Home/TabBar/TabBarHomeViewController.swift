//
//  TabBarHomeViewController.swift
//  FormTest1
//
//  Created by ibrahim özçelik on 24.12.2023.
//

import UIKit
import SnapKit

class TabBarHomeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabVarInit()
    }
    
    func tabVarInit()
    {
        let tabBarController = UITabBarController()
        let VCHome = UINavigationController(rootViewController: HomeViewController())
        let VCProductDetail = UINavigationController(rootViewController: ProductFavViewController())
        
        VCHome.title = "Home"
        VCProductDetail.title = "Favori"
        
        tabBarController.setViewControllers([VCHome,VCProductDetail], animated:false)
        tabBarController.tabBar.layer.backgroundColor = UIColor.white.cgColor
        
        let tabBarIcons = ["house","star"]
        
        for x in 0..<tabBarIcons.count {
            tabBarController.tabBar.items?[x].image = UIImage(systemName: tabBarIcons[x])
        }
        
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }
    
    
    

     

}
