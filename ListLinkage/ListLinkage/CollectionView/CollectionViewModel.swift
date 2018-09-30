//
//  CollectionViewModel.swift
//  ListLinkage
//
//  Created by Liu Chuan on 2018/2/15.
//  Copyright © 2018 LC. All rights reserved.
//

import UIKit

/// 右侧collectionView的数据模型（大分类下的小分类）
class CollectionViewModel: NSObject {
    
    /// 小分类名称
    var name : String
    
    /// 小分类图片
    var picture : String
    
    /// 自定义初始化方法
    ///
    /// - Parameters:
    ///   - name: 分类名称
    ///   - picture: 分类图片
    init(name: String, picture: String) {
        self.name = name
        self.picture = picture
    }
}
