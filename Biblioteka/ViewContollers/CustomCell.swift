//
//  CustomCell.swift
//  Biblioteka
//
//  Created by Алексей Вольников on 17.03.2024.
//

import UIKit

final class CustomCell: UICollectionViewCell {
    @IBOutlet var bookCover: UIImageView!
    @IBOutlet var bookTitle: UILabel!
    @IBOutlet var bookAuthor: UILabel!
    
    func configure(with bookItem: BookItem, imageData: Data?) {
        DispatchQueue.main.async {
            self.bookTitle.text = bookItem.volumeInfo.title
            self.bookAuthor.text = bookItem.volumeInfo.authors.joined(separator: ", ")
            if let imageData = imageData {
                self.setBookCover(with: imageData)
            }
        }
    }
    func setBookCover(with imageData: Data) {
        DispatchQueue.main.async {
            self.bookCover.image = UIImage(data: imageData)
        }
    }
}




