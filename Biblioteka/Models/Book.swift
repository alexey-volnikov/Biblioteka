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
}

struct ImageLinks: Decodable {
    let smallThumbnail: String? // миниатюра
    let thumbnail: String? // большая
}
