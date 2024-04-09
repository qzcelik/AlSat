//
//  ProductDetailViewController.swift
//  FormTest1
//
//  Created by ibrahim özçelik on 24.12.2023.
//

import UIKit
import SnapKit

class ProductFavViewController: UIViewController {

    let tableViewContainer : UIView = {
        let view = UIView()
        return view
    }()
    var productTableView : ProductTableView!
    var refreshControl = UIRefreshControl();
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favori"
        view.backgroundColor = .white
        view.addSubview(tableViewContainer)
        generateUI()
        contraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func refreshTableView()
    {
        let parameters : [String:Any] = [
            "userId" : LoginViewController.user.id!
        ]
        ProductService().request(url :"favorite.php", parameters: parameters,method:.post){(result) -> () in
                self.productTableView.updateData(prodcutTable: (result as? [ProductModel])!)
        }
        self.productTableView.tableViewVertical.refreshControl?.endRefreshing()
    }
    
    func generateUI()
    {
        
        let parameters : [String:Any] = [
            "userId" : LoginViewController.user.id!
        ]
        ProductService().request(url :"favorite.php", parameters: parameters,method: .post){(result) -> () in
                self.productTableView = ProductTableView(prodcutTable: (result as? [ProductModel])!, viewController: ConstantEnums.Views.productDetail)
                self.productTableView.willMove(toParent: self)
                self.tableViewContainer.addSubview(self.productTableView.view)
                self.productTableView.view.frame = self.tableViewContainer.bounds
                self.addChild(self.productTableView)
                self.productTableView.didMove(toParent: self)
                self.productTableView.tableViewVertical.refreshControl = self.refreshControl
                self.refreshControl.addTarget(self, action:#selector(self.refreshTableView), for: .valueChanged)
        }
    }
    
  func contraints()
    {
        tableViewContainer.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
  

}
