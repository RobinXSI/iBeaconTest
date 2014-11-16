//
//  ViewController.swift
//  iBeaconTest
//
//  Created by Dario Andreoli on 09.11.14.
//  Copyright (c) 2014 Dario Andreoli. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView?
    var beacons: [CLBeacon]?
    let kCellIdentifier: String = "QuestionCell"
    var questions: [Question] = []
    var question:Question?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            svc.question = question
        }
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            if(beacons != nil) {
                return beacons!.count
            } else {
                return 0
            }
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var answers1 = ["Response1", "Response2", "Response3", "Response4"]
            var question1 = Question(title:"Bärenhöhle von Ricardo", text:"Text for Question 1", answers:answers1, solution:2, beaconId:43114)
            var answers2 = ["Response2_1", "Response2_2", "Response2_3", "Response2_4"]
            var question2 = Question(title:"Vogelnest vom Orangutan", text:"Text for Question 2", answers:answers2, solution:3, beaconId:43115)
            
            questions = [question1, question2]
            
            var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as? UITableViewCell
            
            if(cell == nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.Subtitle,
                    reuseIdentifier: "MyIdentifier")
                cell!.selectionStyle = UITableViewCellSelectionStyle.None
            }
            
            let beacon:CLBeacon = beacons![indexPath.row]
            
            question = getQuestion(beacon.minor)
            
            cell!.textLabel.text = question?.title
            
            if(beacon.proximity != CLProximity.Immediate && beacon.proximity != CLProximity.Near) {
                cell?.userInteractionEnabled = false
            } else {
                cell?.userInteractionEnabled = true
            }
            
            return cell!
    }
}

extension ViewController: UITableViewDelegate {
    
}


