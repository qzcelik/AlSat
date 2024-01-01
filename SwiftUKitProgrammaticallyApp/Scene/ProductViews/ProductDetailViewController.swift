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
       image.contentMode = .scaleAspectFill
       image.clipsToBounds = true
       image.layer.cornerRadius = ConstantVariable.cornerRadius
       return image
    }()
    
    let productLikeButton : UIButton = {
        let image = UIButton()
        image.setImage(UIImage(systemName: "heart"), for:[])
        image.tintColor = .black
        return image
    }()
    
    let productTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let productDescriptionLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let productPriceLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let productBuyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Satın Al", for: [])
        button.setTitleColor(.white, for: [])
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = ConstantVariable.cornerRadius
        return button
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
        maninView.addSubview(productLikeButton)
        maninView.addSubview(productBuyButton)
        
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
            make.width.equalTo(350)
            make.height.equalTo(200)
            make.topMargin.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        productLikeButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.topMargin.equalTo(productTitleLabel).offset(10)
            make.leftMargin.equalTo(productTitleLabel).offset(300)
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
            make.topMargin.equalTo(productTitleLabel).offset(20)
            make.leftMargin.equalTo(50)
        }  
        
        productPriceLabel.snp.makeConstraints { make in
            make.width.equalTo(productImage)
            make.height.equalTo(50)
            make.topMargin.equalTo(productDescriptionLabel).offset(20)
            make.leftMargin.equalTo(50)
        }
        
        productBuyButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.topMargin.equalTo(productPriceLabel).offset(50)
            make.centerX.equalToSuperview()
        }
        
    }
    
    
  

}
