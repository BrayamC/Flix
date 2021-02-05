//
//  MovieDetailsViewController.swift
//  FlixBC
//
//  Created by Brayam Corral on 2/4/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        var baseUrl = "https://image.tmdb.org/t/p/w185"
        
        // set poster image
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        posterView.af_setImage(withURL: posterUrl!)
        
        // set backdrop image
        baseUrl = "https://image.tmdb.org/t/p/w780"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: baseUrl + backdropPath)
        backDropView.af_setImage(withURL: backdropUrl!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
