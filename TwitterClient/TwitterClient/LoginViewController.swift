//
//  ViewController.swift
//  TwitterClient
//
//  Created by mohamed hamed on 9/19/16.
//  Copyright © 2016 Mohamed Hamed. All rights reserved.
//

import UIKit
import TwitterKit
import SwiftyJSON
class LoginViewController: UIViewController {
    
    //logout
    //    if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
    //        Twitter.sharedInstance().sessionStore.logOutUserID(userID)
    //    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //There is a valid session //logged in user
        if (Twitter.sharedInstance().sessionStore.session() != nil)
        {
            if let session = Twitter.sharedInstance().sessionStore.session() {
                let client = TWTRAPIClient.clientWithCurrentUser()
                //let client = TWTRAPIClient(userID: session.userID)
                client.loadUserWithID(session.userID) { (user, error) -> Void in
                    if error == nil
                    {
                        if let user = user {
                            print("@\(user.screenName) \(user.userID)")
                            //navigate to the followers page
                            self.performSegueWithIdentifier("followers", sender: self)
                        }
                    }
                    else
                    {
                        print("Login error: \(error?.localizedDescription)")
                    }
                    
                }
            }
        }
            //The login process, There is no valid session
        else
        {
            //Twitter Login
            let logInButton = TWTRLogInButton { (session, error) in
                if let unwrappedSession = session {
                    let alert = UIAlertController(title: "Logged In",
                        message: "\(unwrappedSession.userName) has logged in",
                        preferredStyle: UIAlertControllerStyle.Alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    NSLog("Login error: %@", error!.localizedDescription);
                }
            }
            
            // TODO: Change where the log in button is positioned in your view
            logInButton.center = self.view.center
            self.view.addSubview(logInButton)
            //End Twitter Login
            
            //            //Login Manually
            //            Twitter.sharedInstance().logInWithMethods([.WebBased]) { session, error in
            //                if (session != nil) {
            //                    print("signed in as \(session!.userName)");
            //
            //                    let alert = UIAlertController(title: "Logged In",
            //                        message: "\(session!.userName) has logged in",
            //                        preferredStyle: UIAlertControllerStyle.Alert
            //                    )
            //                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            //                    self.presentViewController(alert, animated: true, completion: nil)
            //                    //                //Get EMail
            //                    //                let client = TWTRAPIClient.clientWithCurrentUser()
            //                    //                let request = client.URLRequestWithMethod("GET",
            //                    //                    URL: "https://api.twitter.com/1.1/account/verify_credentials.json",
            //                    //                    parameters: ["include_email": "true", "skip_status": "true"],
            //                    //                    error: nil)
            //                    //
            //                    //                client.sendTwitterRequest(request) { response, data, connectionError in
            //                    //
            //                    //                    let json = JSON(data: data!)
            //                    //
            //                    //                        print(json)
            //                    //                        print(json["email"])
            //                    //
            //                    //
            //                    //                }
            //                    //                //Email
            //
            //
            //                } else {
            //                    print("error: \(error!.localizedDescription)");
            //                }
            //                
            //            }
        }
        
        
        
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

