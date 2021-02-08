//
//  MovieGridDetailViewController.swift
//  FlixBC
//
//  Created by Brayam Corral on 2/6/21.
//

import UIKit

class MovieGridDetailViewController: UIViewController {

    var movie: [String:Any]!
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(movie!)
        
        nameLabel.text = movie["title"] as? String
        nameLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        var baseUrl = "https://image.tmdb.org/t/p/w185"
        
        // set poster image
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        posterImage.af_setImage(withURL: posterUrl!)
        
        // set backdrop image
        baseUrl = "https://image.tmdb.org/t/p/w780"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: baseUrl + backdropPath)
        backImage.af_setImage(withURL: backdropUrl!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       // get movie that was tapped
       let movieTapped = movie
       
       // set movies dictionary of other class to the movie that was clicked on
       let detailsViewController = segue.destination as! MovieGridVideoViewController
       detailsViewController.movie = movieTapped
    }

}
