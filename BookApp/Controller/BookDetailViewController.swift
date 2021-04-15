//
//  BookDetailViewController.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import UIKit

protocol BookDetailable {
    var bookDetailer : BookDetailer? { get set }
}

class BookDetailViewController : UIViewController, BookDetailable, BookDetailUIUpdater {
    
    @IBOutlet weak var bookTitle : UILabel!
    @IBOutlet weak var author : UILabel!
    @IBOutlet weak var isbn : UILabel!
    @IBOutlet weak var price : UILabel!
    @IBOutlet weak var currency : UILabel!
    @IBOutlet weak var bookDescription : UILabel!
    @IBOutlet weak var bookContentView : UIView!
    @IBOutlet weak var bookDescriptionView : UIView!
    @IBOutlet weak var loaderView : UIView!
    
    var bookDetailer: BookDetailer?
    var bookId : Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bookDetailer = BookDetailViewModel(bookId: self.bookId) as BookDetailer
        bookDetailer?.uiUpdater = self
    }
    
    //MARK: BookDetailUIUpdater
    func updateListUI() {
        
        DispatchQueue.main.async {
            
            if let book = self.bookDetailer?.book {
                
                self.bookContentView.isHidden = false
                self.bookDescription.isHidden = false
                self.loaderView.isHidden = true
                
                self.bookTitle.text = book.title
                self.author.text = book.author
                self.bookDescription.text = book.description
                self.isbn.text = book.isbn
                self.price.text = "\(book.price)"
            }
        }
    }
}
