//
//  BookModel.swift
//  DemoTwoSwiftUI
//
//  Created by RajayGoms on 5/29/25.
//

import Foundation

// MARK: - Welcome
struct CharacterModel: Decodable, Identifiable {
    //let info: Info?
    let data: [CharacterDatum]?
    var id = UUID()
    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - Datum
struct CharacterDatum: Decodable {
    let ids: Int?
    let films: [String]?
    let tvShows, videoGames: [String]?
    let sourceUrl: String?
    let name: String?
    let imageUrl: String?
    let createdAt, updatedAt: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case films
        case tvShows, videoGames
        case sourceUrl
        case name
        case imageUrl
        case createdAt, updatedAt
        case url
        case ids = "_id"
    }
}

// MARK: - Info
struct Info: Decodable {
    let count: Int?
    let previousPage: Int?
    let nextPage: String?
}


// MARK: - Welcome
struct BookModel: Decodable, Identifiable {
    let data: [BookDatum]
    var id = UUID()
    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - Datum
struct BookDatum: Decodable {
    let ids, year: Int?
    let title, handle, publisher, isbn: String?
    let pages: Int?
    let notes: [String]?
    let createdAt: String?
    let villains: [Villain]?

    enum CodingKeys: String, CodingKey {
        case ids = "id"
        case year = "Year"
        case title = "Title"
        case handle
        case publisher = "Publisher"
        case isbn = "ISBN"
        case pages = "Pages"
        case notes = "Notes"
        case createdAt = "created_at"
        case villains
    }
}

// MARK: - Villain
struct Villain: Decodable {
    let name: String?
    let url: String?
}
