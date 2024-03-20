//
//  ViewController.swift
//  HW32
//
//  Created by Алексей Вольников on 16.03.2024.
//

import UIKit

final class MineViewController: UICollectionViewController {
    
    private let bookData = BookDataManager.shared
    
    var randomBookURL: URL! {
        guard let randomSubject = bookData.subjects.randomElement() else {
            return nil
        }
        return URL(string: "https://www.googleapis.com/books/v1/volumes?q=subject:\(randomSubject)&maxResults=10&key=\(bookData.apiKey)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBooks()
    }
    
    private func fetchBooks() {
        URLSession.shared.dataTask(with: randomBookURL) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(BookResults.self, from: data)
                for book in decodedData.items {
                    print(book)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
