//
//  TimeLineViewController.swift
//  TwitterClient
//
//  Created by mohamed hamed on 9/20/16.
//  Copyright © 2016 Mohamed Hamed. All rights reserved.
//
import UIKit
import TwitterKit

class TimeLineViewController: TWTRTimelineViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterHelper.loadCurrentUser({ (user) -> () in
            let client = TWTRAPIClient(userID:user.userID )
            self.dataSource = TWTRUserTimelineDataSource(screenName: user.screenName, apiClient: client)
            }) { () -> () in
                print("failed")
        }
    }

    @IBAction func logOut(_ sender: AnyObject) {
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            Twitter.sharedInstance().sessionStore.logOutUserID(userID)
            self.performSegue(withIdentifier: "login", sender: self)

        }
    }
}
