//
//  AppDelegate.swift
//  iBeaconTest
//
//  Created by Dario Andreoli on 09.11.14.
//  Copyright (c) 2014 Dario Andreoli. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate{
    
    var window: UIWindow?
    var locationManager: CLLocationManager?
    var lastProximity: CLProximity?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Override point for customization after application launch.
        
        //let uuidString = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
        let uuidString = "f7826da6-4fa2-4e98-8024-bc5b71e0893e"
        let beaconIdentifier = "iBeaconMoules.us"
        //let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString)
        let beaconUUID = NSUUID(UUIDString: uuidString)!
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, identifier: beaconIdentifier)
        
        locationManager = CLLocationManager()
        if(locationManager!.respondsToSelector("requestAlwaysAuthorization")){
            locationManager!.requestAlwaysAuthorization()
        }
        locationManager!.delegate = self
        locationManager!.pausesLocationUpdatesAutomatically = false
        locationManager!.startMonitoringForRegion(beaconRegion)
        locationManager!.startRangingBeaconsInRegion(beaconRegion)
        locationManager!.startUpdatingLocation()
        
        if(application.respondsToSelector("registerUserNotificationSettings:")) {
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound, categories: nil))
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

extension AppDelegate: CLLocationManagerDelegate {
    func sendLocalNotificationWithMessage(message: String!) {
        let notification:UILocalNotification = UILocalNotification()
        notification.alertBody = message
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        let viewController:ViewController = window!.rootViewController as ViewController
        viewController.beacons = beacons as [CLBeacon]?
        viewController.tableView!.reloadData()
        
        if (viewController.questions.isEmpty) {
            var answers1 = ["Response1", "Response2", "Response3", "Response4"]
            var question1 = Question(title:"Bärenhöhle von Ricardo", text:"Text for Question 1", answers:answers1, solution:2, beaconId:43114)
            var answers2 = ["Response2_1", "Response2_2", "Response2_3", "Response2_4"]
            var question2 = Question(title:"Vogelnest vom Orangutan", text:"Text for Question 2", answers:answers2, solution:3, beaconId:43115)
            
            let questions = [question1, question2]
            viewController.questions = questions
        }
        
        
        
        println("didRangeBeacons")
        var message : String = ""
        
        if(beacons.count > 0){
            let nearestBeacon:CLBeacon = beacons[0] as CLBeacon
            
            if(nearestBeacon.proximity == lastProximity || nearestBeacon.proximity == CLProximity.Unknown) {
                return
            }
            lastProximity = nearestBeacon.proximity
            
            switch nearestBeacon.proximity {
            case CLProximity.Far:
                message = "You are far away from the beacon"
            case CLProximity.Near:
                message = "You are near the beacon"
            case CLProximity.Immediate:
                message = "You are in the immediate proximity of the beacon "
            case CLProximity.Unknown:
                return
            }
        } else {
            message = "No beacons are nearby"
        }
        
        println(message)
        sendLocalNotificationWithMessage(message)
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        manager.startRangingBeaconsInRegion(region as CLBeaconRegion)
        manager.startUpdatingLocation()
        
        println("You entered the region")
        sendLocalNotificationWithMessage("You entered the region")
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        manager.stopRangingBeaconsInRegion(region as CLBeaconRegion)
        manager.stopUpdatingLocation()
        
        println("You exited the region")
        sendLocalNotificationWithMessage("You exited the region")
        
    }
    
    
}
