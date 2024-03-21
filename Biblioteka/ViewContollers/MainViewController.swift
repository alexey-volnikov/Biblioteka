//
//  MainViewController.swift
//  Biblioteka
//
//  Created by Алексей Вольников on 16.03.2024.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    private let bookData = NetworkManager.shared
    private var books: [BookItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBooks()
    }
    
    
    
    // MARK: - Private Methods
    
    private func fetchBooks() {
        let networkManager = NetworkManager.shared
        networkManager.fetchBook(from: Link.apiUrl.url) { [unowned self] result in
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as? CustomCell else { return UICollectionViewCell() }
        let bookItem = books[indexPath.item]
        cell.configure(with: bookItem)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let collectionViewWidth = collectionView.bounds.width - 100
        let itemWidth = collectionViewWidth / 2
        let itemHeight = itemWidth + 60

        return CGSize(width: itemWidth, height: itemHeight)
    }
}
