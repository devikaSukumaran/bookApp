//
//  URLCreator.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import Foundation

protocol URLCreatable {
    var bookListingUrl : String { get }
    var bookDetailUrl : String { get }
}

struct URLCreator : URLCreatable {
    var bookListingUrl : String {
        "\(NetworkConstants.baseUrl.rawValue)/\(NetworkConstants.bookListParam.rawValue)"
    }
    
    var bookDetailUrl : String {
        "\(NetworkConstants.baseUrl.rawValue)/\(NetworkConstants.bookDetailParam.rawValue)/"
    }
}
