//
//  ViewController.swift
//  GalleryExampleApp
//
//  Created by Tom Sinlgeton on 14/10/2016.
//  Copyright © 2016 Tom Sinlgeton. All rights reserved.
//

import UIKit
import Gallery

class ViewController: UIViewController {

    @IBOutlet var iv: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Gallery.setup()
        let url = URL(string: "https://myanimelist.cdn-dena.com/images/anime/11/75274.jpg")!
        let _ = iv.loadGalleryImage(from: url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

