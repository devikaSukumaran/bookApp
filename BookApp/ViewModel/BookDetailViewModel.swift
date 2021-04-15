//
//  BookDetailViewModel.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import Foundation

protocol BookDetailer : class {
    var book : Book? { get set }
    var apiCaller : APICallable { get }
    var uiUpdater : BookDetailUIUpdater? { get set }
}

protocol BookDetailUIUpdater {
    func updateListUI()
}

class BookDetailViewModel :  BookDetailReceivalAnnouncer, BookDetailer {
    
    var book : Book?
    var apiCaller : APICallable = NetworkManager() as APICallable
    var uiUpdater : BookDetailUIUpdater?
    
    init(bookId : Int) {
        
        apiCaller.bookDetailReceiver = self
        apiCaller.getDetails(of: bookId)
    }
    
    //MARK: BookDetailReceivalAnnouncer
    func receivedDetails(of book: Book) {
        
        self.book = book
        self.uiUpdater?.updateListUI()
    }
}
