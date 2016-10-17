//
//  Gallery.swift
//  Gallery
//
//  Created by Tom Sinlgeton on 14/10/2016.
//  Copyright © 2016 Tom Sinlgeton. All rights reserved.
//

import UIKit

public enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

public enum ImageLoadError: Error {
    case urlNotImageLink
}

public class Gallery {
    
    public static var galleryFolderName: String = "Gallery"
    static var galleryCacheFolder: URL?
    static var placeHolderImage: UIImage?
    
    public static func setup() {
        let cacheUrl = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(galleryFolderName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: cacheUrl.path) {
            do {
                try FileManager.default.createDirectory(at: cacheUrl, withIntermediateDirectories: true, attributes: nil)
            } catch {
                fatalError("Failed to create cache folder")
            }
        }
        galleryCacheFolder = cacheUrl
        print("GalleryCacheFolder \(galleryCacheFolder)")
    }
    
    public static func getImage(for url: URL, startImmediately: Bool = true, completion: @escaping (ImageResult) -> ()) -> ArtLoader {
        let loader = ArtLoader(url: url, completion: completion)
        if startImmediately {
            loader.run()
        }
        return loader
    }
}

