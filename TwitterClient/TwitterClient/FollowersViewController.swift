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
import SDWebImage

class FollowersViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
        activityIndicator.startAnimating()
        self.view.bringSubviewToFront(activityIndicator);
        
        TwitterHelper.getUserFollowers({ (followers) -> () in
            self.followers = followers
            self.FollowersTableView.reloadData()
            self.activityIndicator.stopAnimating()
            }) { () -> () in
                Alert.showAlert(self, alertType: .Error)
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.FollowersTableView.dequeueReusableCellWithIdentifier("followerCell", forIndexPath: indexPath) as! FollowerCustomTableViewCell
        cell.NameLabel.text = followers[indexPath.row].name
        cell.HandleLabel.text = "@" + followers[indexPath.row].handle!
        if followers[indexPath.row].bio != nil
        {
            cell.BioTextView.text = followers[indexPath.row].bio
        }else{
            cell.BioTextView.text = ""
        }
        let defaultImage = UIImage(named: "profilePic")
        
        cell.ProfileImage.sd_setImageWithURL(NSURL(string: followers[indexPath.row].profileImageUrl!), placeholderImage: defaultImage!, options: SDWebImageOptions.ProgressiveDownload, completed: nil)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        valueToPass = followers[indexPath.row].id!
        userToPass = followers[indexPath.row]
        self.performSegueWithIdentifier("follower", sender: self)
    }
//    var valueToPass = ""
    var userToPass : User?
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "follower") {
            
            //            let nav = segue.destinationViewController as! UINavigationController
            //            let viewController = nav.topViewController as! FollowerViewController
            let viewController = segue.destinationViewController as! FollowerViewController
//            viewController.userId = valueToPass
            viewController.user = userToPass
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
