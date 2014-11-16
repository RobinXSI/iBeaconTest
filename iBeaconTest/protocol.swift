//
//  protocol.swift
//  iBeaconTest
//
//  Created by Dario Andreoli on 16.11.14.
//  Copyright (c) 2014 Dario Andreoli. All rights reserved.
//

import Foundation

protocol answerQuestionDelegate {
    func answerQuestion(question: Int, isRight: Bool)
}