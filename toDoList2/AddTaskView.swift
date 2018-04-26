//
//  AddTaskView.swift
//  toDoList2
//
//  Created by Zack Olinger on 4/11/18.
//  Copyright © 2018 Zack Olinger. All rights reserved.
//

import UIKit

class AddTaskView: UIView {
    
//===========================================================================
//===========================================================================
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//===========================================================================
//===========================================================================
    func setupView() {
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
        
        addSubview(closeButton)
        addSubview(taskTextField)
        addSubview(descriptionTextView)
        addSubview(addTaskButton)
        
        _ = closeButton.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 30)
        
        _ = taskTextField.anchor(closeButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 50)
        
        _ = descriptionTextView.anchor(taskTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 140)
        
        _ = addTaskButton.anchor(descriptionTextView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 60, heightConstant: 60)
    }
//===========================================================================
//===========================================================================
    let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("CLOSE", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(ViewController.hideAddTaskView), for: .touchUpInside)
        
        return btn
    }()
    lazy var taskTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Add Your To do Here…"
        tf.delegate = self
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.cornerRadius = 3
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = UITextFieldViewMode.always
        
        return tf
    }()
    lazy var descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Add a Description Here…"
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.black.cgColor
        tv.layer.cornerRadius = 3
        
        return tv
    }()
    let addTaskButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        btn.titleEdgeInsets = UIEdgeInsetsMake(7, 11, 10, 10)
        let color = COLORS[0]
        btn.backgroundColor = UIColor.hexColor(hex: color)
        btn.clipsToBounds = true
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        btn.layer.cornerRadius = btn.bounds.size.width / 2
        btn.addTarget(self, action: #selector(ViewController.addTask), for: .touchUpInside)
        
        return btn
    }()
}

extension AddTaskView: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let VC = ViewController()
        VC.addTaskToTASKS_ARRAY()
        self.endEditing(true)
        return true
    }
}







