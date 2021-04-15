//
//  NetworkManager.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import Foundation

protocol APICallable : class {
    
    var bookListReceiver : BooksListReceivalAnnouncer? { get set }
    var bookDetailReceiver : BookDetailReceivalAnnouncer? { get set }
    var urlCreator : URLCreator { get }
    var network : Network{ get }
    
    func getBookList()
    func getDetails(of bookId: Int)
}

protocol BooksListReceivalAnnouncer {
    func received(_ books : Books)
}

protocol BookDetailReceivalAnnouncer {
    func receivedDetails(of book : Book)
}

final class NetworkManager : APICallable {
    
    var bookListReceiver : BooksListReceivalAnnouncer?
    var bookDetailReceiver : BookDetailReceivalAnnouncer?
    var urlCreator: URLCreator = URLCreator()
    var network: Network = Network()
    
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
                    print(error.localizedDescription)
                }
                break
                
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}
