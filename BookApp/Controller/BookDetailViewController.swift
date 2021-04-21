//
//  BookDetailViewController.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import UIKit

class BookDetailViewController : UIViewController, BookDetailUIUpdater {
    @IBOutlet private weak var name : UILabel!
    @IBOutlet private weak var author : UILabel!
    @IBOutlet private weak var isbn : UILabel!
    @IBOutlet private weak var price : UILabel!
    @IBOutlet private weak var currency : UILabel!
    @IBOutlet private weak var overview : UILabel!
    @IBOutlet private weak var detailContentView : UIView!
    @IBOutlet private weak var bookDescriptionView : UIView!
    @IBOutlet private weak var loaderView : UIView!
    @IBOutlet private weak var errorMessage : UILabel!
    @IBOutlet private weak var loader : UIActivityIndicatorView!
    
    var detailerViewModel: BookDetailer?
    
    //MARK: BookDetailUIUpdater
    func updateListUI() {
        DispatchQueue.main.async {
            if let book = self.detailerViewModel?.book {
                self.loaderView.isHidden = true
                self.detailContentView.isHidden = !self.loaderView.isHidden
                self.bookDescriptionView.isHidden = !self.loaderView.isHidden
                
                self.name.text = book.title
                self.author.text = book.author
                self.overview.text = book.description
                self.isbn.text = book.isbn
                self.price.text = "\(book.price)"
            }
        }
    }
    
    func displayErrorMessage() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.errorMessage.isHidden = false
        }
    }
}
