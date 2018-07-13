//
//  GetPeopleResponse.swift
//  Alamofire Server Data
//
//  Created by Ahmet Berkay CALISTI on 07/07/2018.
//  Copyright © 2018 Ahmet Berkay CALISTI. All rights reserved.
//

import Foundation



struct GetPeopleResponse {
    // For our get people response will have this people property, which will be of type array of person's
    let people: [Person]
    
    // We're gonna initialize this with json and then it's gonna throw. The reason for that is a better error handling this is how I usually do it you don't have to do this one. It's just how I usually do
    init(json: JSON) throws{
    
        // so when we et this json we need to access the results. So first thing that we need to parse out our results
        guard let results = json["results"] as? [JSON] else { throw NetworkingError.badNetworkingStuff }
        
        // I'm going to use a map function. It's pretty much like a for in loop but it's little bit cleaner and faster
        // Remember that w're doing a foreach in results and each object in results is json and we're able o initialize a person with json
        // So Shorthand for be dollar sign zero and all that means is that whatever type of object each of these results are which we know to be json then we;re just gonna pass that in there
        let people = results.map{ Person(json: $0)}.flatMap{ $0 }
        self.people = people
        
        // So now we set up our data model to handle the response 
    }
}
