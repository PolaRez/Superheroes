//
//  SuperheroesManager.swift
//  Superheroes
//
//  Created by Polina Reznik on 03/08/2021.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    let searchByNameUrl = "https://superheroapi.com/api/10225958171319137/search"
    private var images = NSCache<NSString, NSData>()
    
    private func request(_ name: String) -> String {
        let urlString = "\(searchByNameUrl)/\(name)"
        return urlString
    }
    
    func searchSuperheroBy(_ name: String, completion: @escaping ([Superhero]?,Error?) -> (Void)) {
        let urlString = request(name)
        guard let url = URL(string: urlString) else {
            completion(nil, nil)
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let response = try JSONDecoder().decode(SuperheroModel.self, from: data)
                completion(response.results, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func image(_ superhero: Superhero, completion: @escaping (Data?, Error?) -> (Void)) {
        guard let url = URL(string: superhero.image.url) else {
            completion(nil, nil)
            return
        }
        
        // image from cache
        if let imageData = images.object(forKey: url.absoluteString as NSString) {
            completion(imageData as Data,nil)
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.downloadTask(with: url) { localUrl, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let localUrl = localUrl else {
                completion(nil, error)
                return
            }
            do {
                let data = try Data(contentsOf: localUrl)
                self.images.setObject(data as NSData, forKey: localUrl.absoluteString as NSString)
                completion(data, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
