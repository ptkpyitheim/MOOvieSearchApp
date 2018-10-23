//
//  FavViewController.swift
//  MovieSearchingApp
//
//  Created by Pyi Theim Kyaw on 10/22/18.
//  Copyright © 2018 Pyi Theim Kyaw. All rights reserved.
//

import UIKit

class FavViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var favTableView: UITableView!
    
    
    var favArray:[String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        favTableView.dataSource = self
        favTableView.delegate = self
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

        favArray = UserDefaults.standard.array(forKey: "mySpecialKey") as! [String]
        self.favTableView.reloadData()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        //let myCell = tableView.dequeueReusableCell(withIdentifier: "theCell")! as UITableViewCell
 
        myCell.textLabel!.text = favArray[indexPath.row]
        
        return myCell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            favArray.remove(at: indexPath.row)
            
            UserDefaults.standard.set(favArray, forKey: "mySpecialKey")
            
            tableView.reloadData()
            
        }
    }
    
    //Creative portion _ Clear ALL button with Alert
    @IBAction func clear(_ sender: Any) {
        
        if(favArray.count == 0) {
            createAlert(title: "No favorites yet", message: "Add more movies to your favorite list!")
        }
        
        else {
            let alert = UIAlertController(title: "Delete?", message: "Are you sure you want to delete your favorites?", preferredStyle: UIAlertControllerStyle.alert)
            
            let action1 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                print("Cancel. Don't delete")
            })
            
            let action2 = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                print("List deleted")
                
                self.deleteFavList()
            })
            
            alert.addAction(action1)
            alert.addAction(action2)
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    //Delete user's favorite list
    func deleteFavList() {
        self.favArray = []
        UserDefaults.standard.set(self.favArray, forKey: "mySpecialKey")
        self.favTableView.reloadData()
    }
    
    
    func createAlert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("User has seen this alert")
        })
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
