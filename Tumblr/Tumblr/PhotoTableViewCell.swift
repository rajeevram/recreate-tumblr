//
//  PhotoTableViewCell.swift
//  Tumblr
//
//  Created by Rajeev Ram on 8/20/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    // UI, UX Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
