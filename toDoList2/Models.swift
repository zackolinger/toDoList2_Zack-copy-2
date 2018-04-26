//
//  Models.swift
//  toDoList2
//
//  Created by Zack Olinger on 4/9/18.
//  Copyright © 2018 Zack Olinger. All rights reserved.
//

import Foundation

struct Task {
    
    let task: String
    let details: String
    let createdAt: Date
    let color: String
    var isDone: Bool
    var notificationTime: Date?
}



