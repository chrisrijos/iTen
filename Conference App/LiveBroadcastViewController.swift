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
    
    // Duration time in seconds
    var count: Int = 0
    var badStreamCount: Int = 0
    
    @IBOutlet var broadcastTitle: UILabel!
    
    @IBOutlet var hours: UILabel!
    @IBOutlet var minutes: UILabel!
    @IBOutlet var seconds: UILabel!
    
    // Starts the Audio Stream
    @IBAction func playAudio(sender: AnyObject) {
        startAudio()
    }
    
    // Pauses the Stream
    @IBAction func stopAudio(sender: AnyObject) {
        if let tempPlayer = player {
            tempPlayer.pause()
            player = nil
            count = 0
            hours.text = "00"
            minutes.text = "00"
            seconds.text = "00"
            timer.invalidate()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial VC Styling
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 100)
        self.broadcastTitle.textColor = UIColor(red: 1, green: 0.63, blue: 0, alpha: 100)
        
        // This Code Lets the App Play MP3 in Background, Not Implemented Yet
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        
        do { try session.setCategory(AVAudioSessionCategoryPlayback) }
        catch { }
    }
    
    // Figures out the duration that the stream has been going
    func audioDuration() {
        
        // Count is number of seconds the stream has been running
        count = count + 1
        print("Count: \(count)")
        let time = secondsToHoursMinutesSeconds(count)
        
        // Format the time
        hours.text = String(format: "%02d", time.0)
        minutes.text = String(format: "%02d", time.1)
        seconds.text = String(format: "%02d", time.2)
        
        // Checks on the Status of the Audio Stream, and determines whether or not to disconnect
        if (self.player!.currentItem!.playbackLikelyToKeepUp == false)
        {
            // Stream is not likely to proceed
            badStreamCount = badStreamCount + 1
            //print("Bad Stream Count: \(badStreamCount)")
        }
        else if (self.player?.rate == 0.0) {
            // Internet Connection drops during stream
            badStreamCount = badStreamCount + 1
        }
        else {
            // Stream is successful, and will keep playing
            if (badStreamCount > 0) {
                badStreamCount = badStreamCount - 1
            }
        }
        
        // If the count of badStreamCount > 5, display a message saying stream unavailable
        if badStreamCount > 2 {
            timer.invalidate()
            var noStream = UIAlertController(title: "Stream Unavailable", message: "Stream cannot be loaded or is unavailable at this time.", preferredStyle: UIAlertControllerStyle.Alert)
            
            noStream.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
                self.count = 0
                self.badStreamCount = 0
                self.hours.text = "00"
                self.minutes.text = "00"
                self.seconds.text = "00"
            }))
            
            presentViewController(noStream, animated: true, completion: nil)
        }
        
    }
    func startAudio() {
        
        // Creates a timer that updates the duration labels (HH:MM:SS)
        var newtimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("audioDuration"), userInfo: nil, repeats: true)
        timer.invalidate()
        timer = newtimer
        
        // Initiate the new AVPlayer instance
        let url = "http://pubint.ic.llnwd.net/stream/pubint_wuwfhd3"
        //let url = "http://199.180.72.2:9110/;stream.mp3"
        
        let playerItem = AVPlayerItem( URL:NSURL( string:url )! )
        player = AVPlayer(playerItem:playerItem)
        
        if let tempPlayer = player {
            tempPlayer.rate = 1.0;
            tempPlayer.play()
        }
        
    }
    
    // Converts seconds to (HH:MM:SS) to display on screen
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    override func viewWillDisappear(animated: Bool) {
        // Restart timer when user leaves the application
        // count = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

