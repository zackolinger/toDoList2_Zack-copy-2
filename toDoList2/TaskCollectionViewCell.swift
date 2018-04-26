//
//  TaskCollectionViewCell.swift
//  toDoList2
//
//  Created by Zack Olinger on 4/10/18.
//  Copyright © 2018 Zack Olinger. All rights reserved.
//

import UIKit
import AVFoundation

class TaskCollectionViewCell: UICollectionViewCell {
    
    var currentTask: Task? {
        didSet{
            if let tagColor = currentTask?.color {
                taskColorTag.backgroundColor = UIColor.hexColor(hex: tagColor)
                emptyAchievedCircle.layer.borderColor = UIColor.hexColor(hex: tagColor).cgColor
                checkedAchievedCircle.backgroundColor = UIColor.hexColor(hex: tagColor)
            }
            if let task = currentTask?.task {
                taskLabel.text = task
            }
            setupViews(isAchieved: (currentTask?.isDone)!)
        }
    }
    var indexNumber: Int?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews(isAchieved: false)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        taskColorTag.roundCorners(corners: [.topLeft, .bottomLeft], radius: 7)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func setupViews(isAchieved:Bool) {
        
        addSubview(backgroundTaskView)
        addSubview(taskColorTag)
        addSubview(taskLabel)
        
        _ = backgroundTaskView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        _ = taskColorTag.anchor(backgroundTaskView.topAnchor, left: backgroundTaskView.leftAnchor, bottom: backgroundTaskView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 10, heightConstant: 0)
        
        _ = taskLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 12 , leftConstant: 30, bottomConstant: 0, rightConstant: 55, widthConstant: 0, heightConstant: 50)
        
        if isAchieved {
            addSubview(checkedAchievedCircle)
            
            _ = checkedAchievedCircle.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 35, heightConstant: 35)
        } else {
            addSubview(emptyAchievedCircle)
            
            _ = emptyAchievedCircle.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 35, heightConstant: 35)
        }
    }
//============================================================================================
//============================================================================================
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
        label.text = "Test"
        label.numberOfLines = 0
        
        return label
    }()
    lazy var emptyAchievedCircle: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        let color = COLORS[0]
        btn.layer.borderColor = UIColor.hexColor(hex: color).cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = btn.bounds.size.width / 2
        btn.addTarget(self, action: #selector(emptyAchievedCircleButton), for: .touchUpInside)
        btn.tag = 2
        
        return btn
    }()
    lazy var checkedAchievedCircle: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btn.setImage(#imageLiteral(resourceName: "rightSign"), for: .normal)
        let color = COLORS[0]
        btn.backgroundColor = UIColor.hexColor(hex: color)
        btn.layer.cornerRadius = btn.bounds.size.width / 2
        btn.addTarget(self, action: #selector(emptyAchievedCircleButton), for: .touchUpInside)
        btn.tag = 1
        
        return btn
    }()
    @objc func emptyAchievedCircleButton() {
        let currentTask = ViewController.TASKS_ARRAY[indexNumber!].isDone
        
        if currentTask {
            ViewController.TASKS_ARRAY[indexNumber!].isDone = false
            setupViews(isAchieved: false)
//
//        } else {
//            ViewController.TASKS_ARRAY[indexNumber!].isDone = true
//            setupViews(isAchieved: true)
//            playSound(soundName: ACHIEVING_TASK_SOUND)
//        }
//        AppDelegate.saveTasks(tasks: ViewController.TASKS_ARRAY)
//    }
//////============================================================================================
//////============================================================================================
////                            /* Play Sound Functions */
////                        /*===================================*/
////    var player:AVAudioPlayer = AVAudioPlayer()
////
////    func playSound(soundName: String) {
////        stopSound()
////        let path = Bundle.main.path(forResource: soundName, ofType: "mp3")
////        let soundUrl = URL(fileURLWithPath: path!)
////        do {
////            try player = AVAudioPlayer(contentsOf: soundUrl)
////            player.prepareToPlay()
////            player.play()
////        } catch {   /*It didn't work playing sound*/  }
////    }
////    func stopSound() {
////        let path = Bundle.main.path(forResource: UNACHIEVING_TASK_SOUND, ofType: "mp3")
////        let soundUrl = URL(fileURLWithPath: path!)
////        do {
////            try player = AVAudioPlayer(contentsOf: soundUrl)
////            player.stop()
////        } catch {   /*handle errors */  }
////    }
//////============================================================================================
//////============================================================================================
////}
}
}
}
