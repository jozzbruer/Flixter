//
//  MovieGridViewController.swift
//  Flixter
//
//  Created by jquince on 2/22/22.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var link = "https://api.themoviedb.org/3/movie/634649/similar?api_key=d443226de816e358594a7fa4c7384b2b"
    
    var moviesArr = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
        getAPIdata()
    }
    
    func getAPIdata(){
        API.getMovies(link){(movies) in
            guard let movies = movies else{
                return
            }
            print(movies)
            self.moviesArr = movies
            self.collectionView.reloadData()
    
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCollectionViewCell
        
        let base_url = "https://image.tmdb.org/t/p/original"
        let movie = moviesArr[indexPath.item]
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: base_url + posterPath)
        cells.posterView.af.setImage(withURL: posterUrl!)
        
        return cells
    }
  

}
