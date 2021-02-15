//
//  LayoutFlow.swift
//  EveryCollectionView
//
//  Created by Hossam on 8/23/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class layoutFlowDelegate :NSObject ,  UICollectionViewDelegateFlowLayout{
    let data : [UIImage]
    let collectionView : UICollectionView
    init(collectionView : UICollectionView , data : [UIImage]) {
        self.collectionView = collectionView
        self.data = data
       super.init()
        collectionView.delegate = nil
        collectionView.delegate = self
      
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 400, height : 400.0)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

