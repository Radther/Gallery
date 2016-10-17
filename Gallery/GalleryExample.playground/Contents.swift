//: Playground - noun: a place where people can play

import UIKit
import Gallery
import PlaygroundSupport

let imageView = UIImageView()

let url = URL(string: "https://myanimelist.cdn-dena.com/images/anime/11/75274.jpg")!

Gallery.setup()

Gallery.getImage(for: url) { (result) in
    switch result {
    case let .success(image):
        imageView.image = image
        print(image)
        print("Got Image")
    default:
        print("Failed")
    }
}

PlaygroundPage.current.liveView = imageView

//PlaygroundPage.current.finishExecution()
