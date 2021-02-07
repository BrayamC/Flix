//
//  MovieGridViewController.swift
//  FlixBC
//
//  Created by Brayam Corral on 2/5/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var movies = [[String:Any]]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Layout of grid
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = -15
        
        // width of phone
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 1.6)
        
            // Do any additional setup after loading the view.
            let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=8f46543c2255c7b5ee4ec102a5005c02")!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
               // This will run when the network request returns
               if let error = error {
                  print(error.localizedDescription)
               } else if let data = data {
                  let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                self.collectionView.reloadData()
                //print(self.movies)
               }
            }
            task.resume()
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
        
    }

    
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     // cell that was tapped on
     let cell = sender as! UICollectionViewCell
    
    // Get specific cell index that was clicked on
    let indexPath = collectionView.indexPath(for: cell)!
    
    // get movie that was tapped
    let movieTapped = movies[indexPath.row]
    
    // set movies dictionary of other class to the movie that was clicked on
    let detailsViewController = segue.destination as! MovieGridDetailViewController
    detailsViewController.movie = movieTapped
    
    // https://www.youtube.com/watch?v=WqZhXfWe_oY
     
 }

}
