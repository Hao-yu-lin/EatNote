//
//  EatNote.swift
//  EatNote
//
//  Created by Haoyu Lin on 2021/5/23.
//

import Foundation


class EatNote{
    var name: String
    var type: String
    var location: String
    var address: String
    var image: String
    var isVisited: Bool
    var phone: String
    var description: String
    var rating: String
   
    
    init(name: String, type: String, location: String, address: String, image: String, isVisited: Bool, phone: String, description: String, rating: String = "") {
        self.name = name
        self.type = type
        self.location = location
        self.address = address
        self.image = image
        self.isVisited = isVisited
        self.phone = phone
        self.description = description
        self.rating = rating
        

    }
    
    convenience init() {
        self.init(name: "", type: "", location: "", address: "", image: "", isVisited: false, phone: "", description: "")
    }
}

