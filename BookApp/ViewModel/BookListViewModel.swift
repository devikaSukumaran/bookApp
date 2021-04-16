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
    func loadNextSetOfBookResults()
}

protocol BookListUIUpdater : class {
    func updateListUI()
    func loadNextBatchOfBooks(for indices: [IndexPath])
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
        UserDefaults.standard.setValue(1, forKey: "resultsPage")
        self.uiUpdater?.updateListUI()
    }
    
    func loadNextSetOfBookResults() {
        guard let page = UserDefaults.standard.value(forKey: "resultsPage") as? Int else {
            return
        }
        let startingIndex = page*Constants.numberOfResultsPerPage
        
        if startingIndex < self.books.count {
            let endingIndex = (startingIndex+Constants.numberOfResultsPerPage)-1
            var nextIndices = [IndexPath]()
            if self.books.count >= endingIndex {
                for index in startingIndex...endingIndex {
                    nextIndices.append(IndexPath(row: index, section: 0))
                }
            }else {
                for index in startingIndex...self.books.count {
                    nextIndices.append(IndexPath(row: index, section: 0))
                }
            }
            
            UserDefaults.standard.setValue(page+1, forKey: "resultsPage")
            self.uiUpdater?.loadNextBatchOfBooks(for: nextIndices)
        }
    }
}
