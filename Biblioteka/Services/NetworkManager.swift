//
//  NetworkManager.swift
//  Biblioteka
//
//  Created by Алексей Вольников on 20.03.2024.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingError
    }

    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchBook(from url: URL, completion: @escaping(Result<BookResults, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataModel = try decoder.decode(BookResults.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                print("Ошибка декодирования: \(error)")
                completion(.failure(.decodingError))
            }
            
            
        }.resume()
    }
    
}
// MARK: - APIEndpoint
extension NetworkManager {
    
    // apiKey = "AIzaSyCjwQHkYSsb1hC5RqecY9yymhvcVN5beiI"
    
    enum APIEndpoint {
        case baseURL
        
        var url: URL {
            switch self {
            case .baseURL:
                return URL(string: "https://www.googleapis.com/books/v1/volumes?q=subject:philosophy&maxResults=30&key=AIzaSyCjwQHkYSsb1hC5RqecY9yymhvcVN5beiI")!
            }
        }
    }
}
