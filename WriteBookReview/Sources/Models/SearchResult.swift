//
//  SearchResult.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/08.
//


import Foundation

// MARK: - Result
struct SearchResult: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let author, discount, publisher, pubdate: String
    let isbn, itemDescription: String

    enum CodingKeys: String, CodingKey {
        case title, link, image, author, discount, publisher, pubdate, isbn
        case itemDescription = "description"
    }
}
