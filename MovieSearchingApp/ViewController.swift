//
//  ViewController.swift
//  MovieSearchingApp
//
//  Created by Pyi Theim Kyaw on 10/20/18.
//  Copyright © 2018 Pyi Theim Kyaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cowImage: UIImageView!
    
    @IBOutlet weak var TakeMeThereBtn: UIButton!
    
    @IBOutlet weak var aboutBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCowImage()
        TakeMeThereBtn.layer.cornerRadius = 10
        aboutBtn.layer.cornerRadius = 10
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initCowImage() {
        cowImage.layer.cornerRadius = cowImage.frame.size.height/2
        cowImage.layer.borderWidth = 1.0
        cowImage.layer.masksToBounds = false
        cowImage.layer.borderColor = UIColor.orange.cgColor
        cowImage.clipsToBounds = true
    }


}

