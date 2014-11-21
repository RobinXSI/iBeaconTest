//
//  ViewController.swift
//  iBeaconTest
//
//  Created by Dario Andreoli on 09.11.14.
//  Copyright (c) 2014 Dario Andreoli. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, answerQuestionDelegate {
    
    @IBOutlet var tableView: UITableView?
    var beacons: [CLBeacon]?
    let kCellIdentifier: String = "QuestionCell"
    var questions: [Question] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var answers1 = ["Response1", "Response2", "Response3", "Response4"]
        var question1 = Question(title:"Bärenhöhle von Ricardo", text:"Text for Question 1", answers:answers1, solution:2, beaconId:43114)
        var answers2 = ["Response2_1", "Response2_2", "Response2_3", "Response2_4"]
        var question2 = Question(title:"Vogelnest vom Orangutan", text:"Text for Question 2", answers:answers2, solution:3, beaconId:43115)
        
        self.questions = [question1, question2]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getBeacon(id: NSNumber) -> CLBeacon? {
        if (beacons != nil) {
            for beacon:CLBeacon in beacons! {
                if (beacon.minor == id) {
                    return beacon
                }
            }
            return nil
        }
        return nil
    }
    
    func getQuestion(id: NSNumber) -> Question? {
        for question:Question in questions {
            if(question.beaconId == id) {
                return question
            }
        }
        return nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "segueDetail") {
            var svc = segue.destinationViewController as DetailViewController;
            svc.delegate = self
            let row = self.tableView!.indexPathForSelectedRow()!.row
            svc.question = questions[row]
        }
    }
    
    func answerQuestion(q: Int, isRight: Bool) {
        var question = getQuestion(q)!
        question.isAnswered = true
        question.isRight = isRight
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return questions.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            
            var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
            
            let question:Question = questions[indexPath.row]
            let beacon:CLBeacon? = getBeacon(question.beaconId)
            
            cell.textLabel.text = question.title
            
            if(beacon == nil || (beacon!.proximity != CLProximity.Immediate && beacon!.proximity != CLProximity.Near)) {
                cell.userInteractionEnabled = false
            } else {
                cell.userInteractionEnabled = true
            }
            
            if (question.isAnswered && question.isRight) {
                cell.imageView.image = UIImage(named: "Tick.png")
            } else if (question.isAnswered) {
                cell.imageView.image = UIImage(named: "Error.png")
            } else {
                cell.imageView.image = nil
            }
            
            
            return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}


