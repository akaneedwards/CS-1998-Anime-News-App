//
//  NetworkManager.swift
//  LastProj
//
//  Created by Juliet DeNapoli on 12/4/20.
//

import Foundation
import Alamofire

class NetworkManager {


    private static let host = "https://animenewsapp.herokuapp.com/api"
    
    // get all shows
    static func getShows(completion: @escaping ([Show]) -> Void) {
        let endpoint = "\(host)/animes/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//                print(data)
                if let showData = try? jsonDecoder.decode(ShowsDataResponse.self, from: data) {
                        let shows = showData.data
                        completion(shows)
//                        print(shows)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func addShow(id: Int, name: String, completion: @escaping (Show) -> Void) {
        let parameters: [String: Any] = [
            "id": id,
            "name": name
        ]
        AF.request(host, method: .post, parameters: parameters ).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let showData = try? jsonDecoder.decode(Response<Show>.self, from: data) {
                    let shows = showData.data
                    completion(shows)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // get a show
//    static func getShow(id: Int, completion: @escaping (Show) -> Void) {
//        let parameters: [String: Any] = [
//            "id": id
//        ]
//        let endpoint = "\(host)/animes/"
//        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
//            switch response.result {
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//                
//                if let showData = try? jsonDecoder.decode(Show.self, from: data) {
//                        let show = showData
//                        completion(show)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    
}
