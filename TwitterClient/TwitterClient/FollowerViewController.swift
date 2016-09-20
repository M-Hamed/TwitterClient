//
//  FollowerViewController.swift
//  TwitterClient
//
//  Created by mohamed hamed on 9/20/16.
//  Copyright © 2016 Mohamed Hamed. All rights reserved.
//

import UIKit
import TwitterKit

class FollowerViewController: UIViewController {
    var userId : String?

    override func viewDidLoad() {
        super.viewDidLoad()
      
                
        TwitterHelper.getUserTweets(userId!, OnSuccess: { () -> () in
            
            }) { () -> () in
                
        }

        
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
