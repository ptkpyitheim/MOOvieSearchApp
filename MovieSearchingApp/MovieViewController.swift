//
//  MovieViewController.swift
//  MovieSearchingApp
//
//  Created by Pyi Theim Kyaw on 10/20/18.
//  Copyright © 2018 Pyi Theim Kyaw. All rights reserved.
//


//API Key website
//https://api.themoviedb.org/3/search/movie?api_key=24eeffd4c92654f6ca7d47d410cbfac3&query=Jack+Reacher



import UIKit

class MovieViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    var myData:[Movie] = []
    
    var cacheMyImg: [UIImage] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBtn.layer.cornerRadius = 10
        
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
        self.spinner.hidesWhenStopped = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "theCell", for: indexPath) as! CollectionViewCell
    
        if(indexPath.row >= cacheMyImg.count) {
            cell.movieImg?.image = UIImage(named: "404notfound")!
            print("Image not found!")
        }
        else {
            cell.movieImg?.image = cacheMyImg[indexPath.row]
        }
        
        cell.movieName!.text =
            myData[indexPath.row].title
        
        return cell
    }
    
    
    
    
    func getMyData(name: String) {
        
        let toArray = name.components(separatedBy: " ")
        let backToString = toArray.joined(separator: "+")
        
        self.spinner.startAnimating()
        
        if(!name.isEmpty) {
           
            DispatchQueue.global().async {
                self.myData.removeAll()
                
                let apiURL = "https://api.themoviedb.org/3/search/movie?api_key=24eeffd4c92654f6ca7d47d410cbfac3&query=" + backToString
                
                let databaseURL = URL(string: apiURL)
                
                let tryData = try! Data(contentsOf: databaseURL!)
                
                let tryResults = try! JSONDecoder().decode(APIResults.self, from: tryData)
                
                self.myData = tryResults.results
                
                self.cacheImage()
                
                print("I have this much data: \(self.myData.count)")
                for myTitle in self.myData {
                    print(myTitle.title)
                }
                
                DispatchQueue.main.async {
                    self.movieCollectionView.reloadData()
                    self.spinner.stopAnimating()
                }
                
            }
        }
            
        else
        {
            return
        }
    }
    
    
    @IBAction func searchMovieBtn(_ sender: Any) {
        let userSearchQuery = searchTextField.text!

        getMyData(name: userSearchQuery)

    }
    
    
    func cacheImage(){
        
        cacheMyImg.removeAll()
        
        for theMovie in myData {
            
            if (theMovie.poster_path == nil) {
                cacheMyImg.append(UIImage(named: "404notfound")!)
                print("Image not found here")
            }
            
            else {
                print(theMovie.poster_path!)
                
                let url = URL(string: "https://image.tmdb.org/t/p/w500/" + theMovie.poster_path!)
                
                let data = try? Data(contentsOf: url!)
                
                if (data == nil) {
                    cacheMyImg.append(UIImage(named: "404notfound")!)
                    print("Data not found.")
                }
                
                else {
                    let image = UIImage(data: data!)
                    cacheMyImg.append(image!)
                }
            }
        }
    }

    
    
    var segueName: String?
    var segueImg: UIImage?
    var segueDescription: String?
    var segueDateReleased: String?
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("It is segueing to Detail VC")
        
        segueName = myData[indexPath.row].title
        segueImg = cacheMyImg[indexPath.row]
        segueDescription = myData[indexPath.row].overview
        segueDateReleased = myData[indexPath.row].release_date

        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailSegue") {
            
            let newView = segue.destination as? DetailViewController
            
            //let ratingString = "\(segueRating)"
            
            newView?.movieName = self.segueName!
            newView?.image = self.segueImg!
            newView?.movieDescription = self.segueDescription!
            newView?.dateReleased = self.segueDateReleased!
        }
            
        else {
            print("Detail Segueing not performed correctly!")
        }
        
    }
    
    
}
