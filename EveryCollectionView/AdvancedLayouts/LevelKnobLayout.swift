//
//  Level Knob.swift
//  EveryCollectionView
//
//  Created by Hossam on 10/22/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class LevelKnobLayout : UICollectionViewLayout {
    var cache = [IndexPath:UICollectionViewLayoutAttributes]()
    let standardSize : CGFloat = 10
    let featuredSize  : CGFloat = 20
    let circleRadius : CGFloat = 120
    
    lazy var sizePerItems : [IndexPath : CGFloat] =  {
        var result = [IndexPath : CGFloat]()
        for item in 0..<self.collectionView!.numberOfItems(inSection: 0){
            result[IndexPath(item: item, section: 0)] = standardSize
        }
        return result
    }()
    
    var angelPerItem = [CGFloat]()
    
    override var collectionViewContentSize: CGSize{
        return .init(width: CGFloat(collectionView!.numberOfItems(inSection: 0) * 90), height: collectionView!.bounds.height - 140)
    }
    var offsetPerItem : CGFloat {
        return (collectionViewContentSize.width ) / CGFloat(collectionView!.numberOfItems(inSection: 0)   )
    }
    var getFirstLoad = false
    
    
    var currentFeaturedNow = 0
    override func prepare() {
        super.prepare()
      
        guard let collectionView = self.collectionView else {return}
        
        angelPerItem = sizePerItems.map{ size in
            (  2*CGFloat.pi) / (CGFloat(collectionView.numberOfItems(inSection: 0)))
        }
    
        var currentAngel : CGFloat = (3*CGFloat.pi) / 2
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = CircularAttributes(forCellWith: indexPath)
            let contentOffset = collectionView.contentOffset.x
            currentAngel += angelPerItem[item]
            attributes.center = .init(x: collectionView.center.x + contentOffset , y:  collectionView.center.y)
            
                
            attributes.size = .init(width: 10, height: self.sizePerItems[indexPath] ?? standardSize)
            let radius = ((attributes.size.height)  + circleRadius) / attributes.size.height
            attributes.anchorPoint = .init(x: 0.5, y: radius)
            attributes.transform = .init(rotationAngle: currentAngel)
            attributes.alpha = 0.5
            
            let maxItemOffset = CGFloat(item) * offsetPerItem
            
            let ratio = item  == 0 ? 1 : min(contentOffset , maxItemOffset)  / (offsetPerItem * CGFloat(item))
            let size = max(standardSize ,  (  (featuredSize ) * ratio))
            
            
            let currentFeatured   = (round(contentOffset / maxItemOffset))
            if  item == 1  {
                self.currentFeaturedNow = max(1,Int(currentFeatured))
                }
            
//            switch item {
//            case 0 ... currentFeaturedNow + 3 : self.sizePerItems[indexPath] = (size)
//            default: self.sizePerItems[indexPath] = standardSize
//            }
            self.sizePerItems[indexPath] = size
            
            attributes.alpha = max(0.2 ,  (  0.7 * ratio))
            cache[indexPath] = attributes
            if getFirstLoad {
                if let nextSize = cache[IndexPath(item: item + 1 , section: 0)]?.size.height{
                if sizePerItems[indexPath] == featuredSize  && item != collectionView.numberOfItems(inSection: 0)  && nextSize < featuredSize {
                    attributes.alpha = 1
                    
                   
                    }}
                
            }
            
        }
        if !getFirstLoad {
            self.getFirstLoad = true
        }
        
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.values.map{$0}
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    override class var layoutAttributesClass: AnyClass{
        return CircularAttributes.self
    }
}

