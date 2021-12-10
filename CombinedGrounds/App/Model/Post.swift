//
//  Post.swift
//  CombinedGrounds
//
//  Created by Kenny Dubroff on 12/9/21.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    var title: String
    var body: String

    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
}


