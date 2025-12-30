//
//  TaskModel.swift
//  DeepFocus
//
//  Created by Alejandro Alonso on 30/12/25.
//

import Foundation
import SwiftData

@Model
class TaskModel{
    var title:String
    var createdAt:Date
    var isCompleted:Bool=false
    
    init(title: String) {
        self.title = title
        self.createdAt = .now
        
    }
}


