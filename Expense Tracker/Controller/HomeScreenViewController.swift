//
//  HomeScreenViewController.swift
//  Expense Tracker
//
//  Created by Mustafa Gokturk Yandim on 22.06.2021.
//

import UIKit
import RealmSwift

class HomeScreenViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var summaryTextField: UILabel!
    @IBOutlet weak var date_time: UILabel!
    @IBOutlet weak var income: UILabel!
    @IBOutlet weak var expense: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    //var cell_data: Results<realmDays>?
    var cell_data = [HomeCellStruct?]()
    var globalIncome:Double = 0.0
    var globalExpense:Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.selectedIndex = 0
        tableView.dataSource = self
        tableView.register(UINib(nibName: "IncomeExpenseCell", bundle: nil), forCellReuseIdentifier: "reusableAmount")
        
        // Get the current date and adjust the date label
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        date_time.text =  dateFormatter.string(from: date)
        
        income.text = "0"
        expense.text = "0"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let totalSum = globalIncome + (globalExpense * -1)
        
        summaryTextField.text = "$ " + String(totalSum)
        summaryTextField.textColor = (totalSum >= 0) ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0.7647058964, green: 0.1595633471, blue: 0.1104390623, alpha: 1)
        tableView.reloadData()
    }
    
    // Function for segue unwinding
    @IBAction func unwindToHome (_ sender:UIStoryboardSegue){
    }

}


// MARK: Table view functions
extension HomeScreenViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cell_data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableAmount", for: indexPath) as! IncomeExpenseCell
        
        if let new = cell_data[indexPath.row]{
            
            cell.date_time.text = new.date_time
            cell.amount.text = String(new.value)
            cell.icon = new.icon
            cell.summaryTextField.text = new.summary
            cell.categoryName.text = new.category
            
            if (new.value > 0){
                cell.amount.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                income.text = String(globalIncome)
            } else {
                cell.amount.textColor = #colorLiteral(red: 0.7647058964, green: 0.1595633471, blue: 0.1104390623, alpha: 1)
                expense.text = String(globalExpense)
            }
        }
        return cell
    }
}


//// MARK: - REALM METHODS
//extension HomeScreenViewController {
//
//    func loadFromRealm(){
//        let tempYears = realm.objects(realmYears.self)
//    }
//
//}
