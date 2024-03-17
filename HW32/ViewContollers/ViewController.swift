//
//  ViewController.swift
//  HW32
//
//  Created by Алексей Вольников on 16.03.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    private let bookData = BookDataManager.shared
    
    var randomBookURL: URL? {
        guard let randomSubject = bookData.subjects.randomElement() else {
            return nil
        }
        return URL(string: "https://www.googleapis.com/books/v1/volumes?q=subject:\(randomSubject)&maxResults=10&key=\(bookData.apiKey)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRandomBooks()
    }
}

extension ViewController {
    func fetchRandomBooks() {
        guard let url = randomBookURL else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [unowned self] data, response, error in
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
