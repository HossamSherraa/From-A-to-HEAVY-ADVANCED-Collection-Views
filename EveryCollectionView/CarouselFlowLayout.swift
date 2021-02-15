//
//  CarouselFlowLayout.swift
//  EveryCollectionView
//
//  Created by Hossam on 9/8/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class CarouselFlowLayout : UICollectionViewFlowLayout {
    let standardAlpha : CGFloat = 0.5
    let standardScale : CGFloat = 0.5
  
    override func prepare() {
        super.prepare()
         itemSize = .init(width: 200, height: 200)
        self.headerReferenceSize = .init(width: self.collectionView!.bounds.width, height: 300)
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let attributes = super.layoutAttributesForElements(in: rect)
        var result = [UICollectionViewLayoutAttributes]()
        for attribute in attributes! {
            if attribute.representedElementKind != UICollectionView.elementKindSectionHeader{
        self.changeAttributes(attributes: attribute)
            result.append(attribute)
            }
            else {
             let yOffset = abs(self.collectionView!.contentOffset.y)
                
               
                let negatibeYoffset = self.collectionView!.contentOffset.y
                let height = max(self.headerReferenceSize.height, self.headerReferenceSize.height + yOffset) * 0.8
                print(yOffset , 0-yOffset)
                let frame = CGRect(x: attribute.frame.minX, y:0 - yOffset, width: attribute.frame.width, height: height)
                attribute.frame = frame
                result.append(attribute)
            }
        }
        
        return result
    }
    
    func changeAttributes(attributes : UICollectionViewLayoutAttributes){
        let collectionCenter = collectionView!.frame.size.height/2
        let offset = collectionView!.contentOffset.y
        let normalizedCenter = attributes.center.y - offset
        
        let maxDistance = CGFloat(300.0)
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance)/maxDistance
        
        let alpha = ratio * (self.standardAlpha) + self.standardAlpha
        let scale = ratio * ( self.standardScale) + self.standardScale
       
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        
        
    }
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        
        let center = (self.collectionView!.bounds.height / 2 ) + proposedContentOffset.y
        let attributes = self.layoutAttributesForElements(in: self.collectionView!.bounds)!.sorted{abs($0.center.y -  center)<abs($1.center.y - center)}.first!.center
       
        
        
        return .init(x: proposedContentOffset.x, y: (attributes.y - (self.collectionView!.bounds.height / 2 )))
        
    }
    
}
