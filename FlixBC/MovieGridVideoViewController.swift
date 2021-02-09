//
//  MovieGridVideoViewController.swift
//  FlixBC
//
//  Created by Brayam Corral on 2/8/21.
//

import UIKit
import youtube_ios_player_helper

class MovieGridVideoViewController: UIViewController {

    var movie: [String:Any]!
    var videos = [[String:Any]]()
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var videoKey:String = ""
        // Do any additional setup after loading the view.
        let APIUrl1 = "https://api.themoviedb.org/3/movie/"
        let movieID = movie["id"] as! Int
        let APIUrl2 = "/videos?api_key=8f46543c2255c7b5ee4ec102a5005c02"
        
        let APIUrlTotal = APIUrl1 + "\(movieID)" + APIUrl2
        //print(APIUrlTotal)
        
        let url = URL(string: APIUrlTotal)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            self.videos = dataDictionary["results"] as! [[String:Any]]
            
            videoKey = self.videos[0]["key"] as! String
            self.playerView.load(withVideoId: videoKey)
    
           }
        }
        task.resume()
    
    }

}
