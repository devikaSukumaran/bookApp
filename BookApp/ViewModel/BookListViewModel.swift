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
    func beginAPICall()
}

protocol BookListUIUpdater : class {
    func updateListUI()
}

class BookListViewModel : BookLister, BooksListReceivalAnnouncer {
    var books: Books = []
    weak var uiUpdater : BookListUIUpdater?
    private var apiCaller : BookListDelegate = NetworkManager()
    
    func beginAPICall() {
        apiCaller.bookListReceiver = self
        apiCaller.getBookList()
    }
    
    //MARK: BooksListReceivalAnnouncer
    func received(_ books: Books) {
        self.books = books
        self.uiUpdater?.updateListUI()
    }
}
