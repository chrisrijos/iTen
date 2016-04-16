//
//  ViewController.swift
//  liveStream
//
//  Created by Julian L on 4/16/16.
//  Copyright © 2016 Julian Loftis. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia
import AVKit
import CoreData
import SystemConfiguration

class LiveBroadcastViewController: UIViewController {
    var player: AVPlayer?
    var timer = NSTimer()
    
    var count: Int = 0
    
    @IBOutlet var broadcastTitle: UILabel!
    
    @IBOutlet var hours: UILabel!
    @IBOutlet var minutes: UILabel!
    @IBOutlet var seconds: UILabel!
    
    @IBAction func playAudio(sender: AnyObject) {
//        if ViewController.isConnectedToNetwork() {
//            print("Yes")
//        }
//        else {
//            print("No")
//        }
        configureView()
    } 
    @IBAction func pauseAudio(sender: AnyObject) {
        player!.pause()
        player = nil
        timer.invalidate()
    }
    //@IBOutlet var audioView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 100)
        self.broadcastTitle.textColor = UIColor(red: 1, green: 0.63, blue: 0, alpha: 100)
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            //catching the error.
        }
        
        
        
    }
    func audioDuration() {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(count)
        
        hours.text = String(format: "%02d", time.0)
        minutes.text = String(format: "%02d", time.1)
        seconds.text = String(format: "%02d", time.2)
        
        //print("Hours: \(String(format: "%02d", time.0))  Minutes: \(String(format: "%02d", time.1))  Seconds: \(String(format: "%02d", time.2))")
    }
    func configureView() {
        var newtimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("audioDuration"), userInfo: nil, repeats: true)
        timer = newtimer
        
        let url = "http://199.180.72.2:9110/;stream.mp3"
        let playerItem = AVPlayerItem( URL:NSURL( string:url )! )
        player = AVPlayer(playerItem:playerItem)
        player!.rate = 1.0;
        player!.play()
        
    }
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
//    class func isConnectedToNetwork() -> Bool {
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
//            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
//        }
//        var flags = SCNetworkReachabilityFlags()
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
//            return false
//        }
//        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
//        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//        return (isReachable && !needsConnection)
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

