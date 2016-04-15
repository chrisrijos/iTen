//
//  MapViewController.swift
//  Conference App
//
//  Created by Julian L on 4/8/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // Outlets for Map, and Segment Result
    @IBOutlet weak var segmentResult: UISegmentedControl!
    @IBOutlet weak var mainMap: MKMapView!
    @IBOutlet weak var segmentStyle: UISegmentedControl!
    
    // Global Variables
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    var destination: MKMapItem?
    
    // Pulls Map Data
    var mapController: MapData = MapData()
    var locArray: [loc] = []
    var annotationArray: [AddAnnotation] = []
    
    // Coordinates for Center Location
    var latSum:Double = 0.00
    var longSum:Double = 0.00
    
    // Fallback incase JSON does not load
    var mainLatitude: CLLocationDegrees = 30.331991 // Need to get from JSON
    var mainLongitude: CLLocationDegrees = -87.136002 // Need to get from JSON
    
    
    @IBAction func openDirections(sender: AnyObject) {
        
        // Segmented Control on the Bottom of Screen (iTenWired, My Location, & Directions)
        switch sender.selectedSegmentIndex
        {
        case 0:
            // Show All Map Annotations
            let newCoords = CLLocationCoordinate2D(latitude: CLLocationDegrees(latSum), longitude: CLLocationDegrees(longSum))
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let newRegion:MKCoordinateRegion = MKCoordinateRegion(center:newCoords, span:span )
            
            self.mainMap.setRegion(newRegion, animated: true)
            
        case 1:
            
            // Show User's Location on the Map
            self.mainMap.showsUserLocation = true;
            
            let latDelta:CLLocationDegrees = 0.04
            let lonDelta:CLLocationDegrees = 0.04
            
            // If lat & long are available, center map on location
            if let latitude:CLLocationDegrees = locationManager.location?.coordinate.latitude {
                if let longitude:CLLocationDegrees = locationManager.location?.coordinate.longitude {
                    let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                    let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
                    let region:MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
                    mainMap.setRegion(region, animated: false)
                }
            }
            
        default:
            break;
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentStyle.layer.cornerRadius = 5
        
        // Setup the Map and Location Manager
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        self.mainMap.delegate = self
        startLocation = nil
        
        // Retrieves locations from MapData and loaded into locArray
        for locs in mapController.conferenceLocations {
            locArray.append(locs)
        }
        
        if (annotationArray.count == 0) {
            addNotations()
        }
        
    }
    
    // Adds the Info Button to all of the Annotations
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "LocationAnnotation"
        
        if annotation.isKindOfClass(AddAnnotation.self) {
            if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) {
                annotationView.annotation = annotation
                return annotationView
            } else {
                let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                annotationView.enabled = true
                annotationView.canShowCallout = true
                
                let btn = UIButton(type: .DetailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                return annotationView
            }
        }
        
        return nil
    }
    
    // Object that Selected Map Annotation will be Stored In
    var selectedAnnotation: AddAnnotation!
    
    // Called when Annotation Info Button is Selected
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            
            if let tempName = view.annotation?.title, let tempLat = view.annotation?.coordinate.latitude, let tempLong = view.annotation?.coordinate.longitude, let tempSub = view.annotation?.subtitle {
                
                let tempCoord = CLLocationCoordinate2D(latitude: tempLat, longitude: tempLong)
                
                selectedAnnotation = AddAnnotation(title: tempName!, coordinate: tempCoord, info: tempSub!)
                
            }
            //selectedAnnotation = view.annotation as? MKPointAnnotation
            
            // Launches AnnotationDetailViewController
            performSegueWithIdentifier("NextScene", sender: self)
        }
        
        
    }
    
    // Preparing to segue to AnnotationDetailViewController and sending the selected annotation data with it
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? AnnotationDetailViewController {
            destination.receivedAnnotation = selectedAnnotation
        }
    }
    
    // This is called when viewDidLoad() and sets up all of the annotations on the map
    func addNotations() {
        
        // Centers Map on Main Location (Called on Launch)
        var count = 0.00
        
        // All locations "loc" are stored in this array and converted into annotations
        for locs in locArray {
            if let tempLat = CLLocationDegrees(locs.latitude), let tempLong = CLLocationDegrees(locs.longitude), let tempName = locs.name as? String, let tempDesc = locs.description as? String {
            
                let tempCoord = CLLocationCoordinate2D(latitude: CLLocationDegrees(tempLat), longitude: CLLocationDegrees(tempLong))
                latSum += Double(tempLat)
                longSum += Double(tempLong)
                let tempAnnotation = AddAnnotation(title: tempName, coordinate: tempCoord, info: tempDesc)
                
                annotationArray.append(tempAnnotation)
                count += 1
            }
            
        }
        
        // Add annotations to the map
        if !(annotationArray.isEmpty) {
            self.mainMap.addAnnotations(annotationArray)
            
            //        for locs in annotationArray {
            //            self.mainMap.selectAnnotation(locs, animated: false)
            //        }
            
            // Gets the average coordinates to center the map region on
            latSum = latSum/count
            longSum = longSum/count
            
            // Centers the map based on average of locations
            let newCoords = CLLocationCoordinate2D(latitude: CLLocationDegrees(latSum), longitude: CLLocationDegrees(longSum))
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let newRegion:MKCoordinateRegion = MKCoordinateRegion(center:newCoords, span:span )
            
            self.mainMap.setRegion(newRegion, animated: true)
            self.mainMap.showsUserLocation = true;
            
        }
        else {
            var noInternet = UIAlertController(title: "Internet Connection", message: "Map cannot be loaded because there is no internet connection.", preferredStyle: UIAlertControllerStyle.Alert)
            
            noInternet.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
            }))
            
            presentViewController(noInternet, animated: true, completion: nil)
            latSum = mainLatitude
            longSum = mainLongitude
            
            let newCoords = CLLocationCoordinate2D(latitude: CLLocationDegrees(latSum), longitude: CLLocationDegrees(longSum))
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let newRegion:MKCoordinateRegion = MKCoordinateRegion(center:newCoords, span:span )
            
            self.mainMap.setRegion(newRegion, animated: true)
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

