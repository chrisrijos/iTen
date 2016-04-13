//
//  AttendeesCell.swift
//  Conference App
//
//  Created by tuong on 4/11/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class AttendeesCell: UITableViewCell {
    
    @IBOutlet weak var logoImage: UIImageView!
  
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    func setName(name:String){
        nameLabel.text = name
    }
    
    func setLogo(logo:String)
    {
        logoImage.image = UIImage(named: "test")
    }
    
    func setWebsite(website:String)
    {
        websiteLabel.text = website
    }
    
  
}