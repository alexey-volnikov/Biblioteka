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
    
    func configure(with bookItem: BookItem) {
        bookTitle.text = bookItem.volumeInfo.title
        bookAuthor.text = bookItem.volumeInfo.authors.joined(separator: ", ")
    }
}

