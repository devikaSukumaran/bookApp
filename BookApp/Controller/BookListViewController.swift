//
//  BookListViewController.swift
//  BookApp
//
//  Created by Devika Sukumaran on 14/04/2021.
//

import UIKit

class BookListViewController: UIViewController {
    @IBOutlet private weak var booksTableView : UITableView!
    @IBOutlet private weak var loader : UIActivityIndicatorView!
    @IBOutlet private weak var errorMessage : UILabel!
    
    private var booksViewModel: BookLister = BookListViewModel()
    private var bookIdSelected : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        booksViewModel.uiUpdater = self
        booksViewModel.beginAPICall()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? BookDetailViewController {
            destinationVC.bookDetailer = BookDetailViewModel(with: self.bookIdSelected ?? 0)
            destinationVC.bookDetailer?.uiUpdater = destinationVC
        }
    }
}

//MARK: BookListUIUpdater
extension BookListViewController : BookListUIUpdater {
    func updateListUI() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.errorMessage.isHidden = true
            self.booksTableView.reloadData()
        }
    }
    
    func loadNextBatchOfBooks(for indices: [IndexPath]) {
        DispatchQueue.main.async {
            self.booksTableView.insertRows(at: indices, with: .automatic)
        }
    }
    
    func displayErrorMessage() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.errorMessage.isHidden = false
        }
    }
}

//MARK: UITableView related methods
extension BookListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let page = UserDefaults.standard.value(forKey: Constants.resultsPageKey) as? Int {
            return booksViewModel.books.count > page*Constants.numberOfResultsPerPage ? page*Constants.numberOfResultsPerPage : booksViewModel.books.count
        }
        return 0
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
    
    //Finding scroll on tableView bottom to load next set of books
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRows = self.booksTableView.indexPathsForVisibleRows
        guard let page = UserDefaults.standard.value(forKey: Constants.resultsPageKey) as? Int else {
            return
        }
        let resultsCount = Constants.numberOfResultsPerPage*page
        if ((visibleRows?.contains([0, resultsCount - 2])) != nil) {
            booksViewModel.loadNextSetOfBookResults()
        }
    }
}

