//
//  Carousel.swift
//  EveryCollectionView
//
//  Created by Hossam on 9/5/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class CarouselLayout : UICollectionViewLayout{
    var cache = [UICollectionViewLayoutAttributes]()
    var data : [CGFloat]!
    var featuredHeight : CGFloat  {return 280}
    var standardHeight : CGFloat  {return 100}
    
    
    let dragOffset: CGFloat =  180
    
    var width : CGFloat {
        get {return self.collectionView!.bounds.width} }
    var height : CGFloat {
        return self.collectionView!.bounds.height
    }
    override var collectionViewContentSize: CGSize{
        return .init(width: width, height: data.reduce(0, { (result, value) -> CGFloat in
            return result + standardHeight
        }) - standardHeight + featuredHeight  + height)
    }
    
   
    override func prepare() {
        cache.removeAll()
        var centerRectangel : CGRect {return CGRect.init(x: 0, y: collectionView!.contentOffset.y + UIScreen.main.bounds.height/3.5 , width: width, height: 1)}
        guard let collectionView = self.collectionView else {return}
        var y  : CGFloat = 440
        var frame = CGRect.zero
        var currentItem  = 0
        for item in 0..<data.count {
            let intersectionFram = CGRect(x: 0, y: frame.maxY , width: width, height: frame.height)
            let currentItemHeightOffset = (intersectionFram.maxY - centerRectangel.maxY) / standardHeight
            let nextItemHeightOffset =  1 - max(0, (frame.maxY - centerRectangel.maxY) / featuredHeight)
            
            var itemHeight = standardHeight
            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: item, section: 0))
            
            if intersectionFram.intersects(centerRectangel) {
                currentItem = item
                 itemHeight = standardHeight + ((featuredHeight - standardHeight)*currentItemHeightOffset)
                attributes.zIndex = item
                 attributes.alpha = max(0.7, currentItemHeightOffset)
                print(currentItemHeightOffset)
            }
            else if  item == currentItem + 1 {
                if nextItemHeightOffset < 1 {
                     itemHeight = standardHeight + ((featuredHeight - standardHeight)*nextItemHeightOffset)
                     attributes.alpha = max(nextItemHeightOffset, 0.7)
                   
                }
                
                
            }
                
            else if item == currentItem - 1 {
                
                attributes.alpha =  max(0.7, nextItemHeightOffset)}
            else {
                attributes.alpha = 0.7
            }
            frame = .init(x: collectionView.bounds.midX - itemHeight/2, y: y, width: itemHeight, height: itemHeight)
            attributes.frame = frame
            cache.append(attributes)
            y = frame.maxY
        }
       
        
        
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = self.collectionView else {return nil}
        return cache.filter{_ in collectionView.bounds.intersects(rect)}
        
    }
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}


