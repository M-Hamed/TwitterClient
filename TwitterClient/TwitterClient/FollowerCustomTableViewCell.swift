//
//  followerCustomTableViewCell.swift
//  TwitterClient
//
//  Created by mohamed hamed on 9/20/16.
//  Copyright © 2016 Mohamed Hamed. All rights reserved.
//

import UIKit

class FollowerCustomTableViewCell: UITableViewCell {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var HandleLabel: UILabel!
    @IBOutlet weak var BioTextView: UITextView!
    @IBOutlet weak var ProfileImage: UIImageView!

     
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
   
}
