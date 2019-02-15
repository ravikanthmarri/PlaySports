//
//  ItemDetail.swift
//  PlaySportsTest
//
//  Created by R K Marri on 14/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import Foundation

struct RawItemDetailResponse: Decodable {
    let items: [ItemDetail]
}
struct ItemDetail: Decodable {
    let snippet: DetailSnippet
    let contentDetails: ContentDetails
}
struct DetailSnippet: Decodable {
    let title: String
    let description: String
    let publishedAt: String
    let thumbnails: Thumbnails
}

struct ContentDetails: Decodable {
    let duration: String
}

