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
        
//        box.layer.borderWidth = 0.5
//        box.layer.cornerRadius = 5
//        box.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
//        box.layer.masksToBounds = false
//        box.layer.shadowColor = UIColor.black.cgColor
//        box.layer.shadowOffset = CGSize(width: 1, height: 2)
//        box.layer.shadowOpacity = 0.07
//        box.layer.shadowRadius = 1.5
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
