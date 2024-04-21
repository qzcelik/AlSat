//
//  MessageListViewController.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 9.04.2024.
//

import UIKit

class MessageListViewController: UIViewController {
    
    
    var messageTableView : UITableView =
    {
        let tableView  = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        generateUI()
        contraints()
        fetchDataFromServer()
    }
    
    var messageList : [MessageModel] = []{
        didSet{
            DispatchQueue.main.async {
                self.messageTableView.reloadData()
            }
        }
    }
    
    var productList : [ProductModel] = []
    
    func generateUI()
    {
        messageTableView.delegate = self
        messageTableView.dataSource = self
        view.addSubview(messageTableView)
    }
    
    func fetchDataFromServer()
    {
        let parameters : [String:Any] = [
            "userId" : LoginViewController.user.id!
        ]
        
        MessageListService().request(url: "messageGetForList.php", parameters: parameters, method: .post){(result) -> () in
            self.messageList = (result as? [MessageModel])!
        }
      
    }
    
    func contraints()
      {
          messageTableView.snp.makeConstraints { make in
              make.width.height.equalToSuperview()
          }
      }
}

extension MessageListViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        productDataFetchFromServer(productId: self.messageList[indexPath.row].productId!) {productList in
                
            if  !productList.isEmpty  {
                self.productList = productList
                cell.textLabel?.text  = self.productList[0].productTitle! + " ürünü için mesajınız var"
            }
        }
        return cell
    }
    
    func productDataFetchFromServer(productId : String, completion: @escaping([ProductModel]) -> Void)
    {
        
        let parameters : [String:Any] = [
            "productId" : productId
        ]
        
        ProductService().request(url: "productSelectedData.php", parameters: parameters, method: .post){(result) -> () in
           
        if let productList = result as? [ProductModel]
            {
                completion(productList)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let messageView = MessageViewController()
        messageView.messageData = messageList[indexPath.row]
        present(messageView, animated: true)
    }
    
    
}
