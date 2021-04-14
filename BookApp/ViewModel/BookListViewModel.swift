//
//  BookListViewModel.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import Foundation

protocol BookLister {
    
    var books : Books { get set }
    var networkManager : NetworkManager { get }
    var uiUpdater : BookListUIUpdater? { get }
}

protocol BookListUIUpdater {
    func updateListUI()
}

class BookListViewModel : BookLister, BooksListReceivalAnnouncer {
    
    var books: Books = []
    var networkManager : NetworkManager = NetworkManager()
    var uiUpdater : BookListUIUpdater?
    
    init() {
        
        networkManager.bookListReceiver = self
        networkManager.getBookList()
    }
    
    //MARK: BooksListReceivalAnnouncer
    func received(_ books: Books) {
        
        self.books = books
        self.uiUpdater?.updateListUI()
    }
}
