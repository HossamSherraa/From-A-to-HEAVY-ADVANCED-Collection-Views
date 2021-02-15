//
//  LayoutFlowClass.swift
//  EveryCollectionView
//
//  Created by Hossam on 8/23/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class LayoutFlowClass : UICollectionViewFlowLayout{
    let minItemWidth : CGFloat = 300
    override func prepare() {
        guard let collectionView = self.collectionView else {return}
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumberOfColoumns = (availableWidth / minItemWidth).rounded(.down)
        print(maxNumberOfColoumns)
        let cellWidth = availableWidth / maxNumberOfColoumns
        
        self.itemSize = .init(width: cellWidth, height: 100)
        self.scrollDirection = .vertical
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.sectionInsetReference = .fromSafeArea
        /*self.minimumLineSpacing = 130 // in Vertical gride we working with row , and lineSpace represent the space between first row and second row .....
         self.minimumInteritemSpacing = 130 // in Vertical gride we working with row , and InterItemSpace represent the space between items in the same row
         */
       
    }
}

class AnotherLayoutFlowClass : UICollectionViewFlowLayout{
    override init() {
        super.init()
        self.scrollDirection = .vertical
        self.itemSize = .init(width: 100, height: 10)}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SecondAnotherLayoutFlowClass : UICollectionViewFlowLayout{
    override init() {
        super.init()
        self.scrollDirection = .vertical
        self.itemSize = .init(width: 10, height: 10)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


