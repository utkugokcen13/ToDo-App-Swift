//
//  ViewController.swift
//  ToDo App
//
//  Created by Utku Gökçen on 15.08.2022.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem = Item()
        newItem.title = "Utku"
        
        itemArray.append(newItem)
        
        //if let items = defaults.array(forKey: "TodoListArray") as? [String]{
        //  itemArray = items
        //}
        
    }
    
    // Table view data source methods
    
    // How many items in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Determining the data in the table view items
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
       
        cell.textLabel?.text = item.title
        
        if item.isChecked == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }

       return cell
    }
    
    
    // Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(itemArray[indexPath.row])
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].isChecked = !itemArray[indexPath.row].isChecked
        
        tableView.reloadData()
            
    }
    
    
    // Add new item ibaction
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print(textField.text!)
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            textField.placeholder = "Create new item"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    


}

