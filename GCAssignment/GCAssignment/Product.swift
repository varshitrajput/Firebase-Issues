//
//  Product.swift
//  
//
//  Created by Duc Tran on 3/22/15.
//
//

import Foundation
import UIKit

public enum ProductRating
{
    case unrated
    case average
    case ok
    case good
    case brilliant
}

// Represents a generic product. Need an image named "default"

class Product
{
    var title: String
    var description: String
    var image: UIImage
    var rating: ProductRating
    
    init(titled: String, description: String, imageName: String)
    {
        self.title = titled
        self.description = description
        if let img = UIImage(named: imageName) {
            image = img
        } else {
            image = UIImage(named: "default")!
        }
        rating = .unrated
    }
}










