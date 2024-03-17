//
//  BookDataManager.swift
//  HW32
//
//  Created by Алексей Вольников on 16.03.2024.
//

import Foundation

class BookDataManager {
    static let shared = BookDataManager()

    let apiKey = "AIzaSyCjwQHkYSsb1hC5RqecY9yymhvcVN5beiI"
    let subjects = ["fiction", "romance", "mystery", "history", "fantasy"]

    private init() {}
}
