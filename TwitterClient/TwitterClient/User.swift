//
//  User.swift
//  TwitterClient
//
//  Created by mohamed hamed on 9/20/16.
//  Copyright © 2016 Mohamed Hamed. All rights reserved.
//

import Foundation
import SwiftyJSON

//TODO Use TWTRUser instead 
class User {
    var id : String?
    var handle: String?
    var name : String?
    var profileImageUrl : String?
    var bannerImageUrl : String?
    var bio : String?

    init(json : JSON)
    {
        if let _ = json["id_str"].string
        {
            self.id = json["id_str"].string
        }
        if let _ = json["screen_name"].string
        {
            self.handle = json["screen_name"].string
        }
        
        if let _ = json["name"].string
        {
            self.name = json["name"].string
        }
        if let _ = json["profile_image_url"].string
        {
            self.profileImageUrl = json["profile_image_url"].string
        }
        if let _ = json["description"].string
        {
            self.bio = json["description"].string
        }
        if let _ = json["profile_banner_url"].string
        {
            self.bannerImageUrl = json["profile_banner_url"].string
        }
        
        
    }
}






