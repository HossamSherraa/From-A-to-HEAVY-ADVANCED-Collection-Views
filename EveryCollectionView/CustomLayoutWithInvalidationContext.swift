//
//  CustomLayoutWithInvalidationContext.swift
//  EveryCollectionView
//
//  Created by Hossam on 9/22/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class CustomLayoutWithInvalidationContext : UICollectionViewLayout {
    let numberOfColumns = 1
    let itemHeight : CGFloat = 300
    let itemWidth : CGFloat = 300
    var contentHeight = CGSize.zero
    var cache = [UICollectionViewLayoutAttributes]()
    var flag = false
    override func prepare() {
        
        print(#function)
        initPrepare(numberOfItems: self.collectionView!.numberOfItems(inSection: 0), firstFlag: flag)
    }
    
    
    func initPrepare(numberOfItems : Int , firstFlag : Bool)
    {
        
        if firstFlag {
           
          
           
            var frame = CGRect.zero
            var y : CGFloat = 0
            for item in 0...1{
                let indexPath = IndexPath(item: item, section: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                frame = CGRect.init(x: self.collectionView!.bounds.width/2 - 150, y: self.collectionView!.contentOffset.y + y, width: itemWidth, height: itemHeight)
                if item == 0 {
                    attributes.frame = CGRect.init(x: self.collectionView!.bounds.width/2 - 150, y: self.collectionView!.contentOffset.y + y, width: itemWidth, height: itemHeight)
                    attributes.zIndex = 3
                    attributes.alpha = 0.8
                }
                else {
                    attributes.frame = frame}
                cache[item] = attributes
               
                y = frame.maxY
            }
            flag = false
        }
       
        else {
            print("EN NO FL")
            cache.removeAll()
        var frame = CGRect.zero
        var y : CGFloat = 0
        for item in 0..<numberOfItems{
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            frame = CGRect.init(x: self.collectionView!.bounds.width/2 - 150, y: y, width: itemWidth, height: itemHeight)
            if item == 0 {
                attributes.frame = CGRect.init(x: self.collectionView!.bounds.width/2 - 150, y: self.collectionView!.contentOffset.y, width: itemWidth, height: itemHeight)
                attributes.zIndex = 3
                attributes.alpha = 0.8
            }
            else {
                attributes.frame = frame}
            cache.append(attributes)
            contentHeight = .init(width: self.collectionView!.bounds.width, height: frame.maxY)
            y = frame.maxY
        }
        }
        flag = false
    }
    class override var invalidationContextClass: AnyClass  {
        return invlContext.self
    }
    
    override var collectionViewContentSize: CGSize{
        return contentHeight
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter{$0.frame.intersects(rect)}
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
    }
    
    
    func addInvalidatedAttributes(indexPath : IndexPath) {
      
       
        
    }
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
       
        let context = context as! invlContext
        
        
       
        
        
        super.invalidateLayout(with: context)
        
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        flag = false
        let context = super.invalidationContext(forBoundsChange: newBounds) as! invlContext
        context.invalidateItems(at: [IndexPath(item: 0, section: 0)])
        
        
        return context
    }
    
    
    
    override func invalidationContext(forInteractivelyMovingItems targetIndexPaths: [IndexPath], withTargetPosition targetPosition: CGPoint, previousIndexPaths: [IndexPath], previousPosition: CGPoint) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forInteractivelyMovingItems: targetIndexPaths, withTargetPosition: targetPosition, previousIndexPaths: previousIndexPaths, previousPosition: previousPosition)
        flag = true
       
        return context
    }
    
}

class invlContext : UICollectionViewLayoutInvalidationContext{
   

}
