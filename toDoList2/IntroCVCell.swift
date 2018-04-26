//
//  IntroCVCell.swift
//  toDoList2
//
//  Created by Zack Olinger on 4/11/18.
//  Copyright © 2018 Zack Olinger. All rights reserved.
//

import UIKit

class IntroCVCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        taskColorTag.roundCorners(corners: [.topLeft, .bottomLeft], radius: 7)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        
        addSubview(backgroundTaskView)
        addSubview(taskColorTag)
        addSubview(taskLabel)
        
        _ = backgroundTaskView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        _ = taskColorTag.anchor(backgroundTaskView.topAnchor, left: backgroundTaskView.leftAnchor, bottom: backgroundTaskView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 10, heightConstant: 0)
        
        _ = taskLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 20 , leftConstant: 50, bottomConstant: 0, rightConstant: 55, widthConstant: 0, heightConstant: 50)
    }

    
    let backgroundTaskView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 7
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowOpacity = 1
        
        return view
    }()
    let taskColorTag: UIView = {
        let view = UIView()
        let color = COLORS[0]
        view.backgroundColor = UIColor.hexColor(hex: color)
        view.layer.masksToBounds = true
        
        return view
    }()
    let taskLabel:UILabel = {
        let label = UILabel()
        label.text = "Example to do"
        label.numberOfLines = 0
        
        return label
    }()

}
