//
//  ViewController.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import UIKit

protocol BookListable {
    var bookListViewModel : BookListViewModel { get set }
}

class BookListViewController: UIViewController, BookListable, BookListUIUpdater {
    
    var bookListViewModel = BookListViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bookListViewModel.uiUpdater = self
    }
    
    //MARK: BookListUIUpdater
    func updateListUI() {
        print(bookListViewModel.books.count)
    }
}

