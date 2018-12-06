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
    var shouldShowSearchResults: Bool = true
    let searchController: UISearchController = {
       let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "약 이름으로 검색해주세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        medicindeSearch.barTintColor = gradientColor(frame: medicindeSearch.frame)
        navigationController?.setToolbarHidden(true, animated: false)
        setBackgroundGradientLayer()
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
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "register_alarm") as? RegisterAlarmViewController else {
            print("invalid destination")
            return
        }
        let medicine = filtered[indexPath.row]
        nextVC.medicineName = medicine
        nextVC.medicneDescription = "1일 \(indexPath.row)회 식후"
//        let nextVC = RegisterAlarmViewController(name: medicine, desc: "1일 \(indexPath.row)회 식후")
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension SearchMedicineViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        print("updateSearchResults")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        resultTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        guard let searchText = searchBar.text else {
            return
        }
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            resultTableView.reloadData()
        }
        view.endEditing(true)
        filterAndUpdateTable(inputText: searchText)
    }
    
    func filterAndUpdateTable(inputText: String) {
        filtered = tempData.filter { text in
            text.contains(inputText)
        }
        
        resultTableView.reloadData()
    }
}
