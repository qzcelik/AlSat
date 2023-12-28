//
//  ViewController.swift
//  cvcell
//
//  Created by Max Nelson on 6/1/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import UIKit
import SnapKit

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
        return cell
    }
}


class CustomCell: UICollectionViewCell {
    
    var data: ProductModel? {
        didSet {
            guard let data = data else { return }
            producHorizontalImage.image = data.image
            productTitle.text = data.title
            shorDetail.text = data.shortDetail
            price.text = "\(data.price) TL"
        }
    }
    
       let producHorizontalImage: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = ConstantVariable.cornerRadius
        return iv
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
        button.setImage(UIImage(systemName: "heart"), for: [])
        button.tintColor = .white
        return button
    }()
    
    let shorDetail : UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    let price : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .black
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(producHorizontalImage)
        contentView.addSubview(productTitle)
        contentView.addSubview(likeButton)
        contentView.addSubview(shorDetail)
        contentView.addSubview(price)
        constrait()
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
            make.topMargin.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        productTitle.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(producHorizontalImage)
            make.leftMargin.bottomMargin.equalTo(contentView).offset(5)
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
            make.topMargin.equalTo(shorDetail).offset(15)
            make.leftMargin.equalTo(shorDetail)
        }
            
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
