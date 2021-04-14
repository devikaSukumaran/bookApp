//
//  BookDetailViewController.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import UIKit

protocol BookDetailable {
    var bookDetailViewModel : BookDetailViewModel? { get set }
}

class BookDetailViewController : UIViewController, BookDetailable, BookDetailUIUpdater {
    
    var bookDetailViewModel: BookDetailViewModel?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bookDetailViewModel = BookDetailViewModel(bookId: 100)
        bookDetailViewModel?.uiUpdater = self
    }
    
    //MARK: BookDetailUIUpdater
    func updateListUI() {
        print(self.bookDetailViewModel?.book?.author ?? "")
    }
}
