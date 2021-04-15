//
//  ViewController.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import UIKit

protocol BookListable {
    var bookLister : BookLister { get set }
}

class BookListViewController: UIViewController, BookListable, BookListUIUpdater {
    
    var bookLister: BookLister = BookListViewModel() as BookLister
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bookLister.uiUpdater = self
    }
    
    //MARK: BookListUIUpdater
    func updateListUI() {
        print(bookLister.books.count)
    }
}

