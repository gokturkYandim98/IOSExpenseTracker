//
//  CategoriesCell.swift
//  Expense Tracker
//
//  Created by Mustafa Gokturk Yandim on 24.06.2021.
//

import UIKit

class CategoriesCell: UITableViewCell {

    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
