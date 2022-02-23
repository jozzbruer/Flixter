//
//  MovieDetailsViewController.swift
//  Flixter
//
//  Created by jquince on 2/22/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    var movie: [String: Any]!
    
    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = movie["title"] as? String
        dateLabel.text = movie["release_date"] as? String
        descriptionLabel.text = movie["overview"] as? String
        
        let base_url = "https://image.tmdb.org/t/p/original"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: base_url + posterPath)
        profile.af.setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: base_url + backdropPath )
        
        
        backdrop.af.setImage(withURL: backdropUrl!)
    }
        
    
    

}
