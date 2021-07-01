//
//  IncomeExpenseCell.swift
//  Expense Tracker
//
//  Created by Mustafa Gokturk Yandim on 22.06.2021.
//

import UIKit

class IncomeExpenseCell: UITableViewCell {
    
   
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var summaryTextField: UILabel!
    @IBOutlet weak var date_time: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var icon: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
