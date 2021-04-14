//
//  Book.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import Foundation
/**
 {
     "id": 500,
     "title": "Handling Unexpected Errors",
     "isbn": "978-0590353403",
     "price": 1399,
     "currencyCode": "GBP",
     "author": "Charles R. Ash"
   }
 */

struct Book: Codable {
    let id: Int
    let title, isbn: String
    let price: Int
    let currencyCode, author: String
    let description : String?
}

typealias Books = [Book]
