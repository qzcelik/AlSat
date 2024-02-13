//
//  SearchViewController.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 13.02.2024.
//

import UIKit

class SearchViewController: UIViewController {
     
    var searchData : String = ""
    
      let tableViewContainer : UIView = {
               let view = UIView()
               return view
           }()
           var productTableView : ProductTableView!
           var refreshControl = UIRefreshControl();
         
           
           override func viewDidLoad() {
               super.viewDidLoad()
               title = "Arama"
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
                   "productName" : searchData
               ]
               ProductService().request(url :"search.php", parameters: parameters, method: .get){(result) -> () in
                       self.productTableView.updateData(prodcutTable: (result as? [ProductModel])!)
               }
               self.productTableView.tableViewVertical.refreshControl?.endRefreshing()
           }
           
           func generateUI()
           {
               
               let parameters : [String:Any] = [
                   "productName" : searchData
               ]
               ProductService().request(url :"search.php", parameters: parameters, method: .get){(result) -> () in
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


