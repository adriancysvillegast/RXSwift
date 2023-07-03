//
//  UIImage+Extension.swift
//  RickAndMorty
//
//  Created by Adriancys Jesus Villegas Toro on 8/6/23.
//

import UIKit

extension UIImageView {
    func loadImage(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
