//
//  FollowersViewController.swift
//  TwitterClient
//
//  Created by mohamed hamed on 9/20/16.
//  Copyright © 2016 Mohamed Hamed. All rights reserved.
//

import UIKit
import TwitterKit
import SwiftyJSON

class FollowersViewController: UIViewController {
    
    var followers : [User] = []
    
    @IBOutlet weak var HandleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Show Logged in User Info
        TwitterHelper.loadCurrentUser({ (user) -> () in
            self.HandleLabel.text = "@\(user.screenName)"
            }) { () -> () in
        
        }
        TwitterHelper.getUserFollowers({ (followers) -> () in
            self.followers = followers
            }) { () -> () in
                Alert.showAlert(self, alertType: .Error)
        }
       
        
        // Do any additional setup after loading the view.
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
