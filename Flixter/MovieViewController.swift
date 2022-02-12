//
//  ViewController.swift
//  Flixter
//
//  Created by jquince on 2/12/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    var movies = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Get the data from the movie database API
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=d443226de816e358594a7fa4c7384b2b")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let finalData = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                 self.movies = finalData["results"] as! [[String: Any]]
                 self.tableView.reloadData()
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = UITableViewCell()
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        
        cells.textLabel?.text = title
        
        return cells
    }

}

