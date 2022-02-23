//
//  API.swift
//  Flixter
//
//  Created by jquince on 2/21/22.
//

import Foundation

struct API{
    static func getMovies(_ link: String, completion: @escaping ([[String: Any]]?) -> Void){
        //let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=d443226de816e358594a7fa4c7384b2b")!
        let url = URL(string: link)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let finalData = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                 let movies = finalData["results"] as! [[String: Any]]
                
                 
                 return completion(movies)

             }
        }
        task.resume()
    }
}
