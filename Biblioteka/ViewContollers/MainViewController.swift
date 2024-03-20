//
//  MainViewController.swift
//  HW32
//
//  Created by Алексей Вольников on 16.03.2024.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    //    @IBOutlet var activityIndicator: UIActivityIndicatorView!     // почему-то вылетает с этим индикатором
    private let bookData = NetworkManager.shared
    private var books: [BookItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        activityIndicator.startAnimating()
        //        activityIndicator.hidesWhenStopped = true
        
        fetchBooks()
    }
    
    
    
    // MARK: - Private Methods
    
    private func fetchBooks() {
        let networkManager = NetworkManager.shared
        networkManager.fetch(from: Link.apiUrl.url) { [unowned self] result in
            switch result {
            case .success(let bookResults):
                books = bookResults.items
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookInfoCell", for: indexPath) as? CustomCell else { return UICollectionViewCell() }
        let bookItem = books[indexPath.item]
//        cell.configure(with bookItem) // Не получается подкключиться к методу(
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
   
    
    
}

