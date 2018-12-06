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
    
    let tempData: [MedicineModel] = [
        MedicineModel(name: "오르나민 C", description: "1회 125ml 섭취"),
        MedicineModel(name: "홍삼 골드", description: "1회 100ml 섭취"),
        MedicineModel(name: "오메가3", description: "1회 1알 섭취"),
        MedicineModel(name: "단백질 보충제", description: "1회 2알 섭취"),
        MedicineModel(name: "수면 유도제", description: "1회 1알 섭취")]
    
    var filtered: [MedicineModel] = []
    var searchActive: Bool = false
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
    
    override func viewWillAppear(_ animated: Bool) {
//        resultTableView.isHidden = filtered.isEmpty
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
        
        let medicine = filtered[indexPath.row]
        cell.itemName.text = medicine.name
        cell.itemCompany.text = medicine.campanyName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "register_alarm") as? RegisterAlarmViewController else {
            print("invalid destination")
            return
        }
        nextVC.bind(medicine: filtered[indexPath.row])
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
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
        filtered = tempData.filter { medicine in
            medicine.name.contains(inputText)
        }
        
        resultTableView.reloadData()
    }
}
