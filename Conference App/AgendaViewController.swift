//
//  ViewController.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import UIKit

class AgendaViewController: UITableViewController, UIGestureRecognizerDelegate {

    var agendaController:AgendaController = AgendaController()
    var append = appendToMyIten()
    var fistTouch:Bool = false
    let swipeImageIndex = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.userInteractionEnabled = true
        
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableViewAutomaticDimension     // Sets the table view's row height to automatic
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        
    }
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        //self.swipeImage.removeFromSuperview()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
       
        
        if(section == 0){
            return agendaController.getEventsCount()
        }
        
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        let event = agendaController.getEventAt(indexPath.row)
        
        cell.setName(event.name)
        cell.setStartTime(event.timeStart)
        cell.setStopTime(event.timeStop)
        cell.setDate(event.date)
        
        if(indexPath.row == swipeImageIndex && !self.fistTouch){
            cell.showSwipe(true)
        }else{
            cell.showSwipe(false)
        }
        

        return cell
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        
        
        let add = UITableViewRowAction(style: .Normal, title: "Add to MyIten") { action, index in
            self.append.appendAgenda(self.agendaController.getEventAt(indexPath.row))
            print("Selected")
            print(indexPath.row)

        }
        add.backgroundColor = UIColor.lightGrayColor()
        
        if(indexPath.row == swipeImageIndex && !fistTouch){
            fistTouch = true
            tableView.reloadData()
        }
        
        return [add]
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == swipeImageIndex && !fistTouch){
           fistTouch = true
            tableView.reloadData()
        }else{
            
            let destinationViewController: EventViewController
            = (storyboard?.instantiateViewControllerWithIdentifier("EventViewController") as? EventViewController)!
            
            let event = self.agendaController.getEventAt(indexPath.row)
            destinationViewController.event = event
            
            self.navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
    
}

