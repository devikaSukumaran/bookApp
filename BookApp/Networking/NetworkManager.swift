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
}

protocol BookDetailReceivalAnnouncer : class {
    func receivedDetails(of book : Book)
    func receivedErrorWhileGettingBookDetail()
}

final class NetworkManager : BookListDelegate, BookDetailDelegate {
    
    weak var bookListReceiver : BooksListReceivalAnnouncer?
    weak var bookDetailReceiver : BookDetailReceivalAnnouncer?
    private var urlCreator: URLCreatable = URLCreator()
    private var network: DataFetchable = Network()
    
    func getBookList() {
        let urlString = urlCreator.getBooksListingURL()
        network.fetch(from: urlString) { [weak self] (result) in
            switch(result) {
            
            case .success(let data):
                var books : Books
                do {
                    books = try JSONDecoder().decode(Books.self, from: data)
                    self?.bookListReceiver?.received(books)
                } catch {
                    print(error.localizedDescription)
                }
                break
                
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func getDetails(of bookId: Int) {
        let urlString = urlCreator.getBookDetailURL(for: bookId)
        network.fetch(from: urlString) { [weak self] (result) in
            switch(result) {
            
            case .success(let data):
                var book : Book
                do {
                    book = try JSONDecoder().decode(Book.self, from: data)
                    self?.bookDetailReceiver?.receivedDetails(of: book)
                }catch {
                    self?.bookDetailReceiver?.receivedErrorWhileGettingBookDetail()
                }
                break
                
            case .failure( _):
                self?.bookDetailReceiver?.receivedErrorWhileGettingBookDetail()
                break
            }
        }
    }
}
