//
//  NetworkConstants.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import Foundation

enum NetworkConstants : String {
    case baseUrl = "https://tpbookserver.herokuapp.com"
}

enum NetworkError : Error {
    case failedToFetch
}
