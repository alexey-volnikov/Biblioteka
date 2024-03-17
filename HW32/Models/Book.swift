//
//  Book.swift
//  HW32
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
}
