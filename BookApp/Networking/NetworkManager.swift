//
//  NetworkManager.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import Foundation

protocol BookListDelegate : class {
    var bookListReceiver : BooksListReceivalAnnouncer? { get set }
    func getBookList()
}

protocol BookDetailDelegate : class {
    var bookDetailReceiver : BookDetailReceivalAnnouncer? { get set }
    func getDetails(of bookId: Int)
}

protocol BooksListReceivalAnnouncer : class {
    func received(_ books : Books)
    func receivedErrorWhileFetchingBooks()
}

protocol BookDetailReceivalAnnouncer : class {
    func receivedDetails(of book : Book)
    func receivedErrorWhileFetchingBookDetail()
}

final class NetworkManager : BookListDelegate, BookDetailDelegate {
    weak var bookListReceiver : BooksListReceivalAnnouncer?
    weak var bookDetailReceiver : BookDetailReceivalAnnouncer?
    private var urlCreator: URLCreatable = URLCreator()
    private var network: DataFetchable = Network()
    
    func getBookList() {
        let urlString = urlCreator.bookListingUrl
        network.fetch(from: urlString) { [weak self] (result) in
            switch(result) {
            
            case .success(let data):
                var books : Books
                do {
                    books = try JSONDecoder().decode(Books.self, from: data)
                    self?.bookListReceiver?.received(books)
                } catch {
                    self?.bookListReceiver?.receivedErrorWhileFetchingBooks()
                }
                break
                
            case .failure( _):
                self?.bookListReceiver?.receivedErrorWhileFetchingBooks()
                break
            }
        }
    }
    
    func getDetails(of bookId: Int) {
        var urlString : String { urlCreator.bookDetailUrl + "\(bookId)" }
        network.fetch(from: urlString) { [weak self] (result) in
            switch(result) {
            
            case .success(let data):
                var book : Book
                do {
                    book = try JSONDecoder().decode(Book.self, from: data)
                    self?.bookDetailReceiver?.receivedDetails(of: book)
                }catch {
                    self?.bookDetailReceiver?.receivedErrorWhileFetchingBookDetail()
                }
                break
                
            case .failure( _):
                self?.bookDetailReceiver?.receivedErrorWhileFetchingBookDetail()
                break
            }
        }
    }
}
