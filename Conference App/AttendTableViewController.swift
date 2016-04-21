//
//  AttendeesViewController.swift
//  Conference App
//
//  Created by tuong on 4/11/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class AttendeesViewController: UITableViewController, UISearchResultsUpdating {
    
    var AttendeeControl:AttendeeController = AttendeeController()
    var detailViewController: DetailViewController? = nil
    var attendes = [Event]()
    var filtered = [Event]()
    var Handles = [String]()
    var Filtered = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    //let searchController = UISearchController(searchResultsController: nil)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ATT = AttendeeControl.dataLoader.getAttendee()
        let attendes = ATT.event
        for i in 0...attendes.count-1{
            Handles.append(attendes[i].name)
        }
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        // Setup the Search Controller
        //searchController.searchResultsUpdater = self
        //searchController.searchBar.delegate = self
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
        /*if(section == 0){
            return AttendeeControl.getEventsCount()
        }
   
        return attendes.count*/
        
        if (searchController.active){
            /*if (searchController.searchBar.text?.isEmpty) != nil{
             return Handles.count
             }*/
            //if searchController.searchBar.text? == nil{
            //  return Handles.count
            //}
            
            if let q = searchController.searchBar.text{
                if q.characters.count <= 0{
                    return Handles.count
                }
                return Filtered.count
            }
            
        }
        return Handles.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
            
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AttendeesCell
        let event = AttendeeControl.getEventAt(indexPath.row)
        
        //This is part of my search bar but it not working when use it give out of bound array error
        /*
            let event : Event
            if searchController.active && searchController.searchBar.text != "" {
                candy = filteredCandies[indexPath.row]
            } else {
                candy = candies[indexPath.row]
            }
        *//*
            cell.setName(event.name)
            cell.setjobTitle(event.jobTitle)
            cell.setLogo(event.logo)
            */
        
        if searchController.active{
            if let q = searchController.searchBar.text{
                if q.characters.count <= 0{
                    cell.setName(event.name)
                    cell.setjobTitle(event.jobTitle)
                    cell.setLogo(event.logo)
                } else{
                    cell.setName(Filtered[indexPath.row])
                    for i in 0...Handles.count-1{
                        if Filtered[indexPath.row] == Handles[i]{
                            cell.setjobTitle(AttendeeControl.getEventAt(i).jobTitle)
                            cell.setLogo(AttendeeControl.getEventAt(i).logo)
                        }
                    }
                }
            }
            else {
                cell.setName(event.name)
                cell.setjobTitle(event.jobTitle)
                cell.setLogo(event.logo)
            }
            //cell.setjobTitle(filtered[indexPath.row].jobTitle)
        }
        else{
            cell.setName(event.name)
            cell.setjobTitle(event.jobTitle)
            cell.setLogo(event.logo)
        }

        
        return cell
    }
    
    //filtering content
    /*func filterContentForSearchText(searchText: String, scope: String = "All") {
        filtered = attendes.filter({( event : Event) -> Bool in
            let categoryMatch = (scope == "All") || (event.name == scope)
            return categoryMatch && event.name.lowercaseString.containsString(searchText.lowercaseString)
        })
        tableView.reloadData()
    }*/
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let event: Event
                
                if searchController.active && searchController.searchBar.text != "" {
                    event = filtered[indexPath.row]
                } else {
                    event = attendes[indexPath.row]
                }
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! AttendeeDescription
                controller.detailEvent = event
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (Handles as NSArray).filteredArrayUsingPredicate(searchPredicate)
        Filtered = array as! [String]
        //let arr = (attendes as NSArray).filteredArrayUsingPredicate(searchPredicate)
        //filtered = array as! [Event]
        
        self.tableView.reloadData()
    }
}



/*extension AttendeesViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}*/

/*extension AttendeesViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
}*/



