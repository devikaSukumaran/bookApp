//
//  BookListCell.swift
//  BookApp
//
//  Created by Devika Sukumaran on 15/04/2021.
//

import UIKit

class BookListCell : UITableViewCell {
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var author : UILabel!
    @IBOutlet weak var isbnValue : UILabel!
    @IBOutlet weak var price : UILabel!
    @IBOutlet weak var currency : UILabel!
    
    func populateCell(with values: Book) {
        updateCell(with: values)
    }
    
    private func updateCell(with book : Book) {
        
        self.name.text = book.title
        self.author.text = book.author
        self.isbnValue.text = book.isbn
        self.price.text = "\(book.price)"
        self.currency.text = book.currencyCode
        self.backgroundColor = .clear
    }
}
