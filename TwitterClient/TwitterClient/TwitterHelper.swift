//
//  TwitterHelper.swift
//  TwitterClient
//
//  Created by mohamed hamed on 9/20/16.
//  Copyright © 2016 Mohamed Hamed. All rights reserved.
//

import Foundation
import TwitterKit
import SwiftyJSON

//TODO
//user Twitter Cursring to load more data by swiping
//https://dev.twitter.com/overview/api/cursoring
class TwitterHelper {
    
    class func loadCurrentUser(_ OnSuccess: @escaping (_ user : TWTRUser)->() , OnFail : @escaping () -> ())
    {
        if let session = Twitter.sharedInstance().sessionStore.session() {
            
            let client = TWTRAPIClient.withCurrentUser()
            client.loadUser(withID: session.userID) { (user, error) -> Void in
                if error == nil {
                    DispatchQueue.main.async(execute: { () -> Void in
                        OnSuccess( user!)
                    })
                }
                else {
                    DispatchQueue.main.async(execute: { () -> Void in
                        OnFail()
                    })
                }
            }
        }
    }
    
    class func getUserFollowers(_ OnSuccess: @escaping (_ followers : [User])->() , OnFail : @escaping () -> ())
    {
        if let session = Twitter.sharedInstance().sessionStore.session() {
            let client = TWTRAPIClient.withCurrentUser()
            client.loadUser(withID: session.userID) { (user, error) -> Void in
                if error == nil {
                    if let user = user {
                        let client = TWTRAPIClient(userID: session.userID)
                        //TODO use cursers to implement infinte scroll
                        //https://dev.twitter.com/overview/api/cursoring
                        
                        let followersShowEndpoint = "https://api.twitter.com/1.1/followers/list.json"
                        let params = ["id": user.userID]
                        var clientError : NSError?
                        let request = client.urlRequest(withMethod: "GET", url: followersShowEndpoint, parameters: params, error: &clientError)
                        
                        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                            if connectionError != nil {
                                DispatchQueue.main.async(execute: { () -> Void in
                                    OnFail()
                                })
                            }
                            var users : [User] = []
                            let json = JSON(data: data!)
                            for (_,userJson):(String, JSON) in json["users"] {
                                let user:User = User(json: userJson)
                                users.append(user)
                            }
                            DispatchQueue.main.async(execute: { () -> Void in
                                OnSuccess(users)
                            })
                        }
                    }
                } else {
                    OnFail()
                }
                
            }
        }
    }
    class func getUserTweets(_ followerId : String , OnSuccess: @escaping (_ tweets : [TWTRTweet])->() , OnFail : @escaping () -> ())
    {
        if let session = Twitter.sharedInstance().sessionStore.session() {
            let client = TWTRAPIClient(userID: session.userID)
            client.loadUser(withID: session.userID) { (user, error) -> Void in
                if error == nil {
                    let client = TWTRAPIClient(userID: session.userID)
                    let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
                    let params = ["id": followerId,"count":"10"]
                    var clientError : NSError?
                    let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params, error: &clientError)
                    
                    client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                        if connectionError != nil {
                            DispatchQueue.main.async(execute: { () -> Void in
                                OnFail()
                            })
                        }
                        do {
                            var tweets : [TWTRTweet] = []
                            let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            print("json: \(json)")
                            for item in json as! [Dictionary<String, AnyObject>] {
                                let tweet : TWTRTweet = TWTRTweet(jsonDictionary: item)!
                                print(tweet.description)
                                print(tweet.createdAt.description)
                                print(tweet.text)
                                print(tweet.retweetCount)
                                print(tweet.likeCount)
                                print(tweet.author.profileImageLargeURL)
                                print(tweet.author.screenName)
                                tweets.append(tweet)
                            }
                            DispatchQueue.main.async(execute: { () -> Void in
                                OnSuccess(tweets)
                            })
                        } catch let _ as NSError {
                            DispatchQueue.main.async(execute: { () -> Void in
                                OnFail()
                            })
                        }
                    }
                } else {
                    OnFail()
                }
            }
        }
    }
}
