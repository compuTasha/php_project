//
//  CustomCell.swift
//  php_project
//
//  Created by minjuKang on 2020/06/14.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var reviewTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
