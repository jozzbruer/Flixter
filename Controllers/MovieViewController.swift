//
//  ViewController.swift
//  Flixter
//
//  Created by jquince on 2/12/22.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    var moviesArr = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Get the data from the movie database API
        getAPIdata()
        
    }
    
    func getAPIdata(){
        API.getMovies(){(movies) in
            guard let movies = movies else{
                return
            }
            self.moviesArr = movies
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = tableView.dequeueReusableCell(withIdentifier: "Movie Cell") as! MovieCellTableViewCell
        let base_url = "https://image.tmdb.org/t/p/original"
        let movie = moviesArr[indexPath.row]
        let title = movie["title"] as! String
        let desc = movie["overview"] as! String
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: base_url + posterPath)
        
        cells.titleLabel.text = title
        cells.descriptionLabel.text = desc
        cells.posterView.af.setImage(withURL: posterUrl!)
        return cells
    }
    
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Find the selected table view i pressed
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = moviesArr[indexPath.row]
        
        //Pass the selected movie for to the destination view controller
        let movieDetailsViewController = segue.destination as! MovieDetailsViewController
        movieDetailsViewController.movie = movie
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
   

}

