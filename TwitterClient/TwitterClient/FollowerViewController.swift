//
//  FollowerViewController.swift
//  TwitterClient
//
//  Created by mohamed hamed on 9/20/16.
//  Copyright © 2016 Mohamed Hamed. All rights reserved.
//

import UIKit
import TwitterKit
import SDWebImage

class FollowerViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    var userId : String?
    var tweets : [TWTRTweet] = []
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var TweetsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TweetsTableView.delegate = self
        self.TweetsTableView.dataSource = self
        
        activityIndicator.startAnimating()
        self.view.bringSubviewToFront(activityIndicator);
        
        
        TwitterHelper.getUserTweets(userId!, OnSuccess: { (tweets) -> () in
            
            self.tweets = tweets
            self.TweetsTableView.reloadData()
            self.activityIndicator.stopAnimating()
            
            }) { () -> () in
                Alert.showAlert(self, alertType: .Error)
        }
        
    }
    


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.TweetsTableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCustomTableViewCell
        cell.TweetText.text = tweets[indexPath.row].text//or text ?
        cell.UserName.text =  "@" + tweets[indexPath.row].author.screenName
        cell.LikesCount.text = tweets[indexPath.row].likeCount.description
        cell.RetweetsCount.text = tweets[indexPath.row].retweetCount.description
        cell.Date.text = tweets[indexPath.row].createdAt.description
        let defaultImage = UIImage(named: "profilePic")
        cell.ProfilePic.sd_setImageWithURL(NSURL(string: tweets[indexPath.row].author.profileImageLargeURL), placeholderImage: defaultImage!, options: SDWebImageOptions.ProgressiveDownload, completed: nil)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
