//
//  MasterViewController.swift
//  Conference App
//
//  Created by B4TH Administrator on 4/1/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    let x:[AnyObject] = ["Home","Map","Agenda","My Iten","Social Media","Live Broadcast","About","Who is Here", "Settings"]
    let m:[UIImage] = [UIImage(named:"Home.png")!,UIImage(named:"Map.png")!,UIImage(named:"Agenda.png")!,UIImage(named:"MyIten.png")!,UIImage(named:"SocialMedia.png")!,UIImage(named:"LiveBroadcast.png")!,UIImage(named:"About.png")!,UIImage(named:"Who.png")!,UIImage(named:"Settings.png")!]
    
        
        //instantiateViewControllerWithIdentifier("Attendee") as? UIViewController
    
    
    
    
    
    
    var Vc:[UIViewController] = [UINavigationController(),UIViewController(),UIViewController(),UIViewController(),UIViewController(),UIViewController(),UIViewController(),UIViewController(),UIViewController()]
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    var items: NSMutableArray!
    var images: NSMutableArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = NSMutableArray(array: x)
        self.images = NSMutableArray(array: m)
        self.title = "iTen Wired"
        //self.restorationIdentifier = "llll"
        //self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        self.tableView = UITableView(frame:self.view!.frame)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //self.view?.addSubview(self.tableView)
        self.tableView.rowHeight = CGFloat(65.00)
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 100)

        Vc[0].addChildViewController(UIViewController())
        Vc[0].navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self.view, action: nil)
        var Sbd:UIStoryboard? = UIStoryboard.init(name: "Attendees", bundle: nil)
        var dViewController:UIViewController = Sbd!.instantiateViewControllerWithIdentifier("Attendee")
        Vc[7] = dViewController;
        Sbd = UIStoryboard.init(name: "MapView", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("MapStoryboard")
        Vc[1] = dViewController
        Sbd = UIStoryboard.init(name: "AboutView", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("AboutView")
        Vc[6] = dViewController
        Sbd = UIStoryboard.init(name: "ItineraryStoryboard", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("Itinerary")
        Vc[2] = dViewController
        //Sbd = UIStoryboard.init(name: )
        Sbd = UIStoryboard.init(name: "AgendaMain", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("AgendaInitial")
        Vc[2] = dViewController
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(Name: String, Content: UIViewController) {
        
    }

    // MARK: - Segues

    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
            //let object = self.fetchedResultsController.objectAtIndexPath(indexPath)
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                //controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }*/
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let view = Vc[indexPath.row]
        //self.showDetailViewController(view, sender: self)
        //self.presentViewController(view,animated: true, completion: nil)
        //self.navigationController?.pushViewController(view, animated: true)
        
        self.showDetailViewController(view, sender: self)
    }
    // MARK: - Table View

    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //return self.fetchedResultsController.sections?.count ?? 0
    }*/

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects*/
        
        return self.items.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        self.configureCell(cell, withObject: object)
        return cell*/
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = "\(self.items[indexPath.row])"
        if let q:UIImage? = self.images[indexPath.row] as? UIImage{
            cell.imageView?.image = q
        }
        cell.backgroundColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 0.5)
        //cell.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.75, alpha: 0.5)
        cell.textLabel?.textColor = UIColor(red: 1, green: 0.63, blue: 0, alpha: 100)
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.cyanColor()
        cell.selectedBackgroundView = bgColorView
        //cell.setValue(UIView(), forKeyPath: "Home")
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        //return true
        return false
    }

    /*override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        /*if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
                
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //print("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }*/
    }*/
/*
    func configureCell(cell: UITableViewCell, withObject object: NSManagedObject) {
        //cell.textLabel!.text = object.valueForKey("timeStamp")!.description
    }*/

    // MARK: - Fetched results controller

    /*var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Event", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        //let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
        
        //fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             //print("Unresolved error \(error), \(error.userInfo)")
             abort()
        }
        
        return _fetchedResultsController!
    }*/
    //var _fetchedResultsController: NSFetchedResultsController? = nil

    /*func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
            case .Insert:
                self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Update:
                self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, withObject: anObject as! NSManagedObject)
            case .Move:
                tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */*/

}


/*
func insertNewObject(Name: String, Content: UIViewController) {
    /* Default Code
     let context = self.fetchedResultsController.managedObjectContext
     let entity = self.fetchedResultsController.fetchRequest.entity!
     let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context)
     
     // If appropriate, configure the new managed object.
     // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
     newManagedObject.setValue(NSDate(), forKey: "timeStamp")
     
     // Save the context.
     do {
     try context.save()
     } catch {
     // Replace this implementation with code to handle the error appropriately.
     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
     //print("Unresolved error \(error), \(error.userInfo)")
     abort()
     }
     */
    
    
    
    
    
}
*/



/*
 override func viewDidLoad() {
 super.viewDidLoad()
 // Do any additional setup after loading the view, typically from a nib.
 //self.navigationItem.leftBarButtonItem = self.editButtonItem()
 
 //let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
 //self.navigationItem.rightBarButtonItem = addButton
 
 
 
 if let split = self.splitViewController {
 let controllers = split.viewControllers
 self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
 }
 }
*/
