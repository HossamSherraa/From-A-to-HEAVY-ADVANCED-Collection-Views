//
//  StackCardsLayout.swift
//  EveryCollectionView
//
//  Created by Hossam on 10/26/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class StackCardsLayout : UICollectionViewLayout{
    var cache = [CircularAttributes]()
    var itemSize : CGSize {
        var itemWidth : CGFloat {
            return self.collectionView!.bounds.width * 0.6
        }
        var itemHeight : CGFloat {
            return self.collectionView!.bounds.height * 0.56
        }
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    override var collectionViewContentSize: CGSize {
        return .init(width: 4500, height: self.collectionView!.bounds.height - 140)
    }
    
    var spaceToItem  : CGFloat = 10
    
    var numberOfItems : CGFloat {
        return CGFloat(self.collectionView!.numberOfItems(inSection: 0))
    }
    
    var offsetPerItem : CGFloat {
        return collectionViewContentSize.width / numberOfItems
    }
   
    let angel = -(CGFloat.pi / 6)
    var translate : CGFloat {
        -130
    }
    
    var lastFeatured : Int = 0
    override func prepare() {
        
        super.prepare()
        guard let collectionView = self.collectionView else {return}
        let startPoint : CGPoint =  CGPoint(x: collectionView.bounds.width * 0.4 + collectionView.contentOffset.x, y: collectionView.bounds.height * 0.2)
        let currentOffset = max(0, collectionView.contentOffset.x)
        self.cache.removeAll(keepingCapacity: true)
        let frame = CGRect(origin: startPoint, size: itemSize)
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = CircularAttributes(forCellWith: indexPath)

            attributes.frame = frame
            let ratioOfItem = min (1 , item == 0 ? currentOffset / offsetPerItem : max(0, (currentOffset / offsetPerItem) - CGFloat(item)))
           
           let currentAngel = CGAffineTransform.init(rotationAngle: angel * ratioOfItem)
            attributes.angel = abs(angel * ratioOfItem)
            let currentTransform = CGAffineTransform.init(translationX: ratioOfItem * translate, y: ratioOfItem * -translate/2)
            attributes.transform = currentAngel.concatenating(currentTransform)
            attributes.zIndex = attributes.angel > 0 ? abs(attributes.zIndex - Int(numberOfItems)) : Int(numberOfItems - CGFloat(item))
            if attributes.angel == 0 {
                switch item {
                case 0 : attributes.alpha = 1
                case lastFeatured...lastFeatured + 2 : attributes.alpha = 1
                case lastFeatured + 3 : attributes.alpha = 0.7
                case lastFeatured + 4 : attributes.alpha = 0.2
            
                default : attributes.alpha = 0
                }
            }else {
                attributes.alpha = 1
            }
              
             
            cache.append(attributes)
           
            self.lastFeatured = self.cache.filter{$0.angel == abs(angel)}.last?.indexPath.row ?? 0
            
            
           
        }
        
        
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    override class var layoutAttributesClass: AnyClass{
        CircularAttributes.self
    }
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
       .init(x: CGFloat(Int(proposedContentOffset.x / offsetPerItem)) * offsetPerItem, y: 0)
    }
}
