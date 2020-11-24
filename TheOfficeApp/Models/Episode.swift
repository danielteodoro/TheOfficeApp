//
//  Episode.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 23/11/20.
//

import Foundation

struct EpisodeResponse: Decodable {
    let data: [Episode]
}

struct Episode: Decodable {
    let _id: String
    let title: String
    let description: String
    let airDate: String
}
