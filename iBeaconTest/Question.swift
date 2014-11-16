//
//  Question.swift
//  iBeaconTest
//
//  Created by Dario Andreoli on 14.11.14.
//  Copyright (c) 2014 Dario Andreoli. All rights reserved.
//

import Foundation

class Question : Equatable {
    let title: String
    let text: String
    let answers: [String]
    let solution: Int
    let beaconId: Int
    var isAnswered: Bool = false
    var isRight: Bool = false
    
    init(title: String, text:String, answers:[String], solution:Int, beaconId:Int) {
        self.title = title
        self.text = text
        self.answers = answers
        self.solution = solution
        self.beaconId = beaconId
    }
    
}

func ==(lhs: Question, rhs: Question) -> Bool {
    return lhs.beaconId == rhs.beaconId
}