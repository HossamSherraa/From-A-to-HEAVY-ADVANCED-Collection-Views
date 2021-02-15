//
//  CircularLayoutV2.swift
//  EveryCollectionView
//
//  Created by Hossam on 10/18/19.
//  Copyright © 2019 Hossam. All rights reserved.
//


import UIKit
class CircularLayoutV2 : UICollectionViewLayout {
    var cache = [UICollectionViewLayoutAttributes]()
    
    var itemSize : CGFloat {
       return min(self.collectionView!.bounds.width / 7, self.collectionView!.bounds.height / 7)
    }
    
    var sizePerItem = [IndexPath : CGFloat]()
    var angelPerItem = [IndexPath : CGFloat]()
  
    
    override var collectionViewContentSize: CGSize {
        return CGSize.init(width: self.collectionView!.bounds.width, height: CGFloat(self.collectionView!.numberOfItems(inSection: 0)) * 120)
    }
    
    override func prepare() {
        super.prepare()
        cache.removeAll()
       
        guard let collectionView = self.collectionView else {return}
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let indexPaths = (0..<numberOfItems).map{IndexPath(item: $0, section: 0)}
        
      
        if self.sizePerItem.isEmpty{
            (0..<numberOfItems).forEach{let index = indexPaths[$0]
               
                sizePerItem[index] = itemSize
               
            }
        }
            
        
        //CalculateThe R Of All Items
        let diameter : CGFloat = self.sizePerItem.values.reduce(0) { (Res, Val) -> CGFloat in
                return Res + Val
            }
        
        
        // Calculate RediusOfItems
        let radius : CGFloat = (diameter / (2*CGFloat.pi))
       
      
        
       // Calculate AngelPerItemSize
        for item in 0..<numberOfItems {
            if let size = self.sizePerItem[indexPaths[item]]{
                angelPerItem[indexPaths[item]] = ((size ) / ( radius))
            }
        }

      // Generate Attributes
        //2==0.5
        let centerOfX = collectionView.bounds.midX
        let featuredSize = self.itemSize * 2
        let contentOffset = collectionView.contentOffset.y + collectionView.bounds.height/2
        let angelYOffset = -angelPerItem.values.reduce(0) { (R, V) -> CGFloat in
        return R + V
        } * (contentOffset / self.collectionViewContentSize.height)
        var currentAngel : CGFloat = 0
        for item in 0..<numberOfItems {
          let indexPath = indexPaths[item]
            guard let size = self.sizePerItem[indexPath] else {return}
            guard let angel = self.angelPerItem[indexPath] else {return}
          let attributes = CircularAttributes(forCellWith: indexPath)
            currentAngel += angel
            let xValue = (( radius) * cos((currentAngel - angel*0.5) + angelYOffset)) + (collectionView.bounds.midX)
            let yValue = (( radius ) * sin((currentAngel - angel*0.5) + angelYOffset )) + (collectionView.bounds.maxY)
            let offsetOfCenter = abs((xValue / centerOfX) - 1)
            
           
            attributes.center = .init(x: xValue , y: yValue )
            var currentSize = max(itemSize, (featuredSize - (featuredSize * offsetOfCenter)))
            if yValue > collectionView.bounds.maxY{
                currentSize = size
            }
            self.sizePerItem[indexPath] = currentSize
            
            attributes.size = .init(width: currentSize , height: currentSize)
            cache.append(attributes)
            
        }
        
        
    }
    override class var layoutAttributesClass: AnyClass{
        CircularAttributes.self
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
       return cache
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        self.cache[indexPath.row]
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return .init(x: proposedContentOffset.x + 40, y: proposedContentOffset.y + 40)
    }
   
    
}
