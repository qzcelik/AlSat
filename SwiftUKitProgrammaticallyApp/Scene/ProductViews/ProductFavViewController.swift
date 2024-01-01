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
        /*let alert = UIAlertController(title: "title", message: "did load", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)*/
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       /* let alert = UIAlertController(title: "title", message: "Appear", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)*/
    }
    
  func generateUI()
    {
        ProductService().productServiceRequest(){(result) -> () in
   
            let productTableView = ProductTableView(prodcutTable: result)
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
