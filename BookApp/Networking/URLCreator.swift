//
//  URLCreator.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import Foundation

protocol URLCreatable {
    func getBooksListingURL() -> String
    func getBookDetailURL(for id: Int) -> String
}

struct URLCreator : URLCreatable {
    
    func getBooksListingURL() -> String {
        return "\(NetworkConstants.baseUrl.rawValue)/\(NetworkConstants.bookListParam.rawValue)"
    }
    
    func getBookDetailURL(for id: Int) -> String {
        return "\(NetworkConstants.baseUrl.rawValue)/\(NetworkConstants.bookDetailParam.rawValue)/\(id)"
    }
}
