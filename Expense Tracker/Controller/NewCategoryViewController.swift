//
//  NewCategoryViewController.swift
//  Expense Tracker
//
//  Created by Mustafa Gokturk Yandim on 24.06.2021.
//

import UIKit

class NewCategoryViewController: UIViewController {
    
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var iconPicker: UIPickerView!
    
    let categoryIconOptions = [UIImage(systemName: "house"),UIImage(systemName: "cart"),UIImage(systemName: "car")]
    let colorOptions = [#colorLiteral(red: 1, green: 0.1575154751, blue: 0.09252645495, alpha: 1),#colorLiteral(red: 0.9060678193, green: 0.5472775452, blue: 0.1021530201, alpha: 1),#colorLiteral(red: 0.9060678193, green: 0.8200351492, blue: 0.1051342711, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.1319109127, green: 0.2682498543, blue: 0.931551153, alpha: 1),#colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1),#colorLiteral(red: 0.5083127782, green: 0.2950246173, blue: 0.8214778707, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    
    var selectedColor = #colorLiteral(red: 1, green: 0.1575154751, blue: 0.09252645495, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconPicker.dataSource = self
        iconPicker.delegate = self
        
        categoryNameTextField.delegate = self
        
        // Created a tap gesture recognizer that closes keyboard when tapped to anywhere in screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // SEGUE PREPERATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destinationVC = segue.destination as? CategoryScreenViewController{
            if (categoryNameTextField.text != ""){  // correct inputs
                
                let selectedIcon = categoryIconOptions[iconPicker.selectedRow(inComponent: 0)]

                // Create a new income/expense cell
                let cellToBeAdded = CategoryCellStruct(icon: selectedIcon!, iconColor: selectedColor, name: categoryNameTextField.text!)

                destinationVC.categories_data.append(cellToBeAdded)

                
            } else { // Wrong or missing inputs
                let alert = UIAlertController(title: "Error", message: "Please enter a new category name ", preferredStyle: .alert)
                
                let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(actionCancel)
                
                present(alert, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - PickerView functions

extension NewCategoryViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    // this will control how many options will be visible in picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return categoryIconOptions.count
        } else {
            return colorOptions.count
        }
    }
    
    // this will return the last row that was selected by user
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 1) {
            selectedColor = colorOptions[row]
        }
        pickerView.reloadComponent(0)
    }
    
    // number of columns in the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // defines the height of the row
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    // sets UIViews for the rows
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        // https://www.youtube.com/watch?v=6Qd3CdWYeJ8  watch for better explanation
        
        if (component == 0) {
            let customPickerCellWidth = 50
            let customPickerCellHeight = 50
            
            // create an empty view
            let view = UIView(frame: CGRect(x: 0, y: 0, width: customPickerCellWidth, height: customPickerCellHeight))
            
            // create an imageView and add it to the view
            let image = UIImageView(frame: CGRect(x: 0, y: 5, width: view.frame.width, height: view.frame.height))
            image.image = categoryIconOptions[row]
            image.tintColor = selectedColor
            
            view.addSubview(image) // add the label in the view as subview
            return view
            
        } else {
            let customPickerCellWidth = 30
            let customPickerCellHeight = 30
            
            // create an empty view
            let view = UIView(frame: CGRect(x: 0, y: 0, width: customPickerCellWidth, height: customPickerCellHeight))
            
            selectedColor = colorOptions[row]
            view.backgroundColor = selectedColor
            
            return view
        }
    }
}

// MARK: - TextField delegate methods

extension NewCategoryViewController: UITextFieldDelegate {
    
    // close the keyboard when return pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        categoryNameTextField.resignFirstResponder()
        return true
    }
}
