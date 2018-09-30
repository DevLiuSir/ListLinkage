//
//  UIView+Extension.swift
//  ListLinkage
//
//  Created by Liu Chuan on 2018/1/4.
//  Copyright © 2018 LC. All rights reserved.
//

import UIKit

// MARK: - 全局常量

/// 屏幕的宽度
let screenW = UIScreen.main.bounds.width

/// 屏幕的高度
let screenH = UIScreen.main.bounds.height

/// iPhone4
let isIphone4 = screenH < 568 ? true : false

/// iPhone 5
let isIphone5 = screenH == 568 ? true : false

/// iPhone 6\7\8
let isIphone6 = screenH == 667 ? true : false

/// iphone 6\7\8P
let isIphone6P = screenH == 736 ? true : false

/// iphone X\XS/XS Max
let isIphoneX = screenH >= 812 ? true : false

/// 状态栏的高度
let statusH: CGFloat = UIApplication.shared.statusBarFrame.size.height > 20 ? 44 : 20

/// 导航栏的高度
let navigationH: CGFloat = isIphoneX ? 44 + statusH : 64

/// 标签栏的高度
let tabBarH: CGFloat = isIphoneX ? 49 + 34 : 49


// MARK: - UIViewExtension
extension UIView {
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }
    
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame.origin = newValue
        }
    }
    
    var width: CGFloat {
        get {
            return self.size.width
        }
        set {
            self.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return self.size.height
        }
        set {
            self.size.height = newValue
        }
    }
    
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set {
            self.origin.y = newValue
        }
    }
}
