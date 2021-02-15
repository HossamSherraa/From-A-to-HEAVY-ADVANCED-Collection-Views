//
//  CircularLayout.swift
//  EveryCollectionView
//
//  Created by Hossam on 10/13/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class CircularLayout : UICollectionViewLayout {
    var cache = [UICollectionViewLayoutAttributes]()
    
    var itemSize : CGFloat {
       return min(self.collectionView!.bounds.width / 18, self.collectionView!.bounds.height / 18)
    }
    
    var sizePerItem = [IndexPath : CGFloat]()
    var angelPerItem = [IndexPath : CGFloat]()
  
    
    override var collectionViewContentSize: CGSize {
        return CGSize.init(width: self.collectionView!.bounds.width, height: CGFloat(self.collectionView!.numberOfItems(inSection: 0)) * 420)
    }
    override func prepare() {
       
        super.prepare()
        cache.removeAll()
       
        guard let collectionView = self.collectionView else {return}
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let indexPaths = (0..<numberOfItems).map{IndexPath(item: $0, section: 0)}
        
        if sizePerItem.isEmpty{
        (0..<numberOfItems).forEach{let index = indexPaths[$0]
                   
           
            sizePerItem[index] = itemSize*3}}
                  
               
    
        //CalculateThe R Of All Items
        let redient = sizePerItem.values.reduce(0) { (Res, Val) -> CGFloat in
            return Res + Val
        }
        
        
        // Calculate RediusOfItems
        let radius : CGFloat = (redient / (2*CGFloat.pi))
       
      
        
       // Calculate AngelPerItemSize
        for item in 0..<numberOfItems {
            guard let size = sizePerItem[IndexPath(item: item, section: 0)] else {return}
                angelPerItem[indexPaths[item]] = ((size ) / ( radius))}
        
       
        //HelperPropeties
        let centerOfX = collectionView.bounds.width / 2
        let contentOffset = collectionView.contentOffset.y + collectionView.bounds.height/2
        let centerYOffset = collectionView.bounds.height/2  + contentOffset
        let angelYOffset = -angelPerItem.values.reduce(0) { (R, V) -> CGFloat in
            return R + V
            } * (contentOffset / self.collectionViewContentSize.height)
        //StartBuildAttributes
        var angelTotal : CGFloat = 0
      
        for item in 0..<numberOfItems {
            let indexPath = indexPaths[item]
            guard let size = sizePerItem[IndexPath(item: item, section: 0)] , let angel = self.angelPerItem[indexPath] else {return}
            let anchorPoint = ((radius + (size/2)) / size ) - (size/2920)
            let attributes = CircularAttributes(forCellWith: indexPaths[item])
            angelTotal += angel
            attributes.angel = angelTotal + angelYOffset
 
            attributes.anchorPoint = .init(x: 1, y: anchorPoint )
            attributes.size = .init(width: size, height: size)
            attributes.center = .init(x: centerOfX, y: centerYOffset)
            
            let itemOffset = abs((attributes.frame.minX + (attributes.size.height / 2)) - collectionView.bounds.midX)
            let sizeOffset = max(itemSize, itemSize * 4 - (itemOffset*3))
            self.sizePerItem[indexPath] = sizeOffset
                        
            
                
          
            cache.append(attributes)
            
        }
        
        
        
    }
    override class var layoutAttributesClass: AnyClass{
        CircularAttributes.self
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter{$0.frame.intersects(rect)}
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
