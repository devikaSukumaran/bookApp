//
//  BookDetailViewModel.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import Foundation

protocol BookDetailer : class {
    var book : Book? { get set }
    var networkManager : NetworkManager { get }
    var uiUpdater : BookDetailUIUpdater? { get set }
}

protocol BookDetailUIUpdater {
    func updateListUI()
}

class BookDetailViewModel :  BookDetailReceivalAnnouncer, BookDetailer {
    
    var book : Book?
    var networkManager = NetworkManager()
    var uiUpdater : BookDetailUIUpdater?
    
    init(bookId : Int) {
        
        networkManager.bookDetailReceiver = self
        networkManager.getDetails(of: bookId)
    }
    
    //MARK: BookDetailReceivalAnnouncer
    func receivedDetails(of book: Book) {
        
        self.book = book
        self.uiUpdater?.updateListUI()
    }
}
