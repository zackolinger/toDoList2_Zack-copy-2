//
//  UIViewAnimationExtensions.swift
//  toDoList2
//
//  Created by Zack Olinger on 4/11/18.
//  Copyright © 2018 Zack Olinger. All rights reserved.
//

import UIKit

extension UIView {
    
    /* Animations for cell and all ui*/
    
    //This one is not used in the code
    class func vibrationFromLeftToRigh(cell: TaskCollectionViewCell) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.speed = 0.8
        animation.fromValue = NSValue(cgPoint: CGPoint(x: cell.center.x - 3, y: cell.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: cell.center.x + 3, y: cell.center.y))
        cell.layer.add(animation, forKey: "position")
    }
    
    class func cellFromSmallToBig(cell: TaskCollectionViewCell) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        })
    }
    
    class func throwCellFromRightToLeftOnceDeleted(cell: TaskCollectionViewCell, completionHandler:@escaping () -> ()) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cell.layer.transform = CATransform3DMakeTranslation(-750, 10, 10)
        }) { (true) in
            completionHandler()
        }
    }
    
}
