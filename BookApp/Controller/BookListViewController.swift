//
//  ViewController.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import UIKit

protocol BookListable {
    var bookLister : BookLister { get set }
}

class BookListViewController: UIViewController, BookListable, BookListUIUpdater {
    
    @IBOutlet weak var bookTable : UITableView!
    
    var bookLister: BookLister = BookListViewModel() as BookLister
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bookLister.uiUpdater = self
    }
    
    //MARK: BookListUIUpdater
    func updateListUI() {
        
        DispatchQueue.main.async {
            self.bookTable.reloadData()
        }
    }
}

extension BookListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookLister.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "bookListCell") as? BookListCell {
            
            let book = self.bookLister.books[indexPath.row]
            cell.populateCell(with: book)
            return cell
        }
        return UITableViewCell()
    }
}

