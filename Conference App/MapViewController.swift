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
    
    
    @IBOutlet weak var segmentResult: UISegmentedControl!
    @IBOutlet weak var mainMap: MKMapView!
    @IBOutlet weak var segmentStyle: UISegmentedControl!
  
    // Global Variables
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    var destination: MKMapItem?
    
    // Main Location Information
    var mainName: String = ""
    var mainLatitude: CLLocationDegrees = 30.331991 // Need to get from JSON
    var mainLongitude: CLLocationDegrees = -87.136002 // Need to get from JSON
    var mainDate: String = ""
    var mainDescription: String = ""

    @IBAction func openDirections(sender: AnyObject) {
        // User's Current Location
        let latitude:CLLocationDegrees = (locationManager.location?.coordinate.latitude)!
        let longitude:CLLocationDegrees = (locationManager.location?.coordinate.longitude)!
        
        // Zoom Level
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        
        // User's Current Coordinates
        let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        // Segmented Control on the Bottom of Screen (iTenWired, My Location, & Directions)
        switch sender.selectedSegmentIndex
        {
        case 0:
            // Show Event Location on the Map
            addNotations()
            
        case 1:
            // Show User's Location on the Map
            self.mainMap.showsUserLocation = true;
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
            mainMap.setRegion(region, animated: false)
            
        case 2:
            
            // Get Directions to Event
            let localLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(mainLatitude, mainLongitude)
            let placemark = MKPlacemark(coordinate: localLocation, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "iTenWired Conference"
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMapsWithLaunchOptions(launchOptions)
            
        default:
            break;
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotations()
        
        // Load JSON Data
        let urlString = "http://djmobilesoftware.com/jsondata.json"
        let url = NSURL(string: urlString)
        var contentData = NSData(contentsOfURL: url!)
        
        // Object that JSON is Stored In
        var mainLocation:loc?
        
        // Styling
        segmentStyle.layer.cornerRadius = 5
        
        // Ask for Authorisation from the User.
        //self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        self.mainMap.delegate = self
        startLocation = nil
        
        func serializeAndParse(){
            do {
                let dictionary =  try NSJSONSerialization.JSONObjectWithData(contentData!, options: .MutableContainers) as! NSDictionary
                //let tempdata = dictionary.objectForKey("locations") as? NSArray
                
                mainLocation = betterParsing(dictionary)
                print(mainLocation!.name)
                print(mainLocation!.latitude)
                print(mainLocation!.longitude)
                print(mainLocation!.date)
                print(mainLocation!.description)
                
            }
            catch let error as NSError {
                print(error)
            }
        }
        
        if let url = url {
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                if let error =  error {
                    print("error: \(error.localizedDescription): \(error.userInfo)")
                }
                else if let data = data {
                    if let str = NSString(data: data, encoding: NSUTF8StringEncoding) {
                        print("Received data:\n\(str)")
                        serializeAndParse()
                    }
                    else {
                        print("unable to convert data to text")
                    }
                }
            })
            task.resume()
            
        }
        func betterParsing(dictionary:NSDictionary)->loc {
            
            var data = loc()
            if let locArray = dictionary.objectForKey("locations") as? NSArray {
                
                let locName = locArray[0]["name"]
                let locLat = locArray[0]["latitude"]
                let locLong = locArray[0]["longitude"]
                let locDate = locArray[0]["date"]
                let locDesc = locArray[0]["description"]
                let newLocation = ["name": "\(locName)", "latitude": "\(locLat)", "longitude": "\(locLong)", "date": "\(locDate)", "description": "\(locDesc)"]
                print(newLocation)
                data = loc(dictionary: newLocation)
                
            }
            
            return data
        }
    }
    
    func addNotations() {
        
        // Centers Map on Main Location (Called on Launch)
        let annotation: MKPointAnnotation = MKPointAnnotation()
        let coords = CLLocationCoordinate2D(latitude: mainLatitude, longitude: mainLongitude)
        annotation.title = "iTenWired Conference"
        annotation.coordinate = coords
        self.mainMap.addAnnotation(annotation)
        self.mainMap.selectAnnotation(annotation, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let newRegion:MKCoordinateRegion = MKCoordinateRegion(center:coords, span:span )
        self.mainMap.setRegion(newRegion, animated: true)
        
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

// Enum for JSON Data
enum locationEnum:String {
    case name
    case latitude
    case longitude
    case date
    case description
}

// Location Object that Stores JSON
class loc {
    var name = ""
    var latitude = ""
    var longitude = ""
    var date = ""
    var description = ""
    init() {
        
    }
    init(dictionary:NSDictionary) {
        if let name = dictionary.objectForKey(locationEnum.name.rawValue) as? String {
            self.name = name
        }
        if let latitude = dictionary.objectForKey(locationEnum.latitude.rawValue) as? String {
            self.latitude = latitude
        }
        if let longitude = dictionary.objectForKey(locationEnum.longitude.rawValue) as? String {
            self.longitude = longitude
        }
        if let date = dictionary.objectForKey(locationEnum.date.rawValue) as? String {
            self.date = date
        }
        if let description = dictionary.objectForKey(locationEnum.description.rawValue) as? String {
            self.description = description
        }
    }
    
}