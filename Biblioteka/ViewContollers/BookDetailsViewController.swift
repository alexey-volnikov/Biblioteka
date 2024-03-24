//
//  BookDeatilsViewController.swift
//  Biblioteka
//
//  Created by Алексей Вольников on 24.03.2024.
//

import UIKit

final class BookDetailsViewController: UIViewController{
    
    // MARK: - IBOutlets
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var deskcriptionLabel: UILabel!
    
    // MARK: - Public properties
    var book: BookItem!
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        deskcriptionLabel.text = book.volumeInfo.detalsDescription
        fetchImage()
    }
    // MARK: - Private Methods
    private func fetchImage() {
        guard let urlString = book.volumeInfo.imageLinks?.thumbnail, let url = URL(string: urlString) else {
            bookImageView.image = UIImage(named: "defaultImage")
            return
        }
        networkManager.fetchImage(from: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageData):
                    self?.bookImageView.image = UIImage(data: imageData)
                case .failure:
                    self?.bookImageView.image = UIImage(named: "defaultImage")
                }
            }
        }
    }
}
