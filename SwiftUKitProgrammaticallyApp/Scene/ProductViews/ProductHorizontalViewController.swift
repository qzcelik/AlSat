//
//  ViewController.swift
//  cvcell
//
//  Created by Max Nelson on 6/1/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage


class ProductVerticalViewController: UIViewController {
    
    var tableCount : Int = 0
    var dataArray : [ProductModel] = []
    
    init(tableCount: Int, dataArray: [ProductModel]) {
           
        self.tableCount = tableCount
        self.dataArray = dataArray
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        constrait()
    
    }
    
    func constrait()
    {
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(220)
            make.center.equalToSuperview()
        }
    }
}

extension ProductVerticalViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.7, height: collectionView.frame.width/2.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.data = dataArray[indexPath.item]
        
            let dataId = cell.data?.id
            let parameters : [String:Any] = [
                "userId" : LoginViewController.user.id!,
                "productId" : dataId!
            ]
                
        FavoriteService().request(url: "favoriteCheck.php", parameters: parameters,method: .post){(result) -> () in
                let checkResult = result[0] as! CheckModel
            
                if(checkResult.response == "ok")
                    {
                    cell.likeButton.tintColor = .red
                    }
                    else
                    {
                        cell.likeButton.tintColor = .white
                    }
                }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productViewController = ProductDetailViewController(data: dataArray[indexPath.item])
        productViewController.modalPresentationStyle = .fullScreen
        present(productViewController, animated:true,completion: nil)
    }
}


class CustomCell: UICollectionViewCell {
    
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
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    let likeButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: [])
        button.layer.cornerRadius = ConstantVariable.cornerRadius
        return button
    }()
    
    let shorDetail : UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.textColor = .black
        return label
    }()
    
    let price : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .systemOrange
        return label
    }()
    
    let card : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = ConstantVariable.cornerRadius
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.3
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(card)
        contentView.addSubview(producHorizontalImage)
        contentView.addSubview(productTitle)
        contentView.addSubview(likeButton)
        contentView.addSubview(shorDetail)
        contentView.addSubview(price)
      
        constrait()
        likeButton.addTarget(self, action: #selector(likeButtonClick), for: .touchUpInside)
    }

 
    
    @objc func likeButtonClick()
    {
        let dataId = data?.id
        let parameters : [String:Any] = [
            "userId" : LoginViewController.user.id!,
            "productId" : dataId!
        ]
    
        FavoriteService().request(url: "addFavorite.php", parameters: parameters, method: .post){(result) -> () in
            let checkResult = result[0] as! CheckModel
        
            if(checkResult.response == "ok")
                {
                    self.likeButton.tintColor = .red
                }
                else
                {
                    self.likeButton.tintColor = .white
                }
        }
    }
  
    
    func constrait()
    {
        likeButton.snp.makeConstraints { make in
            make.topMargin.equalTo(producHorizontalImage).offset(10)
            make.right.equalTo(producHorizontalImage).offset(-10)
            make.height.equalTo(15)
            make.height.equalTo(20)
        }
        
        producHorizontalImage.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(20)
            make.width.height.equalTo(135)
            make.centerX.equalToSuperview()
        }
        
        productTitle.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(producHorizontalImage)
            make.leftMargin.equalTo(contentView).offset(5)
            make.topMargin.equalTo(producHorizontalImage).offset(130)
        }
        
         shorDetail.snp.makeConstraints { make in
             make.height.equalTo(50)
             make.width.equalTo(contentView)
             make.topMargin.equalTo(productTitle).offset(15)
             make.leftMargin.equalTo(productTitle)
        }
        
        price.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(contentView)
            make.topMargin.equalTo(shorDetail)
            make.leftMargin.equalTo(productTitle).offset(90)
        }
        
        card.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
            
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
