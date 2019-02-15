//
//  Item.swift
//  PlaySportsTest
//
//  Created by R K Marri on 14/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import Foundation

struct RawServerResponse: Decodable {
    let items: [RawItem]
}
//struct ResultInfo: Decodable {
//    let kind: String
//    let nextPageToken: String
//}
struct RawItem: Decodable {
    let snippet: Snippet
    let id: Identification
}
struct Identification: Codable {
    let videoId: String
}
struct Snippet: Decodable {
    let title: String
    let description: String
    let thumbnails: Thumbnails
}
struct Thumbnails: Decodable {
    let high: Thumbnail
    let medium: Thumbnail
}
struct Thumbnail: Decodable {
    let url: String
}

