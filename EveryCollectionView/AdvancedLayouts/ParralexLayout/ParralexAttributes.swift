//
//  ParralexAttributes.swift
//  EveryCollectionView
//
//  Created by Hossam on 10/25/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class ParalexAttributes : UICollectionViewLayoutAttributes {

    var parallax: CGAffineTransform = .identity
    var sizeOfItem = CGSize.zero
    
    override func copy(with zone: NSZone?) -> Any {
        guard let attributes = super.copy(with: zone) as? ParalexAttributes else { return UICollectionViewLayoutAttributes() }
        attributes.parallax = parallax
        attributes.sizeOfItem = sizeOfItem
       
        return attributes
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let attributes = object as? ParalexAttributes else { return false }
        guard NSValue(cgAffineTransform: attributes.parallax) == NSValue(cgAffineTransform: parallax) else { return false }
        guard NSValue(cgSize: sizeOfItem) == NSValue(cgSize : attributes.sizeOfItem) else {return false }
        return super.isEqual(object)
    }
}
