//
//  NetworkManager.swift
//  TestApp
//
//  Created by César Gerace on 29/07/2022.
//

import Foundation

struct ResponseArray: Decodable {
    let hits: [ImageItem]
}

class NetworkManager{
    
    private func getBaseUrlWithKey() -> String? {
        guard let path = Bundle.main.path(forResource: "PrivateInformation", ofType: "plist") else {
            return nil
        }

        let url = URL(fileURLWithPath: path)

        let data = try! Data(contentsOf: url)

        guard let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String:String],
              let baseUrl = plist["BaseUrl"],
              let privateKey = plist["PrivateKey"]
        else {
            return nil
        }
        
        let urlWithKey = "\(baseUrl)/?key=\(privateKey)"
        return urlWithKey
    }
    
    func loadData(searchTerm: String, completion:@escaping (ResponseArray?) -> ()) {
        
        guard let baseUrlWithKey = getBaseUrlWithKey() else {
            completion(nil)
            return
        }
        
        guard let url = URL(string: "\(baseUrlWithKey)&q=\(searchTerm)&image_type=photo&pretty=true") else {
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

