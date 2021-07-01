//
//  CategoryScreenViewController.swift
//  Expense Tracker
//
//  Created by Mustafa Gokturk Yandim on 24.06.2021.
//

import UIKit
import RealmSwift

class CategoryScreenViewController: UIViewController, UITableViewDataSource{
    

    @IBOutlet weak var categorySearchBar: UISearchBar!
    @IBOutlet weak var categoryTableView: UITableView!
    
    let realm = try! Realm()
    
    var categories_data = [CategoryCellStruct?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categorySearchBar.delegate = self
        categorySearchBar.layer.cornerRadius = 10
        
        categoryTableView.dataSource = self
        categoryTableView.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellReuseIdentifier: "reusableCategoryCell")
        
        // Created a tap gesture recognizer that closes keyboard when tapped to anywhere in screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        categoryTableView.reloadData()
    }
    
    
    // Function for segue unwinding
    @IBAction func unwindToCategoryScreen (_ sender:UIStoryboardSegue){}
    
}


// MARK: - Table view functions
extension CategoryScreenViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories_data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCategoryCell", for: indexPath) as! CategoriesCell
        
        if let new = categories_data[indexPath.row]{
            cell.categoryIcon.image = new.icon
            cell.categoryIcon.tintColor = new.iconColor
            cell.categoryName.text = new.name
        }
        
        return cell
    }
}
    

// MARK: - Realm Methods

extension CategoryScreenViewController {

    func saveToRealm(){
        do {
            try realm.write(){
                
            }
        } catch {
            print("Error saving the new category to realm \(error)")
        }

    }

    func loadFromRealm(){
        
        
//        let realmSelectedYear = realm.objects(realmYears.self)
    
    }
}



// MARK: - searchBar delegate methods

extension CategoryScreenViewController: UISearchBarDelegate {
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        categorySearchBar.endEditing(true)
    }

}
