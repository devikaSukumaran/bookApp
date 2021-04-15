//
//  BookListViewModel.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import Foundation

protocol BookLister : class {
    
    var books : Books { get set }
    var uiUpdater : BookListUIUpdater? { get set }
    var apiCaller : APICallable { get }
}

protocol BookListUIUpdater {
    func updateListUI()
}

class BookListViewModel : BookLister, BooksListReceivalAnnouncer {
    
    var books: Books = []
    var uiUpdater : BookListUIUpdater?
    var apiCaller : APICallable = NetworkManager() as APICallable
    
    init() {
        
        apiCaller.bookListReceiver = self
        apiCaller.getBookList()
    }
    
    //MARK: BooksListReceivalAnnouncer
    func received(_ books: Books) {
        
        self.books = books
        self.uiUpdater?.updateListUI()
    }
}
