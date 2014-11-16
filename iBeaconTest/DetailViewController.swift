//
//  DetailViewController.swift
//  iBeaconTest
//
//  Created by Dario Andreoli on 16.11.14.
//  Copyright (c) 2014 Dario Andreoli. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class DetailViewController: UIViewController {
    
    var question: Question!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOneButton: UIButton!
    @IBOutlet weak var answerTwoButton: UIButton!
    @IBOutlet weak var answerThreeButton: UIButton!
    @IBOutlet weak var answerFourButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    @IBAction func answerOneButtonPressed(sender: UIButton) {
        checkAnswer(1, answerNumber: answerOneButton)
    }
    
    @IBAction func answerTwoButtonPressed(sender: UIButton) {
        checkAnswer(2, answerNumber: answerTwoButton)
    }
    
    @IBAction func answerThreeButtonPressed(sender: UIButton) {
        checkAnswer(3, answerNumber: answerThreeButton)
    }
    
    @IBAction func answerFourButtonPressed(sender: UIButton) {
        checkAnswer(4, answerNumber: answerFourButton)
    }
    
    @IBAction func okButtonPressed(sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialState() {
        okButton.hidden = true
        questionLabel.text = question.text
        
        answerOneButton.setTitle(question.answers[0], forState: UIControlState.Normal)
        answerTwoButton.setTitle(question.answers[1], forState: UIControlState.Normal)
        answerThreeButton.setTitle(question.answers[2], forState: UIControlState.Normal)
        answerFourButton.setTitle(question.answers[3], forState: UIControlState.Normal)
    }
    
    
    func checkAnswer(answerIndex: Int, answerNumber: UIButton) {
        answerOneButton.enabled = false
        answerTwoButton.enabled = false
        answerThreeButton.enabled = false
        answerFourButton.enabled = false
        
        if (answerOneButton == question.solution) {
            answerNumber.backgroundColor = UIColor.greenColor()
        } else {
            answerNumber.backgroundColor = UIColor.redColor()
            switch question.solution {
            case 1:
                answerOneButton.backgroundColor = UIColor.greenColor()
            case 2:
                answerTwoButton.backgroundColor = UIColor.greenColor()
            case 3:
                answerThreeButton.backgroundColor = UIColor.greenColor()
            case 4:
                answerFourButton.backgroundColor = UIColor.greenColor()
            default:
                answerNumber.setTitle("no correct answer", forState: UIControlState.Normal)
            }
        }
        
        okButton.hidden = false
    }
    
}