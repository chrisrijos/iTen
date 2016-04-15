//
//  AnnotationDetailViewController.swift
//  Conference App
//
//  Created by Julian L on 4/13/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AnnotationDetailViewController: UIViewController {
    
    var receivedAnnotation: AddAnnotation?
    

    @IBOutlet var pointTitle: UILabel!
    @IBOutlet var pointLat: UILabel!
    @IBOutlet var pointLong: UILabel!
    @IBOutlet var pointInfo: UILabel!
    
    @IBAction func dismissView(sender: AnyObject) {
        if let nav = self.navigationController {
            print("Inside Nav")
            navigationController?.popViewControllerAnimated(true)
        }
        else {
            print("Not Inside Nav")
            self.dismissViewControllerAnimated(true, completion: nil)
            //dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    @IBAction func getDirections(sender: AnyObject) {
        if let mainLatitude = receivedAnnotation?.coordinate.latitude, let mainLongitude = receivedAnnotation?.coordinate.longitude, let mainName = receivedAnnotation?.title {
            let localLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(mainLatitude, mainLongitude)
            let placemark = MKPlacemark(coordinate: localLocation, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            
            mapItem.name = mainName
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMapsWithLaunchOptions(launchOptions)
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 100)
        self.pointTitle.textColor = UIColor(red: 1, green: 0.63, blue: 0, alpha: 100)
        self.pointLat.textColor = UIColor(red: 1, green: 0.63, blue: 0, alpha: 100)
        self.pointLong.textColor = UIColor(red: 1, green: 0.63, blue: 0, alpha: 100)
        self.pointInfo.textColor = UIColor(red: 1, green: 0.63, blue: 0, alpha: 100)
        
        if let annotationName = receivedAnnotation?.title, let annotationLat = receivedAnnotation?.coordinate.latitude, let annotationLong = receivedAnnotation?.coordinate.longitude, let annotationInfo = receivedAnnotation?.info {
            pointTitle.text = annotationName
            pointLat.text = String(annotationLat)
            pointLong.text = String(annotationLong)
            pointInfo.text = annotationInfo
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
