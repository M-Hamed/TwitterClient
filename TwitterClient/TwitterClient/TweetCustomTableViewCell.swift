//
//  TweetCustomTableViewCell.swift
//  TwitterClient
//
//  Created by mohamed hamed on 9/21/16.
//  Copyright © 2016 Mohamed Hamed. All rights reserved.
//

import UIKit

class TweetCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var TweetText: UITextView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var LikesCount: UILabel!
    @IBOutlet weak var RetweetsCount: UILabel!
    @IBOutlet weak var Date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
