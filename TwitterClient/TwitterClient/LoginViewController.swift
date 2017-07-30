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
        if (Twitter.sharedInstance().sessionStore.session() != nil)
        {
            if let session = Twitter.sharedInstance().sessionStore.session() {
                let client = TWTRAPIClient.withCurrentUser()
                client.loadUser(withID: session.userID) { (user, error) -> Void in
                    if error == nil
                    {
                        if let user = user {
                            print("@\(user.screenName) \(user.userID)")
                            self.performSegue(withIdentifier: "timeline", sender: self)
                        }
                    }
                    else
                    {
                        print("Login error: \(error?.localizedDescription)")
                    }
                }
            }
        }
        else
        {
            let logInButton = TWTRLogInButton { (session, error) in
                if let unwrappedSession = session {
                    
                    Alert.showAlert(self, message: "Logged In", title: "\(unwrappedSession.userName) has logged in", completion: { (alertAction) -> Void in
                        self.performSegue(withIdentifier: "timeline", sender: self)
                    })
                } else {
                    NSLog("Login error: %@", error!.localizedDescription);
                }
            }
            logInButton.loginMethods = [.webBased]
            logInButton.center = self.view.center
            self.view.addSubview(logInButton)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

