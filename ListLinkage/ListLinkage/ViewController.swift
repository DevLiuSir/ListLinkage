//
//  ViewController.swift
//  ListLinkage
//
//  Created by Liu Chuan on 2018/2/15.
//  Copyright © 2018 LC. All rights reserved.
//

import UIKit


/// 表格宽度
private let tableViewWidth: CGFloat = 80

/// 间距
private let margin: CGFloat = 2

/// 单元格的个数
private let itemCout: CGFloat = 3

/* 单元格重用标识符 */
private let tableCell = "tableCell"
private let collectionViewCell = "collectionViewCell"
private let collectionViewHeader = "collectionViewHeader"


class ViewController: UIViewController {
    
    // MARK: - Attribute
    
    /// 左侧tableView数据
    var tableViewData = [String]()
    
    /// 右侧collectionView数据
    var collectionViewData = [[CollectionViewModel]]()
    
    /// 右侧collectionView当前是否正在向下滚动（即true表示手指向上滑动，查看下面内容）
    var collectionViewIsScrollDown = true
    
    /// 右侧collectionView垂直偏移量
    var collectionViewLastOffsetY : CGFloat = 0.0
    
    // MARK: - Lazy loading
    
    /// 左侧tableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: tableViewWidth, height: screenH)
        tableView.rowHeight = 55
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: tableCell)
        return tableView
    }()
    
    /// 右侧collectionView的布局
    private lazy var flowlayout : UICollectionViewFlowLayout = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumLineSpacing = margin
        flowlayout.minimumInteritemSpacing = margin
//        flowlayout.sectionHeadersPinToVisibleBounds = true          // 分组头部是否悬停
        let itemWidth = (screenW - tableViewWidth - margin * 4) / itemCout
        flowlayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 30)
        return flowlayout
    }()
    
    /// 右侧collectionView
    private lazy var collectionView : UICollectionView = {
        let collFrame = CGRect(x: tableViewWidth + margin, y: navigationH + margin, width: screenW - tableViewWidth - margin * 2, height: screenH - navigationH - margin * 2)
        let collectionView = UICollectionView(frame: collFrame, collectionViewLayout: flowlayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCell)
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeader)
        return collectionView
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configData()
    }
}

// MARK: - Custom Method
extension ViewController {
    
    /// 配置UI界面
    private func configUI() {
        view.addSubview(tableView)
        view.addSubview(collectionView)
        //左侧表格默认选中第一项
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
    }
    
    /// 配置数据
    private func configData() {
        // 初始化左侧表格数据
        for i in 1 ..< 15 {
            self.tableViewData.append("分类\(i)")
        }
        // 初始化右侧collectionView数据
        for _ in tableViewData {
            var models = [CollectionViewModel]()
            for i in 1 ..< 6 {
                models.append(CollectionViewModel(name: "型号\(i)", picture: "image.jpg"))
            }
            self.collectionViewData.append(models)
        }
    }
    
    /// 将右侧colletionView的指定分区自动滚动到最顶端
    ///
    /// - Parameters:
    ///   - section: 组
    ///   - animated: 是否动画
    private func collectionViewScrollToTop(section: Int, animated: Bool) {
        
        let headerRect = collectionViewHeaderFrame(section: section)
        
        let topOfHeader = CGPoint(x: 0, y: headerRect.origin.y - collectionView.contentInset.top)
        
        collectionView.setContentOffset(topOfHeader, animated: animated)
    }
    
    /// 获取colletionView的指定分区头的高度
    ///
    /// - Parameter section: 分区
    /// - Returns: 位置
    private func collectionViewHeaderFrame(section: Int) -> CGRect {
        let indexPath = IndexPath(item: 0, section: section)
        let attributes = collectionView.layoutAttributesForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        
        guard let frameForFirstCell = attributes?.frame else {
            return .zero
        }
        return frameForFirstCell
    }
    
/*
    private func collectionViewHeaderFrame(section: Int) {
        
        let indexPath = IndexPath(item: 0, section: section)
        if let attributes = collectionView.layoutAttributesForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath) {
            var offsetY = attributes.frame.origin.y - collectionView.contentInset.top
            if #available(iOS 11.0, *) {
                offsetY -= collectionView.safeAreaInsets.top
            }
            collectionView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true) // or animated: false
        }
    }
*/
    
    /// 当拖动 CollectionView 的时候，处理左侧表格，自动选中该分区对应的分类
    ///
    /// - Parameter index: 下标
    private func selectRow(index : Int) {
        tableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .middle)
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! TableViewCell
        cell.titleLabel.text = tableViewData[indexPath.row]
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        // 解决点击 TableView 后 CollectionView 的 Header 遮挡问题。 右侧collection自动滚动到对应的分区
        collectionViewScrollToTop(section: indexPath.item, animated: true)
        
        // 左侧tableView将该单元格滚动到顶部
        tableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .top, animated: true)
    }
    
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tableViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCell, for: indexPath) as! CollectionViewCell
        let model = collectionViewData[indexPath.section][indexPath.row]
        cell.setData(model)
        return cell
    }
    
    // 返回自定义分区头
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeader, for: indexPath) as! CollectionViewHeader
        view.titleLabel.text = tableViewData[indexPath.section]
        return view
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    // 分区头即将要显示时调用
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        //如果是由用户手动滑动屏幕造成的向上滚动，那么左侧表格自动选中该分区对应的分类
        if !collectionViewIsScrollDown && (collectionView.isDragging || collectionView.isDecelerating) {
            
            selectRow(index: indexPath.section)
        }
    }
    
    // 分区头即将要消失时调用
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        
        //如果是由用户手动滑动屏幕造成的向下滚动，那么左侧表格自动选中该分区对应的下一个分区的分类
        if collectionViewIsScrollDown && (collectionView.isDragging || collectionView.isDecelerating) {
            
            selectRow(index: indexPath.section + 1)
        }
    }
    
    // 视图滚动时触发（主要用于记录当前collectionView是向上还是向下滚动）
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView == scrollView {
            collectionViewIsScrollDown = collectionViewLastOffsetY < scrollView.contentOffset.y
            collectionViewLastOffsetY = scrollView.contentOffset.y
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // 分区头部视图尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenW, height: 30)
    }
}
