//
//  NetworkManager.swift
//  Biblioteka
//
//  Created by Алексей Вольников on 20.03.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingError
        case requestFailed(AFError)
    }

    func fetchImage(from url: URL, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchBook(from url: URL, completion: @escaping(Result<BookResults, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: BookResults.self) { response in
                switch response.result {
                case .success(let bookResults):
                    completion(.success(bookResults))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
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
                return URL(string: "https://www.googleapis.com/books/v1/volumes?q=subject:philosophy&maxResults=35&key=AIzaSyCjwQHkYSsb1hC5RqecY9yymhvcVN5beiI")!
            }
        }
    }
}
