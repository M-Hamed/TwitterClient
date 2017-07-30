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
        activityIndicator.startAnimating()
        self.view.bringSubview(toFront: activityIndicator);
        
        TwitterHelper.getUserFollowers({ (followers) -> () in
            self.followers = followers
            self.FollowersTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }) { () -> () in
            Alert.showAlert(self, alertType: .error)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.FollowersTableView.dequeueReusableCell(withIdentifier: "followerCell", for: indexPath) as! FollowerCustomTableViewCell
        cell.NameLabel.text = followers[indexPath.row].name
        cell.HandleLabel.text = "@" + followers[indexPath.row].handle!
        if followers[indexPath.row].bio != nil {
            cell.BioTextView.text = followers[indexPath.row].bio
        } else{
            cell.BioTextView.text = ""
        }
        
        cell.ProfileImage.sd_setImage(with: URL(string: followers[indexPath.row].profileImageUrl!), placeholderImage: UIImage(named: "profilePic")!, options: SDWebImageOptions.progressiveDownload, completed: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userToPass = followers[indexPath.row]
        self.performSegue(withIdentifier: "follower", sender: self)
    }
    
    var userToPass : User?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier == "follower") {
            let viewController = segue.destination as! FollowerViewController
            viewController.user = userToPass
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
