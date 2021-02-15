//
//  MosaicLayout.swift
//  EveryCollectionView
//
//  Created by Hossam on 9/10/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class MosaicLayout : UICollectionViewLayout{
    var data = [CGFloat]()
    let numberOfColumns : CGFloat = 2
    var contentHeight  : CGFloat = 0
    let cellHeight  : CGFloat = 300
    
    var cache = [UICollectionViewLayoutAttributes]()
    override var collectionViewContentSize: CGSize{
        return .init(width: self.collectionView!.bounds.width, height: contentHeight)
    }
    override func prepare() {
        if cache.isEmpty {
           
            
            var yOffset = [CGFloat].init(repeating: 0, count: Int(numberOfColumns))
             var xOffset = [CGFloat].init(repeating: 0, count: Int(numberOfColumns))
            let itemWidth = (self.collectionView!.bounds.width / numberOfColumns) - 10
            var column = 0
            for item in 0..<self.collectionView!.numberOfItems(inSection: 0){
                let indexPath = IndexPath(item: item, section: 0)
               
                for (index , _ )in xOffset.enumerated() {
                    xOffset[index] = CGFloat(index) * itemWidth + 10
                }

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: itemWidth, height: data[item]/2)
                attributes.frame = frame.inset(by: .init(top: 0, left: 10, bottom: 20, right: 10))
                                cache.append(attributes)
                self.contentHeight = max(frame.maxY, self.contentHeight)
                
                 yOffset[column] =  yOffset[column] + data[item]/2
                column = column >= Int(numberOfColumns-1) ? 0 : column + 1
               
                
            }
            
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.cache.filter{$0.frame.intersects(rect)}
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        self.cache[indexPath.row]
    }
    
}
