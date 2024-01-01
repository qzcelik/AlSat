//
//  ProductDetailViewController.swift
//  FormTest1
//
//  Created by ibrahim özçelik on 24.12.2023.
//

import UIKit
import SnapKit
import AlamofireImage
import Alamofire

class ProductDetailViewController: UIViewController {

    var data : ProductModel
    
    let maninView : UIView = {
       let view = UIView()
        return view
    }()
    
    let productImage : UIImageView = {
        
       let image = UIImageView()
       return image
    }()
    
    let productTitleLabel : UILabel = {
        
        let label = UILabel()
        return label
    }()
    
    let productDescriptionLabel : UILabel = {
        
        let label = UILabel()
        return label
    }()
    
    let productPriceLabel : UILabel = {
        
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    init(data: ProductModel ) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
        uiGenerater()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func uiGenerater()
    {
        maninView.addSubview(productImage)
        maninView.addSubview(productTitleLabel)
        maninView.addSubview(productDescriptionLabel)
        maninView.addSubview(productPriceLabel)
        
        view.addSubview(maninView)
        
        productTitleLabel.text = self.data.descriptionShort!
        productDescriptionLabel.text = self.data.descriptionLong!
        productPriceLabel.text = "\(self.data.price!) TL"
        
        AF.request(self.data.imageUrl!).responseImage{response in
            self.productImage.image = UIImage(data: response.data!)
        }
        constrait()
    }
    
    func constrait()
    {
        maninView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        
        productImage.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(200)
            make.topMargin.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        productTitleLabel.snp.makeConstraints { make in
            make.width.equalTo(productImage)
            make.height.equalTo(50)
            make.topMargin.equalTo(productImage).offset(200)
            make.leftMargin.equalTo(50)
        }  
        
        productDescriptionLabel.snp.makeConstraints { make in
            make.width.equalTo(productImage)
            make.height.equalTo(50)
            make.topMargin.equalTo(productTitleLabel).offset(30)
            make.leftMargin.equalTo(50)
        }  
        
        productPriceLabel.snp.makeConstraints { make in
            make.width.equalTo(productImage)
            make.height.equalTo(50)
            make.topMargin.equalTo(productDescriptionLabel).offset(30)
            make.leftMargin.equalTo(50)
        }
        
    }
    
    
  

}
