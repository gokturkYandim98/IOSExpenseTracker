//
//  NewCellViewController.swift
//  Expense Tracker
//
//  Created by Mustafa Gokturk Yandim on 23.06.2021.
//

import UIKit

class NewCellViewController: UIViewController {
    
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var iconPickerView: UIPickerView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var incomeExpenseSelector: UISegmentedControl!
    
    var cellToBeAdded: HomeCellStruct?
    
    let categories = ["Shopping","Car","Job","Travel"]
    var selectedPickerCategory = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton.clipsToBounds = true
        cancelButton.layer.cornerRadius = 10
        
        addButton.clipsToBounds = true
        addButton.layer.cornerRadius = 10
        
        iconPickerView.dataSource = self
        iconPickerView.delegate = self
        
        iconPickerView.clipsToBounds = true
        iconPickerView.layer.cornerRadius = 10
        
        descriptionTextField.delegate = self
        
        // Created a tap gesture recognizer that closes keyboard when tapped to anywhere in screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    
    // When users changes the Income/Expense selector update the amount textfield placeholder accordingly
    @IBAction func IncomeExpenseValueChanged(_ sender: Any) {
        amountTextField.placeholder = (incomeExpenseSelector.selectedSegmentIndex == 0) ? "Income amount" : "Expense amount"
        amountTextField.textColor = (incomeExpenseSelector.selectedSegmentIndex == 0) ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0.8307285501, green: 0.1118449276, blue: 0.1549252403, alpha: 1)
    }
    
    // Cancel button pressed, go back to the home page
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    // SEGUE PREPERATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destinationVC = segue.destination as? HomeScreenViewController{
            if (amountTextField.text != ""){  // correct inputs
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy HH:mm"
                let currentDateTime = formatter.string(from: date)
                
                // Check whether the user provided a description or not (if not: leave empty)
                let description = (descriptionTextField.text != "") ? descriptionTextField.text! : ""

                let sign = (incomeExpenseSelector.selectedSegmentIndex == 0) ? 1 : -1
                let signedAmount = Double(amountTextField.text!)! * Double(sign)

                // Create a new income/expense cell
                cellToBeAdded = HomeCellStruct(category: categories[selectedPickerCategory], summary: description , date_time: currentDateTime, value: signedAmount, icon: UIImageView(image: UIImage(named: "house")))
                
                destinationVC.cell_data.append(cellToBeAdded)
                
                if (incomeExpenseSelector.selectedSegmentIndex == 0) { // input in larger than 0 (income)
                    destinationVC.globalIncome += Double(amountTextField.text!)!
                } else { // input in smaller than 0 (expense)
                    destinationVC.globalExpense += Double(amountTextField.text!)!
                }
                
                
            } else { // Wrong or missing inputs
                let alert = UIAlertController(title: "Error", message: "Please enter description and amount ", preferredStyle: .alert)
                
                let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(actionCancel)
                
                present(alert, animated: true, completion: nil)
            }
        }
    }
}


// MARK: - PickerView functions

extension NewCellViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    // this will control how many options will be visible in picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    // this will return the last row that was selected by user
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPickerCategory = row
        print("\(row) and  \(categories[row])")
    }
    
    // this will decide how many columns will be available for picker
    // we returned 1 since we will only select one category
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //  to set the names of the rows/options
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let customPickerCellWidth = 150
        let customPickerCellHeight = 50
        
        // create an empty view
        let view = UIView(frame: CGRect(x: 0, y: 0, width: customPickerCellWidth, height: customPickerCellHeight))
        
        // Create an image view for the icon
        let icon = UIImageView(frame: CGRect(x: 0, y: 20, width: 30, height: 30))
        icon.image = UIImage(systemName: "house")
        icon.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        // create a label for the category name
        let label = UILabel(frame: CGRect(x: 50, y: 20, width: 120, height: 30))
        label.text = categories[row]

        view.addSubview(icon)
        view.addSubview(label)
        
        return view
    }
}


// MARK: - TextField delegate methods

extension NewCellViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        descriptionTextField.resignFirstResponder()
        return true
    }
}
