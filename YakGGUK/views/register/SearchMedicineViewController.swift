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
    @IBOutlet weak var productNameSearchBar: UISearchBar!
    @IBOutlet weak var companySearchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    let tempData: [MedicineModel] = [
        MedicineModel(name: "오르나민 C", description: "1회 125ml 섭취"),
        MedicineModel(name: "홍삼 골드", description: "1회 100ml 섭취"),
        MedicineModel(name: "오메가3", description: "1회 1알 섭취"),
        MedicineModel(name: "단백질 보충제", description: "1회 2알 섭취"),
        MedicineModel(name: "수면 유도제", description: "1회 1알 섭취")]
    
    var filtered: [MedicineModel] = []
    var searchActive: Bool = false
    var shouldShowSearchResults: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        navigationController?.setToolbarHidden(true, animated: false)
        
        configUIComponents()
    }
    
    @IBAction func popViewController(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchMedicines(sender: UIButton) {
        view.endEditing(true)
        filterAndUpdateTable()
    }
    
    private func configUIComponents() {
        setHorizontalGradientLayer()
        
        // setButtonBackground
        searchButton.layer.cornerRadius = 0.5 * searchButton.bounds.size.width
        searchButton.clipsToBounds = true
        searchButton.setImage(UIImage(named:"icSearch"), for: .normal)
        
        // configSearchBar
        for subView in productNameSearchBar.subviews {
            for view in subView.subviews {
                if view.isKind(of: NSClassFromString("UISearchBarBackground")!) {
                    if let imageView = view as? UIImageView {
                        imageView.removeFromSuperview()
                    }
                }
            }
        }
        productNameSearchBar.becomeFirstResponder()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? SearchResultTableViewCell {
            if let indexPath = resultTableView.indexPath(for: cell),
                let destination = segue.destination as? PillDetailViewController {
                // FIXME : Bind data for indexPath need
                    //            destination.product = Product()
//                    destination.medicine = filtered[indexPath.row]
                    print("destination : \(destination)")
            }
        }
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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "register_alarm") as? RegisterAlarmViewController else {
//            print("invalid destination")
//            return
//        }
////        nextVC.bind(medicine: filtered[indexPath.row])
//        nextVC.medicine = filtered[indexPath.row]
//
//        navigationController?.pushViewController(nextVC, animated: true)
//    }
    
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
        if !shouldShowSearchResults {
            shouldShowSearchResults.toggle()
            resultTableView.reloadData()
        }
        view.endEditing(true)
        filterAndUpdateTable()
    }
    
    func filterAndUpdateTable() {
        let product: String? = productNameSearchBar.text == "" ? nil : productNameSearchBar.text
        let company: String? = companySearchBar.text == "" ? nil : companySearchBar.text
        
        filtered = tempData.filter { medicine in
            var productIncluded: Bool = true
            var companyIncluded: Bool = true
            if let name = product {
                productIncluded = medicine.name.contains(name)
            }
            if let campanyName = company {
                companyIncluded = medicine.campanyName.contains(campanyName)
            }
            return productIncluded && companyIncluded
        }
        
        resultTableView.reloadData()
    }
}
