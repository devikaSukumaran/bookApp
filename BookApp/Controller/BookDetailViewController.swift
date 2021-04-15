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
    
    var bookDetailer: BookDetailer?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bookDetailer = BookDetailViewModel(bookId: 100) as BookDetailer
        bookDetailer?.uiUpdater = self
    }
    
    //MARK: BookDetailUIUpdater
    func updateListUI() {
        
        DispatchQueue.main.async {
            //TODO: update UI here using self.bookDetailer?.book
        }
    }
}
