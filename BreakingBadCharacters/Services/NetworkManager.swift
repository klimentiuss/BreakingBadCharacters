//
//  NetworkManager.swift
//  BreakingBadCharacters
//
//  Created by Daniil Klimenko on 24.06.2022.
//

import Foundation
import UIKit


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCharacter(from url: String?, with complition: @escaping ([Character]) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let character = try JSONDecoder().decode([Character].self, from: data)
                
                DispatchQueue.main.async {
                    complition(character)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchQuote(from url: String?, with complition: @escaping ([Quote]) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let quote = try JSONDecoder().decode([Quote].self, from: data)
                
                DispatchQueue.main.async {
                    complition(quote)
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
}


class ImageManager {
    
    static let shared = ImageManager()
    var imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    func fetchImage(from url: String?, with complition: @escaping (UIImage?) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString){
            complition(cachedImage)
        } else {
            guard let imageData = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: imageData) else { return }
            self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            
            DispatchQueue.main.async {
                complition(image)
            }
        }
    }
}
