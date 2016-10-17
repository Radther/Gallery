//
//  UIImageView+Gallery.swift
//  Gallery
//
//  Created by Tom Sinlgeton on 14/10/2016.
//  Copyright © 2016 Tom Sinlgeton. All rights reserved.
//

import UIKit

extension UIImageView {
    public func loadGalleryImage(from url: URL, placeHolder: UIImage? = nil) -> ArtLoader {
        return Gallery.getImage(for: url) { (result) in
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
        }
    }
}
