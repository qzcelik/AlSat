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
    
  func generateUI()
    {
        ProductService().productServiceRequest(){(result) -> () in
   
            let productTableView = ProductTableView(prodcutTable: result, viewController: ConstantEnums.Views.productDetail)
            productTableView.willMove(toParent: self)
            self.tableViewContainer.addSubview(productTableView.view)
            productTableView.view.frame = self.tableViewContainer.bounds
            self.addChild(productTableView)
            productTableView.didMove(toParent: self)
       
        }
    }
    
  func contraints()
    {
        tableViewContainer.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
  

}
