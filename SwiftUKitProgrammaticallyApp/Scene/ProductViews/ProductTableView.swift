//
//  ProductVerticalTableView.swift
//  FormTest1
//
//  Created by ibrahim özçelik on 24.12.2023.
//

import UIKit
import SnapKit

class ProductTableView : UIViewController {
    
    
    let tableViewVertical : UITableView =
    {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        view.addSubview(tableViewVertical)
        tableViewVertical.translatesAutoresizingMaskIntoConstraints = true
        constrait()
        tableViewVertical.delegate = self
        tableViewVertical.dataSource = self
        
    }
    
    func constrait()
    {
        tableViewVertical.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
    }
    
}

   extension ProductTableView : UITableViewDelegate, UITableViewDataSource
{
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 15
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           cell.textLabel?.text = "Test"
           return cell
       }
       
       
   }
