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
    

    static func addShow(name: String, description: String, completion: @escaping (Show) -> Void) {
        let endpoint = "https://animenewsapp.herokuapp.com/api/animes/"
//        let headers: HTTPHeaders = [
//            "Content-Type":"application/json"
//                ]
        let parameters: [String: String] = [
            "name": name,
            "description": "test description"
        ]
        AF.request(endpoint, method: .post, parameters: parameters,  encoder: JSONParameterEncoder.default).validate().responseData { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let courseData = try? jsonDecoder.decode(Response<Show>.self, from: data) {
                    let classes = courseData.data
                    completion(classes)
                }
//
            case .failure(let error):
                print(error.localizedDescription)
//                print("here")
            }
        }
    }

    static func deleteShow(id:Int, completion: @escaping (Show) -> Void) {
        let endpoint = "\(host)/animes/\(id)/"
        AF.request(endpoint, method: .delete).validate().responseData { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let courseData = try? jsonDecoder.decode(Response<Show>.self, from: data) {
                    let classes = courseData.data
                    completion(classes)
                }
//
            case .failure(let error):
                print(error.localizedDescription)
//                print("here")
            }
        }
    }
    
}

