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
    @IBOutlet weak var loader : UIActivityIndicatorView!
    
    var bookLister: BookLister = BookListViewModel() as BookLister
    private var bookIdSelected : Int?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        bookLister.uiUpdater = self
    }
    
    //MARK: BookListUIUpdater
    func updateListUI() {
        
        DispatchQueue.main.async {
            
            self.loader.stopAnimating()
            self.bookTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is BookDetailViewController {
            if let destinationVC = segue.destination as? BookDetailViewController {
                destinationVC.bookId = self.bookIdSelected ?? 0
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        bookIdSelected = self.bookLister.books[indexPath.row].id
        performSegue(withIdentifier: "detailPageSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

