//
//  ProductVerticalTableView.swift
//  FormTest1
//
//  Created by ibrahim özçelik on 24.12.2023.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage

class ProductTableView : UIViewController {
    
    var dataArray : [ProductModel] = []
    var viewContorollerT : ConstantEnums.Views
    
    let tableViewVertical : UITableView =
    {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        tableView.register(TableViewCustomCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    init(prodcutTable : [ProductModel], viewController: ConstantEnums.Views) {
        self.dataArray = prodcutTable
        self.viewContorollerT = viewController
        super.init(nibName: nil, bundle: nil)
    }
    
    func updateData(prodcutTable : [ProductModel])
    {
        self.dataArray = prodcutTable
        tableViewVertical.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
           return dataArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCustomCell
           cell.data = dataArray[indexPath.item]
           return cell
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 120
       }
       
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          
           if (editingStyle == .delete)
           {
               let parameters : [String:Any] = [
                "productId" : dataArray[indexPath.row].id! as String
               ]
              
               DeleteProductService().request(url: "deleteMyProduct.php", parameters: parameters,method: .post) { (result) -> () in
                  let response =  result as? [CheckModel]
                  if(response![0].response == "ok")
                  {
                       self.dataArray.remove(at: indexPath.row)
                       tableView.deleteRows(at: [indexPath], with: .fade)
                  }
                }
           }
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           switch viewContorollerT
           {
               case .productDetail:
                   self.present(ProductDetailViewController(data: dataArray[indexPath.item]), animated:true,completion: nil)
               case .test:
                   print("test")
           }
       }
       
       class TableViewCustomCell : UITableViewCell{
           var data: ProductModel? {
               didSet {
                   guard let data = data else { return }
                   let pImage = AF.request(data.filePath!).responseImage { response in
                       self.producHorizontalImage.image = UIImage(data: response.data!)
                   }
                   productTitle.text = data.productTitle
                   shorDetail.text = data.fileName
                   price.text = "\(String(describing: data.productPrice!)) TL"
               }
           }
           
           let producHorizontalImage: UIImageView = {
               let image = UIImageView()
               image.contentMode = .scaleAspectFill
               image.clipsToBounds = true
               image.layer.cornerRadius = ConstantVariable.cornerRadius
               return image
           }()
           
           let productTitle : UILabel =
           {
               let label = UILabel()
               label.font = .boldSystemFont(ofSize: 18)
               label.textColor = .black
               return label
           }()
           
           
           
           let shorDetail : UILabel = {
               
               let label = UILabel()
               label.font = .systemFont(ofSize: 15)
               label.textColor = .black
               return label
           }()
           
           let price : UILabel = {
               let label = UILabel()
               label.font = .systemFont(ofSize: 12)
               label.textColor = .systemOrange
               return label
           }()
           
           
           override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
               super.init(style: style, reuseIdentifier: reuseIdentifier)
               contentView.addSubview(producHorizontalImage)
               contentView.addSubview(productTitle)
               contentView.addSubview(shorDetail)
               contentView.addSubview(price)
               constrait()
           }
           
           func constrait()
           {
               producHorizontalImage.snp.makeConstraints { make in
                   make.leftMargin.equalTo(20)
                   make.width.height.equalTo(100)
                   make.centerY.equalToSuperview()
               }
               
               productTitle.snp.makeConstraints { make in
                   make.height.equalTo(50)
                   make.width.equalTo(300)
                   make.leftMargin.equalTo(producHorizontalImage).offset(120)
                   make.topMargin.equalTo(10)
               }
               
               shorDetail.snp.makeConstraints { make in
                   make.height.equalTo(50)
                   make.width.equalTo(contentView)
                   make.topMargin.equalTo(productTitle).offset(25)
                   make.leftMargin.equalTo(productTitle)
               }
               
               price.snp.makeConstraints { make in
                   make.height.equalTo(50)
                   make.width.equalTo(contentView)
                   make.topMargin.equalTo(shorDetail).offset(15)
                   make.leftMargin.equalTo(shorDetail).offset(175)
               }
               
           }
           
           required init?(coder aDecoder: NSCoder) {
               fatalError("init(coder:) has not been implemented")
           }
       }
   }
