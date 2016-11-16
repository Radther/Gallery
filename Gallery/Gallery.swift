//
//  Gallery.swift
//  Gallery
//
//  Created by Tom Sinlgeton on 14/10/2016.
//  Copyright © 2016 Tom Sinlgeton. All rights reserved.
//

import UIKit

/// Image loading result enum
///
/// - success: success state
/// - failure: failure state
public enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

/// Custom Gallery errors
///
/// - urlNotImageLink: the url is not an image error
public enum ImageLoadError: Error {
    case urlNotImageLink
}

/// Gallery class
public class Gallery {
    
    // MARK: - varibles
    public static var galleryFolderName: String = "Gallery"
    static var galleryCacheFolder: URL?
    static var placeHolderImage: UIImage?
    
    /// Setup method. Must be called before Gallery can be used
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
    
    /// Gets an image
    ///
    /// - Parameters:
    ///   - url: the url of the image
    ///   - startImmediately: whether the image loading should begin imediatly (if false the loading can be started through the returned artloader object
    ///   - completion: closure that is called with an image result
    /// - Returns: Artloader object
    public static func getImage(for url: URL, startImmediately: Bool = true, completion: @escaping (ImageResult) -> ()) -> ArtLoader {
        let loader = ArtLoader(url: url, completion: completion)
        if startImmediately {
            loader.run()
        }
        return loader
    }
}

