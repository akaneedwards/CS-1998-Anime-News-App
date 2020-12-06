//
//  File.swift
//  LastProj
//
//  Created by Juliet DeNapoli on 12/4/20.
//

import Foundation

struct ShowsDataResponse: Codable {
    var shows: [Show]
}

//struct Show: Codable {
//    var title: String
//    var summary: String?
//    var photo: String?
//}


class Show: Codable {
    var title: String
    var summary: String?
    var photo: String?
    
    init(title: String, summary: String?, photo: String?){
        self.title = title
        self.summary = summary
        self.photo = photo
    }
}
