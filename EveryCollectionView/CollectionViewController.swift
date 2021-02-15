//
//  CollectionViewController.swift
//  EveryCollectionView
//
//  Created by Hossam on 8/23/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
import Foundation

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    
   
    
    
    @IBAction func firstBTN(_ sender: Any) {
        
        
        UIView.animate(withDuration: 1) {
            let layout = MosaicLayout()
                   layout.data = self.data.map{$0.size.height}
                   self.collectionView.setCollectionViewLayout(layout, animated: true)
        }
        
        
    }
    
   
    @IBAction func secondBTN(_ sender: UIButton) {
        if !collectionView.cellForItem(at: IndexPath(item: 10, section: 0))!.isSelected {
            collectionView.selectItem(at: IndexPath(item: 10, section: 0), animated: true, scrollPosition: .centeredVertically)
           
        }else {
         collectionView.deselectItem(at: IndexPath(item: 10, section: 0), animated: true)
            
        }
    
    }
   
    
    
    @IBAction func thirdBTN(_ sender: Any) {
      
       
        
        
    }
    @IBAction func forthBTN(_ sender: Any) {
    }
    
    
    var data : [UIImage]  = {
     
       
             var result = [UIImage]()
            var temp = [UIImage]()
            for num in 0...29 {
                
                guard let image = UIImage(named: "\(num).jpeg") else {continue}
                
                result.append(image)
                
                
            }
            
            return result
       
    }()
    
    
  

   lazy var delegate = layoutFlowDelegate(collectionView: self.collectionView!, data: self.data)
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
//        var centerRectangel : CGRect {return CGRect.init(x: 0, y: collectionView!.contentOffset.y + UIScreen.main.bounds.height/3.5, width: collectionView!.bounds.width, height: 1)}
//         let layer = CALayer()
//        layer.frame = centerRectangel
//
//
//        layer.backgroundColor = UIColor.red.cgColor
//        self.view.layer.addSublayer(layer)
        
       
       let layout = StackCardsLayout()
//        layout.data = self.data.map{$0.size.height}
        
        
       
        
        self.collectionView.collectionViewLayout = layout
        
        
       
       
 }

    var flag = false
    
   
    lazy var x = self.collectionView.startInteractiveTransition(to: AnotherLayoutFlowClass()) { (ani, com) in
        print("Completed")
    }
    
    
    @objc func myGesture(g: UIPanGestureRecognizer){
        
        

        switch g.state {
       
        case .changed: if(x.transitionProgress == CGFloat(1)) { self.collectionView.finishInteractiveTransition()} else {x.transitionProgress += 0.01}
        case.ended: self.collectionView.finishInteractiveTransition()
        default: break
            
        }
        }
    
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCell
        cell.image.image = data[indexPath.row]
       
       cell.backgroundColor  = #colorLiteral(red: 0.462745098, green: 0, blue: 1, alpha: 1)
    
       
        
   
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = data.remove(at: sourceIndexPath.row)
        data.insert(item, at: destinationIndexPath.row)
        
    }
   
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "H", for: indexPath) as! HeaderView
    }
    
    

}


    


