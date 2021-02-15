//
//  AAALayout.swift
//  EveryCollectionView
//
//  Created by Hossam on 9/3/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit

struct UltravisualLayoutConstants {
    struct Cell {
        // The height of the non-featured cell
        static let standardHeight: CGFloat = 100
        // The height of the first visible cell
        static let featuredHeight: CGFloat = 280
    }
}

// MARK: Properties and Variables

class UltravisualLayout: UICollectionViewLayout {
    
    lazy var contentSize = CGSize(width: self.width, height: 0)
    
    let dragOffset: CGFloat = 180.0
    
    var cache: [UICollectionViewLayoutAttributes] = []
    
    var featuredItem : Int{
        return min(max(0, Int((self.collectionView?.contentOffset.y)! / dragOffset)), numberOfItems - 1)
    }
    
    var nextItemPercentageOffset : CGFloat {
        
        return (collectionView!.contentOffset.y / dragOffset) - CGFloat(featuredItem)
    }
    var width: CGFloat {
        return collectionView!.bounds.width
    }
    
    
    var height: CGFloat {
        return collectionView!.bounds.height
    }
    
    var numberOfItems: Int {
        return collectionView!.numberOfItems(inSection: 0)
    }
}


extension UltravisualLayout {
    
    
    
    
        override var collectionViewContentSize : CGSize {
            let contentHeight = (CGFloat(numberOfItems) * dragOffset) + (height - dragOffset)
            return CGSize(width: width, height: contentHeight)
        }
    
    
    override func prepare() {
        self.cache.removeAll()
        guard let collectionView = self.collectionView else {return}
        var y : CGFloat = 0
        let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
        let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
        var frame = CGRect.zero
        for item in 0..<numberOfItems{
            var height = standardHeight
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.zIndex = item
            if item == featuredItem {
                if featuredItem != numberOfItems-1{
                    
                    height = featuredHeight
                    let yOffset = 180 * nextItemPercentageOffset
                    y = max(0, collectionView.contentOffset.y  - yOffset)
                    
                }
                else {
                    height = featuredHeight
                    y = collectionView.contentOffset.y
                   
                }
            }
            
            else if featuredItem + 1  == item {
                print("Here")
                let yOffset = standardHeight * nextItemPercentageOffset
                y = y - yOffset
                print(y)
                
                let heightOffset = ( (featuredHeight - standardHeight) * nextItemPercentageOffset )
                
                height = height + heightOffset
                
                
            }

            
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            y = frame.maxY
           
            self.cache.append(attributes)
            
            
        }
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    // Return true so that the layout is continuously invalidated as the user scrolls
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let item = round(proposedContentOffset.y / dragOffset)
        return .init(x: 0, y: item * dragOffset )
    }
   
}
