//
//  Person.swift
//  Project10
//
//  Created by John Doll on 5/20/22.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
