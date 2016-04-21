//
//  IteneraryViewController.swift
//  Conference App
//
//  Created by Greg Gruse on 4/9/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class ItineraryViewController: UIViewController {

    
    @IBOutlet weak var ItinTable: UITableView!
    var dataMyIten: appendToMyIten = appendToMyIten()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ItinTable.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMyIten.events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        let event = dataMyIten.events[indexPath.row]
        
        cell.setName(event.name)
        cell.setStartTime(event.timeStart)
        cell.setStopTime(event.timeStop)
        cell.setDate(event.date)
        
        return cell

    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let destinationViewController: EventViewController
            = (storyboard?.instantiateViewControllerWithIdentifier("EventViewController") as? EventViewController)!
        
        let event = dataMyIten.events[indexPath.row]
        destinationViewController.event = event
        
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
