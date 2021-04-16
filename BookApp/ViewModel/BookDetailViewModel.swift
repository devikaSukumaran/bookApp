//
//  BookDetailViewModel.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import Foundation

protocol BookDetailer : class {
    var book : Book? { get set }
    var uiUpdater : BookDetailUIUpdater? { get set }
    func beginAPICall()
}

protocol BookDetailUIUpdater {
    func updateListUI()
    func displayErrorMessage()
}

class BookDetailViewModel :  BookDetailReceivalAnnouncer, BookDetailer {
    private var bookId : Int
    var book : Book?
    var apiCaller : APICallable = NetworkManager()
    var uiUpdater : BookDetailUIUpdater?
    
    init(with id : Int) {
        self.bookId = id
    }
    
    func beginAPICall() {
        apiCaller.bookDetailReceiver = self
        apiCaller.getDetails(of: self.bookId)
    }
    
    //MARK: BookDetailReceivalAnnouncer
    func receivedDetails(of book: Book) {
        self.book = book
        self.uiUpdater?.updateListUI()
    }
    
    func receivedErrorWhileGettingBookDetail() {
        self.uiUpdater?.displayErrorMessage()
    }
}
