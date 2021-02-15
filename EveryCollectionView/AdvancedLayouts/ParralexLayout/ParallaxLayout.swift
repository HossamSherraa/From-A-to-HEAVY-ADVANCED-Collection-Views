//
//  ParallaxLayout.swift
//  EveryCollectionView
//
//  Created by Hossam on 10/25/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class ParallaxLayout : UICollectionViewLayout {
    var cache = [UICollectionViewLayoutAttributes]()
    let maxParallex : CGFloat = 40
    let itemWidth : CGFloat = 180
    let lineSpace : CGFloat = 23
    var itemHeight : CGFloat {
        620
    }
    
    
    override var collectionViewContentSize: CGSize{
        let totalWidthOfItems =  itemWidth * CGFloat(collectionView!.numberOfItems(inSection: 0))
        let totalLineSpace = lineSpace * CGFloat(collectionView!.numberOfItems(inSection: 0))
        return CGSize.init(width: totalWidthOfItems + totalLineSpace, height: collectionView!.bounds.height * 0.8)
    }
    var itemTotalSpace : CGFloat {
        itemWidth + lineSpace
    }
    var isLoaded = false
    override func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView else {return}
        self.cache.removeAll()
        var frame = CGRect.zero
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = ParalexAttributes(forCellWith: indexPath)
            frame = .init(x: frame.maxX + lineSpace, y: collectionView.bounds.midY - (itemHeight*0.5), width: itemWidth, height: itemHeight)
           
           
            let currentOffset = collectionView.contentOffset.x
            let distanceFromOffset = max(0,(frame.maxX - currentOffset))
            let currentRatio = distanceFromOffset  / itemTotalSpace
//            let con = currentRatio - CGFloat(Int(currentRatio)) MISSION FAIL , IDEEEAAA
            
            let transform = (maxParallex - max(0, currentRatio * maxParallex))
            
            attributes.sizeOfItem = .init(width: itemWidth + maxParallex , height: itemHeight)
            attributes.parallax = .init(translationX:  transform, y: 0)
             attributes.frame = frame
            cache.append(attributes)
           
        }
        
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.cache
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
}
