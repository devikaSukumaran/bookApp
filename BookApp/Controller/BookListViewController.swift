//
//  BookListViewController.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import UIKit

class BookListViewController: UIViewController, BookListUIUpdater {
    @IBOutlet private weak var booksTableView : UITableView!
    @IBOutlet private weak var loader : UIActivityIndicatorView!
    
    private var booksViewModel: BookLister = BookListViewModel()
    private var bookIdSelected : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        booksViewModel.uiUpdater = self
        booksViewModel.beginAPICall()
    }
    
    //MARK: BookListUIUpdater
    func updateListUI() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.booksTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? BookDetailViewController {
            destinationVC.bookDetailer = BookDetailViewModel(with: self.bookIdSelected ?? 0)
            destinationVC.bookDetailer?.uiUpdater = destinationVC
        }
    }
}

//MARK: UITableViewDelegate and UITableViewDataSource
extension BookListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.booksViewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.booksTableCellName) as? BookListCell else {
            fatalError(Constants.errorMessageForMissingCells)
        }
        
        let book = self.booksViewModel.books[indexPath.row]
        cell.populate(with: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bookIdSelected = self.booksViewModel.books[indexPath.row].id
        performSegue(withIdentifier: Constants.segueToBookDetailScreen, sender: self)
    }
}

