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
        let VCProfil = UINavigationController(rootViewController: ProfilViewController())
        
        VCHome.title = "Home"
        VCProductDetail.title = "Favori"
        VCProfil.title = "Profil"
        
        tabBarController.setViewControllers([VCHome,VCProductDetail,VCProfil], animated:false)
        tabBarController.tabBar.layer.backgroundColor = UIColor.white.cgColor
        
        let tabBarIcons = ["house","star","person"]
        
        for x in 0..<tabBarIcons.count {
            tabBarController.tabBar.items?[x].image = UIImage(systemName: tabBarIcons[x])
            tabBarController.tabBar.tintColor = .systemOrange
        }
        
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }
    
    
    

     

}
