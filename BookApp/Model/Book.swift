//
//  Book.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import Foundation

struct Book: Codable {
    
    let id: Int
    let title, isbn: String
    let price: Int
    let currencyCode, author: String
    let description : String?
}

typealias Books = [Book]
