//
//  Book.swift
//  Biblioteka
//
//  Created by Алексей Вольников on 16.03.2024.
//


import Foundation

struct BookResults: Decodable {
    let items: [BookItem]
}

struct BookItem: Decodable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    let title: String
    let authors: [String]
    let imageLinks: ImageLinks?
    let description: String
    let pageCount: Int
    let publisher: String
    var detalsDescription: String {
        
        """
    Title: \(title)
    Autors: \(authors.joined(separator: ", "))
    Page cout: \(pageCount)
    Publisher: \(publisher)
    Description: \(description)
    """
    }
}

struct ImageLinks: Decodable {
    let smallThumbnail: String?
    let thumbnail: String?
}
