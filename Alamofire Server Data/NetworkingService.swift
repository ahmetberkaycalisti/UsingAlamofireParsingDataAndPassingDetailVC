//
//  NetworkingService.swift
//  Alamofire Server Data
//
//  Created by Ahmet Berkay CALISTI on 07/07/2018.
//  Copyright © 2018 Ahmet Berkay CALISTI. All rights reserved.
//

import Foundation
import Alamofire

typealias JSON = [String: Any]

class NetworkingService {
    
    // we gonna create a singleton, so that we can always use the same Alamofire service
    // we'll do a static this means that it will allow us to access this this property from without initializing the networking service
    static let shared = NetworkingService()
    private init() {}   // we have to sure that can't initialize the networking service, so we will do private init. Access control set to private. So only we can initialize a networking service inside of the actual service
    
    func getPeople(success successBlock: @escaping (GetPeopleResponse) -> Void) {
        
        Alamofire.request("http://swapi.co/api/people/").responseJSON { response in 
            guard let json = response.result.value as? JSON else { return }
            do {
                let getPeopleResponse =  try GetPeopleResponse(json: json)
                successBlock(getPeopleResponse)
            } catch {
                print(error)
            }
        }
    }
    
    func getHomeworld(homeworldLink: String, completion: @escaping (String) -> Void) {
        Alamofire.request(homeworldLink).responseJSON { (response) in
            guard let json = response.result.value as? JSON,
            let name = json["name"] as? String
                else {return}
            completion(name)
        }
    }
}
