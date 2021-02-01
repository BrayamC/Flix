//
//  MoviesViewController.swift
//  FlixBC
//
//  Created by Brayam Corral on 1/30/21.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var tableView: UITableView!
    
    // Array of dictionaries
    var movies = [[String:Any]]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // calls tableView functions
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            // updates yable view with data stores in movies
            self.tableView.reloadData()
           }
        }
        task.resume()
    }
    
    // functions for tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // if a cell is off screen, recycle that cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        // get individual movie API content and store in movie variable
        let movie = movies[indexPath.row]
        // stores title of movie
        let title = movie["title"] as! String
        // stores description of movie
        let synopsis = movie["overview"] as! String
        
        //print(movie)
        
        // Update labels on app
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.PosterView.af_setImage(withURL: posterUrl!)
        return cell
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
