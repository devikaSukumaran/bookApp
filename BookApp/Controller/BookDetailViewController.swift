//
//  BookDetailViewController.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import UIKit

class BookDetailViewController : UIViewController, BookDetailUIUpdater {
    
    @IBOutlet private weak var bookTitle : UILabel!
    @IBOutlet private weak var author : UILabel!
    @IBOutlet private weak var isbn : UILabel!
    @IBOutlet private weak var price : UILabel!
    @IBOutlet private weak var currency : UILabel!
    @IBOutlet private weak var bookDescription : UILabel!
    @IBOutlet private weak var bookContentView : UIView!
    @IBOutlet private weak var bookDescriptionView : UIView!
    @IBOutlet private weak var loaderView : UIView!
    @IBOutlet private weak var errorMessage : UILabel!
    @IBOutlet private weak var loader : UIActivityIndicatorView!
    
    var bookDetailer: BookDetailer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookDetailer?.beginAPICall()
    }
    
    //MARK: BookDetailUIUpdater
    func updateListUI() {
        DispatchQueue.main.async {
            if let book = self.bookDetailer?.book {
                self.loaderView.isHidden = true
                self.bookContentView.isHidden = !self.loaderView.isHidden
                self.bookDescriptionView.isHidden = !self.loaderView.isHidden
                
                self.bookTitle.text = book.title
                self.author.text = book.author
                self.bookDescription.text = book.description
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
