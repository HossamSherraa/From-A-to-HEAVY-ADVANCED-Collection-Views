//
//  CustomeLayout.swift
//  EveryCollectionView
//
//  Created by Hossam on 8/29/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewFlowLayout{
    
    override init() {
        super.init()
        self.scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var attributes = [UICollectionViewLayoutAttributes]()

    lazy var itemSizee : CGFloat = {
        return ((self.collectionView?.bounds.width)! / 2)
        
    }()
    
    
    
     var itemsheights  : [CGSize]!
    
    
    
    var previousYOffest : CGFloat = 0
    lazy var allOffsets : [CGFloat] = {
        var result = [CGFloat]()
        for (index , height ) in self.itemsheights.enumerated() {
            if index % 2 == 0 {
                
            }else {
                
            }
        }
        return result
    }()
    override func prepare() {
        attributes.removeAll()
        if attributes.isEmpty{
            var xOffset : CGFloat = 0
            var yOffset : CGFloat = 0
            
        for index in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: index, section: 0)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
          
            
            let fram : CGRect = CGRect.init(x: xOffset, y: yOffset, width: itemSizee, height: self.itemsheights[indexPath.row].height/2)
            
            
            let insetFram = fram.insetBy(dx: 10, dy: 10)
            attribute.frame = insetFram
           yOffset += self.itemsheights[indexPath.row].height/2
            if indexPath.row  == 15 {
                xOffset += itemSizee
                yOffset = 0
            }
            
            
        
            
            attributes.append(attribute)
            
          
           
            
      
            
            
            
            }
            
        }
       
        
    }
    override var collectionViewContentSize: CGSize{
        return CGSize.init(width: (self.collectionView?.bounds.width)!, height: self.itemsheights.reduce(0, { (R, S) -> CGFloat in
            let result = R + S.height/4
            
            return result
        }) )
    }
 
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes.filter{$0.frame.intersects(rect)}
        
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.attributes[indexPath.row]
    }
    
    
    
   
}
