//
//  MyCell.swift
//  EveryCollectionView
//
//  Created by Hossam on 8/23/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class MyCell : UICollectionViewCell {
  
    
    @IBOutlet weak var image: UIImageView!
    
    weak var contentimage: UIImage?
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        
        
    }
    
    override func prepareForReuse() {
       super.prepareForReuse()
        
        self.image.image = nil
        
        
        
        
    }
    
   
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
     
        if let attributes = layoutAttributes as? CircularAttributes {
       
           
       
        }
        else if let attributes = layoutAttributes as? ParalexAttributes {
            
            self.image.transform = attributes.parallax
            self.image.frame.size = attributes.sizeOfItem
            
           
           
            super.apply(attributes)
        }
        
        self.layer.anchorPoint = .init(x: 0, y: 1)
                   self.center = .init(x: self.center.x + ((layer.anchorPoint.x - 0.5) * layer.frame.width), y: self.center.y + ((layer.anchorPoint.y - 0.5) * layer.frame.height))
        
        
    }
    
   
    
}
