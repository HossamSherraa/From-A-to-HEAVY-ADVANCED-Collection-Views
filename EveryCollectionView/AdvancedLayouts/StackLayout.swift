//
//  StackLayout.swift
//  EveryCollectionView
//
//  Created by Hossam on 10/11/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class StackLayout : UICollectionViewLayout {
    var cache = [UICollectionViewLayoutAttributes]()
   
     var itemHeight : CGFloat = 200
    override  var collectionViewContentSize: CGSize {
        CGSize.init(width: self.collectionView!.bounds.width, height: CGFloat(self.collectionView!.numberOfItems(inSection: 0) * 200) + self.collectionView!.bounds.height)
    }
    override func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView else {return}
        var frame = CGRect.zero
        var y : CGFloat = 0
        for item in 0..<collectionView.numberOfItems(inSection: 0){
           
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            frame = CGRect.init(x: 0.0, y:  max(y , collectionView.contentOffset.y), width: collectionView.bounds.width, height: itemHeight)
            
            print(y , collectionView.contentOffset.y)
            attributes.frame = frame
            attributes.zIndex = item
            cache.append(attributes)
            y += 200
           
        }
        
       
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.cache.filter{$0.frame.intersects(rect)}
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        self.cache[indexPath.row]
    }
    
}

