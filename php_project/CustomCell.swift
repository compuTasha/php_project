//
//  CustomCell.swift
//  php_project
//
//  Created by minjuKang on 2020/06/18.
//  Copyright © 2020 Mijoo Kim. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var box: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
