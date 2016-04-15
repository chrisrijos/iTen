//
//  AttendeesViewController.swift
//  Conference App
//
//  Created by tuong on 4/11/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class AttendeesViewController: UITableViewController {
    
    
    @IBOutlet weak var cellColor: AttendeesCell!
    var AttendeeControl:AttendeeController = AttendeeController()
    var detailViewController: DetailViewController? = nil
    var attendes = [Event]()
    var filtered = [Event]()
    let searchController = UISearchController(searchResultsController: nil)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Setup the Search Controller
        //searchController.searchResultsUpdater = self
       // searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "sponsors", "exhitbitors", "speakers"]
        tableView.tableHeaderView = searchController.searchBar
        
        
        // Do any additional setup after loading the view, typically from a nib.
           // Sets the table view's row height to automatic
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return AttendeeControl.getEventsCount()
        }
   
        return attendes.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AttendeesCell
            let event = AttendeeControl.getEventAt(indexPath.row)
            cell.setName(event.name)
            cell.setjobTitle(event.jobTitle)
            
        
            return cell
    }
 
}



