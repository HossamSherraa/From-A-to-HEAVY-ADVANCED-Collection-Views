//
//  FeaturedStackLayout.swift
//  EveryCollectionView
//
//  Created by Hossam on 10/19/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class FeaturedStackLayout : UICollectionViewLayout {
    var cache = [UICollectionViewLayoutAttributes]()
    let size : CGFloat = 120
    let featuredSize : CGFloat = 280
    var heightOfCollectionView : CGFloat = 0
    var scaleRatio : CGFloat = 0
             var sizeToBeFeatured : CGFloat  = 0
    var frame = CGRect.zero
    var targetOffsetOfItem : [CGFloat]  {
        (0..<self.collectionView!.numberOfItems(inSection: 0)).map{featuredSize * CGFloat($0)}
    }
   
    override var collectionViewContentSize: CGSize{
        .init(width: collectionView!.bounds.width, height: heightOfCollectionView + collectionView!.bounds.height )
    }
    override func prepare() {
        super.prepare()
        cache.removeAll()
          var y : CGFloat = 0
             
         
        guard let collectionView = self.collectionView else {return}
        let  toBeFeatured = featuredSize - size
       
        let contentOffset = max(collectionView.contentOffset.y, 0)
        let featuredArea = contentOffset + featuredSize
        
        for item in 0..<collectionView.numberOfItems(inSection: 0)  {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            frame = .init(x: 0, y: y, width: collectionView.bounds.width, height: size)
            
            if frame.minY <= featuredArea {
                 scaleRatio = max(( frame.minY - contentOffset ) / featuredSize , 0)
                 sizeToBeFeatured = min(toBeFeatured - (toBeFeatured * scaleRatio), toBeFeatured)
                frame = .init(x: 0, y: y, width: collectionView.bounds.width, height: sizeToBeFeatured + size)
                
            }
           
            attributes.frame = frame
            y = frame.maxY
            heightOfCollectionView = frame.maxY
            cache.append(attributes)
        }
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.cache.filter{$0.frame.intersects(rect)}
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        

           let closestAttributes =  self.cache
                .sorted { abs($0.frame.minY - proposedContentOffset.y) < abs($1.frame.minY - proposedContentOffset.y) }
                .first ?? UICollectionViewLayoutAttributes()
            
        return CGPoint(x:0 , y: (closestAttributes.frame.minY ))
        
    }
   
}

