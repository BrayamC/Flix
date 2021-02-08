//
//  MovieGridVideoViewController.swift
//  FlixBC
//
//  Created by Brayam Corral on 2/8/21.
//

import UIKit

class MovieGridVideoViewController: UIViewController {

    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(movie)
        print("*************")
        
        let movieID = movie["id"] as! Int
        print(movieID)
        
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
