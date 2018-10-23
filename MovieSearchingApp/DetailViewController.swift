//
//  DetailViewController.swift
//  MovieSearchingApp
//

//  Created by Pyi Theim Kyaw on 10/21/18.
//  Copyright © 2018 Pyi Theim Kyaw. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgDetailVC: UIImageView!
    
    @IBOutlet weak var nameDetailVC: UILabel!
    
    @IBOutlet weak var releaseDateDetailVC: UILabel!
    
    @IBOutlet weak var descriptionDetailVC: UITextView!
    
    @IBOutlet weak var addingtoFavorites: UIButton!
    
    var movieName: String!
    var image: UIImage!
    var dateReleased: String!
    var movieDescription: String!
    //var rating: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func initView() {
        addingtoFavorites.layer.cornerRadius = 10
        nameDetailVC.text! = movieName
        imgDetailVC.image = image
        releaseDateDetailVC.text! = dateReleased
        descriptionDetailVC.text! = movieDescription
        
        self.title = movieName
    }
    
    
    var favoritesArray: [String] = []
    
    
    @IBAction func addToFavs(_ sender: Any) {
        
        favoritesArray = UserDefaults.standard.array(forKey: "mySpecialKey") as? [String] ?? [String]()
        
        if(!favoritesArray.contains(movieName)) {
            
            favoritesArray.append(movieName)
            
            UserDefaults.standard.set(favoritesArray, forKey: "mySpecialKey")
            
            createAlert(title: "Added!", message: "This movie is in your Favorites list now")
            
            print("This is the movieName you're adding: \(movieName)")
            print("You have \(favoritesArray.count) items in your array.")
            print("Printing.. your favoriteArray: \(favoritesArray)")
        }
        else {
            
            createAlert(title: "This movie is already in your Favorites", message: "Go to Favorites tab to see!")
            
            print("CAN'T ADD NO MORE! The movie is already in the list.")
        }
       
        
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
