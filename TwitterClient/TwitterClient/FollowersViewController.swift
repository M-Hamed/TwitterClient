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

class FollowersViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    var followers : [User] = []
    
    @IBOutlet weak var FollowersTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.FollowersTableView.delegate = self
        self.FollowersTableView.dataSource = self
        //Show Logged in User Info
        //        TwitterHelper.loadCurrentUser({ (user) -> () in
        //            self.HandleLabel.text = "@\(user.screenName)"
        //            }) { () -> () in
        //
        //        }
        TwitterHelper.getUserFollowers({ (followers) -> () in
            self.followers = followers
            self.FollowersTableView.reloadData()
            }) { () -> () in
                Alert.showAlert(self, alertType: .Error)
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.FollowersTableView.dequeueReusableCellWithIdentifier("followerCell", forIndexPath: indexPath) as! FollowerCustomTableViewCell
        cell.NameLabel.text = followers[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        valueToPass = followers[indexPath.row].id!
        self.performSegueWithIdentifier("follower", sender: self)
    }
    var valueToPass = ""
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "follower") {
            var viewController = segue.destinationViewController as! FollowerViewController
            viewController.userId = valueToPass
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
