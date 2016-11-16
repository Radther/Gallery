//
//  UIImageView+Gallery.swift
//  Gallery
//
//  Created by Tom Sinlgeton on 14/10/2016.
//  Copyright © 2016 Tom Sinlgeton. All rights reserved.
//

import UIKit

// MARK: - UIImageView extension to provide Gallery Support
extension UIImageView {
    
    /// Loads an image straight in to the Image View
    ///
    /// - Parameters:
    ///   - url: the url of the image
    ///   - placeHolder: a place holder image that can be used
    /// - Returns: an ArtLoader object
    public func loadGalleryImage(from url: URL, placeHolder: UIImage? = nil) -> ArtLoader {
        return loadGalleryImage(from: url, placeHolder: placeHolder, completion: nil)
    }
    
    /// Loads an image straight in to the Image View
    ///
    /// - Parameters:
    ///   - url: the url of the image
    ///   - placeHolder: a place holder image
    ///   - completion: completetion method to be executed once the fetch has finished
    /// - Returns: an ArtLoader Object
    public func loadGalleryImage(from url: URL, placeHolder: UIImage? = nil, completion: (() -> ())? = nil) -> ArtLoader {
        self.image = placeHolder
        return Gallery.getImage(for: url) { (result) in
            DispatchQueue.main.async {
                switch result {
                case let .success(image):
                    self.image = image
                case .failure(_):
                    if let placeHolder = placeHolder {
                        self.image = placeHolder
                    } else {
                        self.image = Gallery.placeHolderImage
                    }
                    break
                }
                completion?()
            }
        }
    }
}
