//
//  FoodViewController.swift
//  TableView
//
//  Created by R&W on 06/01/23.
//

import UIKit

class FoodViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Variable
    var arrFoodItems: [FoodItem] = []
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        configureTableView()
        title = "Food Items"
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "FoodItemTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodItemTableViewCell")
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
    }
}
// MARK: - TableView Delegat & Data Source Methods
extension FoodViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrFoodItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FoodItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FoodItemTableViewCell") as! FoodItemTableViewCell
        print(indexPath)
        let foodItem: FoodItem = arrFoodItems[indexPath.section]
        cell.nameLabel.text = foodItem.name
        cell.priceLabel.text = "$\(foodItem.price)"
        cell.quantityLabel.text = String(foodItem.quantity)
        cell.plusButton.tag = indexPath.section
        cell.minusButton.tag = indexPath.section
        cell.plusButton.addTarget(self, action: #selector(plusButtonClicked(_:)), for: .touchUpInside)
        cell.minusButton.addTarget(self, action: #selector(minusButtonClicked(_:)), for: .touchUpInside)
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        return cell
        
    }
    
    @objc
    func plusButtonClicked(_ addButton: UIButton) {
        print("plus button click")
        arrFoodItems[addButton.tag].quantity = arrFoodItems[addButton.tag].quantity + 1
        tableView.reloadData()
    }
    
    @objc
    func headerSectionCheckBoxButtonClicked(_ checkBoxButton: UIButton) {
        print("header Section CheckBox Button Clicked")
        print(checkBoxButton.tag)
        print(arrFoodItems[checkBoxButton.tag].quantity)
        
        arrFoodItems[checkBoxButton.tag].quantity = 10
        tableView.reloadData()
    }
    
    @objc
    func minusButtonClicked(_ sender: UIButton) {
        print("Minus button click")
        if arrFoodItems[sender.tag].quantity > 0 {
            arrFoodItems[sender.tag].quantity = arrFoodItems[sender.tag].quantity - 1
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodItem: FoodItem = arrFoodItems[indexPath.section]
        print(foodItem.quantity)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Food Items Header"
//    }
//
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return "Food Items Footer"
//    }
//
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 32))
        headerView.backgroundColor = .white
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 16, y: 8, width: (tableView.frame.width-32)/2, height: 16))
        titleLabel.text = "Section \(section+1) Header"
        titleLabel.backgroundColor = .white
        
//        let title2Label: UILabel = UILabel(frame: CGRect(x: ((tableView.frame.width-32)/2) + 16, y: 0, width: (tableView.frame.width-32)/2, height: 16))
//        title2Label.text = "2. Section \(section+1) Header"
//        title2Label.backgroundColor = .blue
        let selectionSelectionButton: UIButton = UIButton(frame: CGRect(x: tableView.frame.width-32, y: 8, width: 16, height: 16))
        selectionSelectionButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        
        selectionSelectionButton.tag = section
        selectionSelectionButton.addTarget(self, action: #selector(headerSectionCheckBoxButtonClicked(_:)), for: .touchUpInside)
        
        
        headerView.addSubview(titleLabel)
        headerView.addSubview(selectionSelectionButton)
        //®headerView.addSubview(title2Label)
        return headerView
    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 16
//    }
//
}

