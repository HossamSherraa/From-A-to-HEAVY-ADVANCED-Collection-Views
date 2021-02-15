//
//  CircularAttributes.swift
//  EveryCollectionView
//
//  Created by Hossam on 10/13/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class CircularAttributes : UICollectionViewLayoutAttributes {
    var angel : CGFloat = 0
    
    var anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
    
    var scale : CGFloat = 1
    override func copy(with zone: NSZone? = nil) -> Any {
        
        guard let attributes = super.copy(with: zone) as? CircularAttributes else {return UICollectionViewLayoutAttributes()}
        attributes.anchorPoint = self.anchorPoint
        attributes.angel = self.angel
        attributes.scale = self.scale
        attributes.zIndex = self.zIndex
        attributes.transform = self.transform
        return attributes
    }
    
}
