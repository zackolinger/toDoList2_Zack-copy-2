//
//  UILabelExtension.swift
//  toDoList2
//
//  Created by Zack Olinger on 4/11/18.
//  Copyright © 2018 Zack Olinger. All rights reserved.
//

import UIKit

extension UILabel {
    
    func calculateSizeOfString(text: String) -> CGRect {
        
        return NSString(string: text).boundingRect(with: CGSize(width: frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
    }
}
