//
//  File.swift
//  LastProj
//
//  Created by Juliet DeNapoli on 12/4/20.
//

import Foundation

struct ShowsDataResponse: Codable {
    var data: [Show]
}

struct Show: Codable {
    var id: Int
    var name: String
    var description: String?
  //  var photo: String?
}
struct Response<T: Codable>: Codable {

    let data: T
    let success: Bool
    
}
//
//class Showes: Codable {
//    var id: Int
//    var title: String
//    var summary: String?
//
//    init(title: String, summary: String?, id: Int){
//        self.title = title
//        self.summary = summary
//        self.id = id
//
//    }
//}
