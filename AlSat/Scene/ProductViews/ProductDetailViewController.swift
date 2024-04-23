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
        image.setImage(UIImage(systemName: "heart.fill"), for:[])
        
        image.tintColor = .systemOrange
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
    
    let similarProductContainer : UIView = {
        let view = UIView()
        return view
    }()
    
    
    
    let productMessageButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: [])
        button.tintColor = .systemOrange
        button.layer.cornerRadius = ConstantVariable.cornerRadius
        return button
    }()
    
    let similarTitle : UILabel = {
        let label = UILabel()
        label.text = "Benzer Ürünler"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .systemOrange
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  ConstantVariable.backGroundColor
        uiGenerater()
        
       
    }
    
    @objc func backLeft(gesture: UISwipeGestureRecognizer)
    {
        self.modalTransitionStyle = .crossDissolve
        self.dismiss(animated: true, completion: nil)
        /*let homeView = TabBarHomeViewController()
        homeView.modalPresentationStyle = .fullScreen
        homeView.modalTransitionStyle = .crossDissolvefa
        present(homeView, animated: true, completion: nil)*/
    }
    
    init(data: ProductModel) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
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
        maninView.addSubview(productMessageButton)
        maninView.addSubview(similarTitle)
        maninView.addSubview(similarProductContainer)
        
        view.addSubview(maninView)
        
        productTitleLabel.text = self.data.fileName!
        productDescriptionLabel.text = self.data.productDescription!
        productPriceLabel.text = "\(self.data.productPrice!) TL"
        
        AF.request(self.data.filePath!).responseImage{response in
            self.productImage.image = UIImage(data: response.data!)
        }
        
        productLikeButton.addTarget(self, action: #selector(likeButtonClick), for: .touchUpInside)
        
        
        ProductService().request(url:"productGetData.php",parameters:nil,method: .post){(result) -> () in
            self.prepareSimilarProductContainer(data:  (result as? [ProductModel])!)
        }
        
        productMessageButton.addTarget(self, action: #selector(messageProduct), for: .touchUpInside)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(backLeft(gesture:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        constrait()
        
        let dataId = data.id
        let parameters : [String:Any] = [
            "userId" : LoginViewController.user.id!,
            "productId" : dataId ?? "",
        ]
            
        FavoriteService().request(url: "favoriteCheck.php", parameters: parameters, method: .post){(result) -> () in
            let checkResult = result[0] as! CheckModel
        
            if(checkResult.response == "ok")
                {
                    self.productLikeButton.tintColor = .red
                }
                else
                {
                    self.productLikeButton.tintColor = .systemOrange
                }
            }
        
        if(data.userId == LoginViewController.user.id)
        {
            productMessageButton.isHidden = true
            productLikeButton.isHidden = true
        }
        else
        {
            productLikeButton.isHidden = false
            productMessageButton.isHidden = false
        }
    }
    
   @objc func messageProduct()
    {
        var meesageViewControoler = MessageViewController()
        meesageViewControoler.productData = data
        present(meesageViewControoler, animated: true)
    }
    
    func prepareSimilarProductContainer(data: [ProductModel])
    {
        var randomData = [ProductModel]()
        randomData.append(data[Int.random(in: 0...data.count-1)])
        randomData.append(data[Int.random(in: 0...data.count-1)])
        
        let similarProducts = ProductVerticalViewController(tableCount: 2, dataArray: randomData)
        similarProducts.willMove(toParent: self)
        self.similarProductContainer.addSubview(similarProducts.view)
        similarProducts.view.frame = self.similarProductContainer.bounds
        self.addChild(similarProducts)
        similarProducts.didMove(toParent: self)
    }
    
    @objc func likeButtonClick()
    {
        let dataId = data.id
        let parameters : [String:Any] = [
            "userId" : LoginViewController.user.id!,
            "productId" : dataId ?? ""
        ]
        
        FavoriteService().request(url: "addFavorite.php", parameters: parameters, method: .post){(result) -> () in
            let checkResult = result[0] as! CheckModel
        
            if(checkResult.response == "ok")
                {
                    self.productLikeButton.tintColor = .red
                }
                else
                {
                    self.productLikeButton.tintColor = .systemOrange
                }
        }
    }
    
    func constrait()
    {
        maninView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        
        productImage.snp.makeConstraints { make in
            make.width.equalTo(400)
            make.height.equalTo(250)
            make.topMargin.equalTo(50)
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
            make.topMargin.equalTo(productImage).offset(250)
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
        
        productMessageButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.topMargin.equalTo(productLikeButton).offset(25)
            make.centerX.equalTo(productLikeButton)
        }
        
        similarTitle.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(productMessageButton).offset(60)
        }
        
        similarProductContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(300)
            make.topMargin.equalTo(similarTitle).offset(20)
            make.leftMargin.rightMargin.equalTo(50)
        }
        
    }
    
  
    
  

}
