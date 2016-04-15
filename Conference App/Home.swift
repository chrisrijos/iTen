//
//  Home.swift
//  Conference App
//
//  Created by B4TH Administrator on 4/8/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
public var Vc: [UIViewController] = []

class Home: UIViewController {
    @IBOutlet weak var HomeStack: UIStackView!
    @IBOutlet weak var ScrollView: UIScrollView!
    override func viewDidLoad() {
        ScrollView.translatesAutoresizingMaskIntoConstraints = false
        HomeStack.translatesAutoresizingMaskIntoConstraints = false
        
        super.viewDidLoad()
        super.restorationIdentifier = "HomeScreen"
        // Do any additional setup after loading the view.
        var Sbd:UIStoryboard? = UIStoryboard.init(name: "Attendees", bundle: nil)
        var dViewController:UIViewController = Sbd!.instantiateViewControllerWithIdentifier("Attendee")
        Vc.append(dViewController)
        Sbd = UIStoryboard.init(name: "MapView", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("MapStoryboard")
        Vc.append(dViewController)
        Sbd = UIStoryboard.init(name: "AboutView", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("AboutView")
        Vc.append(dViewController)
        //Sbd = UIStoryboard.init(name: "ItineraryStoryboard", bundle: nil)
        //dViewController = Sbd!.instantiateViewControllerWithIdentifier("Itinerary")
        //Vc[2] = dViewController
        //Sbd = UIStoryboard.init(name: )
        //Sbd = UIStoryboard.init(name: "AgendaMain", bundle: nil)
        //dViewController = Sbd!.instantiateViewControllerWithIdentifier("AgendaInitial")
        //Vc[3] = dViewController
        //Sbd = UIStoryboard.init(name: "Home", bundle: nil)
        //dViewController = Sbd!.instantiateViewControllerWithIdentifier("Home")
        //Vc[0] = dViewController
        
        for i in 0...2{
            //Vc[i].view!.sizeThatFits(CGSize(width: self.view!.width, height: self.view!.height/40.0))
            HomeStack.addArrangedSubview(Vc[i].view)
            ScrollView.sizeToFit()
            //ScrollView.
        }
        /*var contentRect: CGRect = CGRectZero
        for view in 0...ScrollView.subviews.count-1 {
            let viewF:UIView = ScrollView.subviews[view]
            contentRect = CGRectUnion(contentRect, viewF.frame);
        }*/
        
        //ScrollView.contentSize = contentRect.size;
        //ScrollView.Subview  HomeStack.resizableSnapshotViewFromRect(<#T##rect: CGRect##CGRect#>, afterScreenUpdates: <#T##Bool#>, withCapInsets: <#T##UIEdgeInsets#>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ScrollView.contentSize = CGSize(width: HomeStack.frame.width, height: HomeStack.frame.height)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
