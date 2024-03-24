//
//  MainViewController.swift
//  Biblioteka
//
//  Created by Алексей Вольников on 16.03.2024.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private let bookData = NetworkManager.shared
    private var books: [BookItem] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchBooks()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPaths = collectionView.indexPathsForSelectedItems, let indexPath = indexPaths.first else { return }
        guard let bookDetailsVC = segue.destination as? BookDetailsViewController else { return }
        let selectedBook = books[indexPath.row]
        bookDetailsVC.book = selectedBook
    }

    
    // MARK: - Private Methods
    private func fetchBooks() {
        let networkManager = NetworkManager.shared
        let url = NetworkManager.APIEndpoint.baseURL.url
        networkManager.fetchBook(from: url) { [unowned self] result in
            switch result {
            case .success(let bookResults):
                DispatchQueue.main.async {
                    self.books = bookResults.items
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as? CustomCell else { return UICollectionViewCell() }
        let bookItem = books[indexPath.item]
        
        if let urlString = bookItem.volumeInfo.imageLinks?.thumbnail, let url = URL(string: urlString) {
            bookData.fetchImage(from: url) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let imageData):
                        self.activityIndicator.stopAnimating()
                        cell.configure(with: bookItem, imageData: imageData)
                    case .failure:
                        cell.configure(with: bookItem, imageData: nil)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                cell.configure(with: bookItem, imageData: nil)
            }
        }
        
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
        
        let collectionViewWidth = collectionView.bounds.width - 40
        let itemWidth = collectionViewWidth / 2
        let itemHeight = itemWidth + 30
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
