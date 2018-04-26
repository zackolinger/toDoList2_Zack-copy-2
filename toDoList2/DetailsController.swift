//
//  DetailsController.swift
//  toDoList2
//
//  Created by Zack Olinger on 4/11/18.
//  Copyright © 2018 Zack Olinger. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    
    var currentTask: Task? {
        didSet{
            if let tagColor = currentTask?.color {
                taskView.taskColorTag.backgroundColor = UIColor.hexColor(hex: tagColor)
                taskView.emptyAchievedCircle.layer.borderColor = UIColor.hexColor(hex: tagColor).cgColor
                taskView.checkedAchievedCircle.backgroundColor = UIColor.hexColor(hex: tagColor)
                
                detailView.taskColorTag.backgroundColor = UIColor.hexColor(hex: tagColor)
                detailView.emptyAchievedCircle.layer.borderColor = UIColor.hexColor(hex: tagColor).cgColor
                detailView.checkedAchievedCircle.backgroundColor = UIColor.hexColor(hex: tagColor)
                
                
            }
            if let task = currentTask?.task {
                taskView.taskLabel.text = task
            }
            if let detail = currentTask?.details {
                detailView.taskLabel.text = detail
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        view.addSubview(taskView)
        view.addSubview(detailView)
        
        _ = backButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 45, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 30)
        
        _ = taskView.anchor(backButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 100)
        
        _ = detailView.anchor(taskView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 200)
    }
    let backButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Back", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        if UIDevice.current.userInterfaceIdiom == .pad {
            btn.isHidden = true
        }
        return btn
    }()
    let taskView: TaskCollectionViewCell = {
       let view = TaskCollectionViewCell()
        view.taskLabel.text = "Begin adding things To Do"
        view.checkedAchievedCircle.isHidden = true
        view.emptyAchievedCircle.isHidden = true
        return view
    }()
    let detailView: TaskCollectionViewCell = {
        let view = TaskCollectionViewCell()
        view.taskLabel.text = "To Do Details"
        view.taskLabel.textAlignment = .center
        view.checkedAchievedCircle.isHidden = true
        view.emptyAchievedCircle.isHidden = true
        return view
    }()
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    
}





