//
//  NetworkManager.swift
//  TestApp
//
//  Created by César Gerace on 29/07/2022.
//

import Foundation

class NetworkManager{
    
    let key = "9640805-875402ac8aa2ff2ef7083dadf"
    
    func loadData(searchTerm: String, completion:@escaping (ResponseArray?) -> ()) {
        guard let url = URL(string: "https://pixabay.com/api/?key=\(key)&q=\(searchTerm)&image_type=photo&pretty=true") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                let imageItems = try? JSONDecoder().decode(ResponseArray.self, from: data) else {
                completion(nil)
                return
                
            }
            DispatchQueue.main.async {
                completion(imageItems)
            }
        }.resume()
        
    }
}

