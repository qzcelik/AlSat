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
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
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
            make.height.equalTo(200)
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
        }
    }
    
       let producHorizontalImage: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let productTitle : UILabel =
    {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .red
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(producHorizontalImage)
        contentView.addSubview(productTitle)
        constrait()
    }
    
    func constrait()
    {
        producHorizontalImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        productTitle.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.center.equalTo(producHorizontalImage)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
