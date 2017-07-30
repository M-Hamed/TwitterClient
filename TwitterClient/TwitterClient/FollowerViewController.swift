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

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var bannerPic: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var TweetsTableView: UITableView!
    
    var tweets : [TWTRTweet] = []
    var user : User?

    override func viewDidLoad() {
        super.viewDidLoad()
        let profileTap = UITapGestureRecognizer(target: self, action: #selector(FollowerViewController.imageTapped(_:)))
        profilePic.addGestureRecognizer(profileTap)
        let bannerTap = UITapGestureRecognizer(target: self, action: #selector(FollowerViewController.bannerTapped(_:)))
        bannerPic.addGestureRecognizer(bannerTap)
        
        self.TweetsTableView.delegate = self
        self.TweetsTableView.dataSource = self
        
        activityIndicator.startAnimating()
        self.view.bringSubview(toFront: activityIndicator);
        
        profilePic.sd_setImage(with: URL(string: user!.profileImageUrl!), placeholderImage: UIImage(named: "profilePic"), options: SDWebImageOptions.progressiveDownload, completed: nil)
        bannerPic.sd_setImage(with: URL(string: user!.bannerImageUrl!), placeholderImage: UIImage(named: "twitter-banner")!, options: SDWebImageOptions.progressiveDownload, completed: nil)
        
        TwitterHelper.getUserTweets((user?.id!)!, OnSuccess: { (tweets) -> () in
            self.tweets = tweets
            self.TweetsTableView.reloadData()
            self.activityIndicator.stopAnimating()
            }) { () -> () in
                Alert.showAlert(self, alertType: .error)
        }
    }    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.TweetsTableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCustomTableViewCell
        cell.TweetText.text = tweets[indexPath.row].text//or text ?
        cell.UserName.text =  "@" + tweets[indexPath.row].author.screenName
        cell.LikesCount.text = tweets[indexPath.row].likeCount.description
        cell.RetweetsCount.text = tweets[indexPath.row].retweetCount.description
        cell.Date.text = tweets[indexPath.row].createdAt.description
        let defaultImage = UIImage(named: "profilePic")
        cell.ProfilePic.sd_setImage(with: URL(string: tweets[indexPath.row].author.profileImageLargeURL), placeholderImage: defaultImage!, options: SDWebImageOptions.progressiveDownload, completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func photosViewController(_ photosViewController: NYTPhotosViewController, handleActionButtonTappedFor photo: NYTPhoto) -> Bool {
        return false
    }
    
    func imageTapped( _ sender : UITapGestureRecognizer) {
        let imageview  = sender.view! as! UIImageView;
        imagePopup(imageview.image!)
    }
    func imagePopup(_ image : UIImage) {
        var photos : [ExamplePhoto] = []
        photos.append(ExamplePhoto(image: image, imageData: nil, attributedCaptionTitle: NSAttributedString(string: "")))
        let photosViewController = NYTPhotosViewController(photos: photos)
        photosViewController.delegate = self
        present(photosViewController, animated: true, completion: nil)
    }
    func bannerTapped( _ sender : UITapGestureRecognizer) {
        let imageview  = sender.view! as! UIImageView;
        imagePopup(imageview.image!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
