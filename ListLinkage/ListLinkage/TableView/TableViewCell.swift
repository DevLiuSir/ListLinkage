//
//  TableViewCell.swift
//  ListLinkage
//
//  Created by Liu Chuan on 2018/2/15.
//  Copyright © 2018 LC. All rights reserved.
//

import UIKit

/// 左侧表格的自定义单元格
class TableViewCell: UITableViewCell {
    
    /// 标题文本标签
    var titleLabel = UILabel()
    
    /// 左侧装饰标签
    var leftTag = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //选中样式无
        selectionStyle = .none
        
        //初始化标题文本标签
        titleLabel.frame = CGRect(x: 15, y: 0, width: 60, height: 55)
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor(74, 74, 74)
        titleLabel.highlightedTextColor = .red
        contentView.addSubview(titleLabel)
        
        //初始化左侧装饰标签
        leftTag.frame = CGRect(x: 0, y: 20, width: 5, height: 15)
        leftTag.backgroundColor = .red
        contentView.addSubview(leftTag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //在底部绘制1像素的线条
    override func draw(_ rect: CGRect) {
        // 获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else { return }
        /// 线宽（1像素）
        let lineWidth = 1 / UIScreen.main.scale
        /// 线偏移量
        let lineAdjustOffset = 1 / UIScreen.main.scale / 2
        // 创建一个矩形，它的所有边都内缩固定的偏移量
        let drawingRect = self.bounds.insetBy(dx: lineAdjustOffset, dy: lineAdjustOffset)
        // 创建并设置路径
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: drawingRect.maxY))
        path.addLine(to: CGPoint(x: self.bounds.width, y: drawingRect.maxY))
        // 添加路径到图形上下文
        context.addPath(path)
        // 设置笔触颜色
        context.setStrokeColor(UIColor(225, 225, 225).cgColor)
        // 设置笔触宽度
        context.setLineWidth(lineWidth)
        // 绘制路径
        context.strokePath()
    }
    
    // 设置选中样式
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = selected ? UIColor.white : UIColor(white: 0, alpha: 0.1)
        isHighlighted = selected
        titleLabel.isHighlighted = selected
        leftTag.isHidden = !selected
    }
}

