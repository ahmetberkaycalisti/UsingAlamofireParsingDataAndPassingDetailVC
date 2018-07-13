//
//  Person.swift
//  Alamofire Server Data
//
//  Created by Ahmet Berkay CALISTI on 07/07/2018.
//  Copyright © 2018 Ahmet Berkay CALISTI. All rights reserved.
//

import Foundation

struct Person {
    
    private let homeworldLink: String
    
    // We have to make properties for each of them so to go throught the entire process again
    let birthYear:      String
    let eyeColor:       String
    let gender:         String
    let hairColor:      String
    let height:         String
    let mass:           String
    let name:           String
    let skinColor:      String
    
    // This one be initialized with JSON. Because this is still in json format
    // we have to make this available initializer. Because if for whatever reason we can;t get the data back then we just need to get rid of this person object.
    init? (json: JSON) {
        
        guard let birthYear      =   json["birth_year"] as? String,
        let eyeColor             =   json["eye_color"] as? String,
        let gender               =   json["gender"] as? String,
        let hairColor            =   json["hair_color"] as? String,
        let height               =   json["height"] as? String,
        let homeworldLink        =   json["homeworld"] as? String,
        let mass                 =   json["mass"] as? String,
        let name                 =   json["name"] as? String,
        let skinColor            =   json["skin_color"] as? String
            else {return nil}
        
        // We have to since all these are required with initialized each of them 
        self.homeworldLink =    homeworldLink
        self.birthYear =        birthYear
        self.eyeColor =         eyeColor
        self.gender =           gender
        self.hairColor =        hairColor
        self.height =           height
        self.mass =             mass
        self.name =             name
        self.skinColor =        skinColor
    
    }
    func homeworld(_ completion: @escaping(String) -> Void) {
        NetworkingService.shared.getHomeworld(homeworldLink: homeworldLink) { (homeworld) in
            completion(homeworld)
        }
    }
    
}
