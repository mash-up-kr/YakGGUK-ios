//
//  SearchMedicineViewController.swift
//  YakGGUK
//
//  Created by juhee on 2018. 11. 24..
//  Copyright © 2018년 team1. All rights reserved.
//  제품명으로 약 검색하기 : 검색어 입력, 검색 결과 출력 및 선택 기능

import UIKit

class SearchMedicineViewController: UIViewController {
    
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var medicindeSearch: UISearchBar!
    
    var results: [String] = []
    let tempData: [String] = ["비타민", "비타오백", "비타천", "비타백만개", "비타뿌뿌뿜"]
    var searchActive: Bool = false
    var filtered:[String] = []
    let searchController: UISearchController = {
       let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "약 이름으로 검색해주세요."
        sc.obscuresBackgroundDuringPresentation = false
        sc.hidesNavigationBarDuringPresentation = false
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
        
        definesPresentationContext = true
//        navigationItem.searchController = searchController
//        self.resultTableView.tableHeaderView = searchController.searchBar
        
        medicindeSearch.delegate = self
    }

}

extension SearchMedicineViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "result_cell", for: indexPath) as? SearchResultTableViewCell else {
            
            return SearchResultTableViewCell()
        }
        
        cell.itemName.text = filtered[indexPath.row]
        cell.itemCompany.text = "회사명"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension SearchMedicineViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {

    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("hello")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        filterAndUpdateTable(inputText: searchText)
    }
    
    func filterAndUpdateTable(inputText: String) {
        filtered = tempData.filter({ (text) -> Bool in
            return text.contains(inputText)
        })
        
        resultTableView.reloadData()
    }
}