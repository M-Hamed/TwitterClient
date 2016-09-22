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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //logout
        //        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
        //            Twitter.sharedInstance().sessionStore.logOutUserID(userID)
        //        }
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
                            //                            self.performSegueWithIdentifier("followers", sender: self)
                            
                            
                            self.performSegueWithIdentifier("timeline", sender: self)
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
            //Twitter Login Button
            let logInButton = TWTRLogInButton { (session, error) in
                if let unwrappedSession = session {
                    
                    Alert.showAlert(self, message: "Logged In", title: "\(unwrappedSession.userName) has logged in", completion: { (alertAction) -> Void in
                        self.performSegueWithIdentifier("followers", sender: self)
                    })
                } else {
                    NSLog("Login error: %@", error!.localizedDescription);
                }
            }
            logInButton.center = self.view.center
            self.view.addSubview(logInButton)
            //End Twitter Login Button
            
        }
    }
    //    @IBAction func login(sender: AnyObject) {
    //        //Login Manually
    //        Twitter.sharedInstance().logInWithMethods([.WebBased]) { session, error in
    //            if (session != nil) {
    //                Alert.showAlert(self, message:"\(session!.userName) has logged in" , title:"Logged In" )
    //                //                            self.performSegueWithIdentifier("followers", sender: self)
    //
    //            } else {
    //                print("error: \(error!.localizedDescription)");
    //            }
    //        }
    //        //End Twitter Login manual
    //
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

