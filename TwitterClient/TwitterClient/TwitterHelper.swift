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

class TwitterHelper {
    
    class func loadCurrentUser(OnSuccess: (user : TWTRUser)->() , OnFail : () -> ())
    {
        if let session = Twitter.sharedInstance().sessionStore.session() {
            
            let client = TWTRAPIClient.clientWithCurrentUser()
            //let client = TWTRAPIClient(userID: session.userID)
            client.loadUserWithID(session.userID) { (user, error) -> Void in
                if error == nil
                {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        OnSuccess( user: user!)
                    })
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        OnFail()
                    })
                }
            }
        }
    }
    
    class func getUserFollowers(OnSuccess: (followers : [User])->() , OnFail : () -> ())
    {
        if let session = Twitter.sharedInstance().sessionStore.session() {
            let client = TWTRAPIClient.clientWithCurrentUser()
            //let client = TWTRAPIClient(userID: session.userID)
            client.loadUserWithID(session.userID) { (user, error) -> Void in
                if error == nil
                {
                    if let user = user {
                        print("@\(user.screenName) \(user.userID)")
                        
                        /////Get Followers
                        let client = TWTRAPIClient(userID: session.userID)
                        
                        //TODO use cursers to implement infinte scroll
                        //https://dev.twitter.com/overview/api/cursoring
                        
                        let followersShowEndpoint = "https://api.twitter.com/1.1/followers/list.json"
                        let params = ["id": user.userID]
                        var clientError : NSError?
                        let request = client.URLRequestWithMethod("GET", URL: followersShowEndpoint, parameters: params, error: &clientError)
                        
                        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                            if connectionError != nil {
                                print("Error: \(connectionError)")
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    OnFail()
                                })
                            }
                            var users : [User] = []
                            //TODO Check for parsing errors
                            let json = JSON(data: data!)
                            print(json["users"])
                            for (_,userJson):(String, JSON) in json["users"]
                            {
                                let user:User = User(json: userJson)
                                users.append(user)
                                print(user.name!)
                            }
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                OnSuccess(followers: users)
                            })
                        }
                        
                    }
                }
                else
                {
                    print("Login error: \(error?.localizedDescription)")
                    OnFail()
                }
                
            }
        }
    }
    class func getUserTweets(followerId : String , OnSuccess: ()->() , OnFail : () -> ())
    {
        if let session = Twitter.sharedInstance().sessionStore.session() {
//            let client = TWTRAPIClient.clientWithCurrentUser()
            let client = TWTRAPIClient(userID: session.userID)
            client.loadUserWithID(session.userID) { (user, error) -> Void in
                if error == nil
                {
                        let client = TWTRAPIClient(userID: session.userID)
                    

                        let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
                        let params = ["id": followerId,"count":"10"]
//                    let params = ["id": session.userID]
                    var clientError : NSError?
                        let request = client.URLRequestWithMethod("GET", URL: statusesShowEndpoint, parameters: params, error: &clientError)
                        
                        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                            if connectionError != nil {
                                print("Error: \(connectionError)")
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    OnFail()
                                })
                            }
                            
                            let json = JSON(data: data!)
                            print(json)
                            
                        }
                        
                }
                else
                {
                    print("Login error: \(error?.localizedDescription)")
                    OnFail()
                }
                
            }
        }
    }
}