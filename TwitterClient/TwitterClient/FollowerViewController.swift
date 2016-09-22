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
import NYTPhotoViewer

class FollowerViewController: UIViewController , UITableViewDelegate,UITableViewDataSource , NYTPhotosViewControllerDelegate{
    //    var userId : String?
    var user : User?
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var bannerPic: UIImageView!
    
    
    var tweets : [TWTRTweet] = []
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var TweetsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileTap = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
        profilePic.addGestureRecognizer(profileTap)
        let bannerTap = UITapGestureRecognizer(target: self, action: Selector("bannerTapped:"))
        bannerPic.addGestureRecognizer(bannerTap)
        
        self.TweetsTableView.delegate = self
        self.TweetsTableView.dataSource = self
        
        activityIndicator.startAnimating()
        self.view.bringSubviewToFront(activityIndicator);
        
        
        
        
        profilePic.sd_setImageWithURL(NSURL(string: user!.profileImageUrl!), placeholderImage: UIImage(named: "profilePic"), options: SDWebImageOptions.ProgressiveDownload, completed: nil)
        bannerPic.sd_setImageWithURL(NSURL(string: user!.bannerImageUrl!), placeholderImage: UIImage(named: "twitter-banner")!, options: SDWebImageOptions.ProgressiveDownload, completed: nil)
        
        
        TwitterHelper.getUserTweets((user?.id!)!, OnSuccess: { (tweets) -> () in
            
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
    
    // MARK: - NYTPhotosViewControllerDelegate
    
    func photosViewController(photosViewController: NYTPhotosViewController, handleActionButtonTappedForPhoto photo: NYTPhoto) -> Bool {
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            
            guard let photoImage = photo.image else { return false }
            
            let shareActivityViewController = UIActivityViewController(activityItems: [photoImage], applicationActivities: nil)
            
            shareActivityViewController.completionWithItemsHandler = {(activityType: String?, completed: Bool, items: [AnyObject]?, error: NSError?) in
                if completed {
                    photosViewController.delegate?.photosViewController!(photosViewController, actionCompletedWithActivityType: activityType!)
                }
            }
            
            shareActivityViewController.popoverPresentationController?.barButtonItem = photosViewController.rightBarButtonItem
            photosViewController.presentViewController(shareActivityViewController, animated: true, completion: nil)
            
            return true
        }
        
        return false
    }
    
    //Image popup
    
    func imageTapped( sender : UITapGestureRecognizer)
    {
        let imageview  = sender.view! as! UIImageView;
        imagePopup(imageview.image!)
    }
    func imagePopup(image : UIImage)
    {
        var photos : [ExamplePhoto] = []
        photos.append(ExamplePhoto(image: image, imageData: nil, attributedCaptionTitle: NSAttributedString(string: "")))
        let photosViewController = NYTPhotosViewController(photos: photos)
        photosViewController.delegate = self
        presentViewController(photosViewController, animated: true, completion: nil)
    }
    func bannerTapped( sender : UITapGestureRecognizer)
    {
        let imageview  = sender.view! as! UIImageView;
        imagePopup(imageview.image!)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
