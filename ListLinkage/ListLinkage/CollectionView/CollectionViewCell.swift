//
//  CollectionViewCell.swift
//  ListLinkage
//
//  Created by Liu Chuan on 2018/2/15.
//  Copyright © 2018 LC. All rights reserved.
//


import UIKit

/// 右侧collectionView的自定义单元格
class CollectionViewCell: UICollectionViewCell {
    
    //标题文本标签
    private lazy var titleLabel = UILabel()
    
    //产品图片视图
    private lazy var pictureView = UIImageView()
    
    /// 初始化
    ///
    /// - Parameter frame: 尺寸
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 初始化标题文本标签
        titleLabel.frame = CGRect(x: 2, y: frame.size.width, width: frame.size.width - 4, height: 20)
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        
        // 初始化产品图片视图
        pictureView.frame = CGRect(x: 8, y: 8, width: frame.size.width - 16, height: frame.size.width - 16)
        pictureView.contentMode = .scaleAspectFit
        contentView.addSubview(pictureView)
    }
    
    /// 设置数据
    ///
    /// - Parameter model: CollectionViewModel
    func setData(_ model : CollectionViewModel) {
        titleLabel.text = model.name
        pictureView.image = UIImage(named: model.picture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
