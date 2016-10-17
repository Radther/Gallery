//
//  ArtLoader.swift
//  Gallery
//
//  Created by Tom Sinlgeton on 17/10/2016.
//  Copyright © 2016 Tom Sinlgeton. All rights reserved.
//

import UIKit

public class ArtLoader {
    
    let url: URL
    let completion: (ImageResult) -> ()
    var task: URLSessionDataTask?
    
    init(url: URL, completion: @escaping (ImageResult) -> ()) {
        self.url = url
        self.completion = completion
    }
    
    public func run() {
        guard let cacheFolder = Gallery.galleryCacheFolder else {
            fatalError("Don't forget to setup Gallery!")
        }
        let fileName = url.absoluteString.replacingOccurrences(of: "/", with: "")
        let localUrl = cacheFolder.appendingPathComponent("\(fileName)")
        
        if FileManager.default.fileExists(atPath: localUrl.path),
            let imageData = FileManager.default.contents(atPath: localUrl.path),
            let image = UIImage(data: imageData) {
            completion(.success(image))
            print("Got from Cache")
            return
        }
        
        let request = URLRequest(url: url)
        task = URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            guard error == nil else {
                self.completion(.failure(error!))
                return
            }
            
            guard let data = data,
                let image = UIImage(data: data) else {
                    self.completion(.failure(ImageLoadError.urlNotImageLink))
                    return
            }
            
            self.completion(.success(image))
            
            let imageData = UIImagePNGRepresentation(image)
            FileManager.default.createFile(atPath: localUrl.path, contents: imageData, attributes: nil)
            print(FileManager.default.fileExists(atPath: localUrl.path))
        })
        
        task?.resume()
    }
    
    public func cancel() {
        task?.cancel()
    }
}
