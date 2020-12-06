//
//  NetworkManager.swift
//  LastProj
//
//  Created by Juliet DeNapoli on 12/4/20.
//

import Foundation
import Alamofire

class NetworkManager {


    private static let host = "http://64.227.6.156/"
    
    // get all shows
    static func getShows(completion: @escaping ([Show]) -> Void) {
        let endpoint = "\(host)/animes/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let showData = try? jsonDecoder.decode(ShowsDataResponse.self, from: data) {
                        let shows = showData.shows
                        completion(shows)
                    

                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // get a show
    static func getShow(id: Int, completion: @escaping (Show) -> Void) {
        let parameters: [String: Any] = [
            "id": id
        ]
        let endpoint = "\(host)/eatery/"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let showData = try? jsonDecoder.decode(Show.self, from: data) {
                        let show = showData
                        completion(show)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
