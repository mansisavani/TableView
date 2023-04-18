import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Variable
    var arrFoodItems: [FoodItem] = []
    var arrMobileItems: [MobileItem] = []
    
    var selectedIndex: Int = -1
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        loadFoodItems()
        loadMobileItems()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "FoodItemTableViewCell",
                                 
                                 
                                 bundle: nil), forCellReuseIdentifier: "FoodItemTableViewCell")
        tableView.separatorStyle = .none

    }

    private func loadFoodItems() {
        let pitzza: FoodItem = FoodItem(id: 1, name: "Pitzza", price: 400, discountedPrice: 375)
        let burger: FoodItem = FoodItem(id: 2, name: "Burger", price: 40, discountedPrice: 30)
        let dosha: FoodItem = FoodItem(id: 3, name: "Dosha", price: 120, discountedPrice: 100)
        let dabeli: FoodItem = FoodItem(id: 4, name: "Dabeli", price: 20, discountedPrice: 15)
        let meggi: FoodItem = FoodItem(id: 5, name: "Meggi", price: 40, discountedPrice: 35)
        arrFoodItems = [pitzza, burger, dosha, dabeli, meggi]
    }
    
    private func loadMobileItems() {
        let iphone14: MobileItem = MobileItem(id: 1, name: "Pitzza", price: 400, discountedPrice: 375, releasedYear: "2022")
        let pixel6: MobileItem = MobileItem(id: 2, name: "Burger", price: 40, discountedPrice: 30, releasedYear: "2020")
        arrMobileItems = [iphone14, pixel6]
    }
}

// MARK: - TableView Delegat & Data Source Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? arrFoodItems.count : arrMobileItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = UITableViewCell()
//        cell.textLabel?.text = arrFoodItems[indexPath.row].name
//        return cell
        if indexPath.section == 0 {
            let cell: FoodItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FoodItemTableViewCell") as! FoodItemTableViewCell
            let foodItem: FoodItem = arrFoodItems[indexPath.row]
            cell.nameLabel.text = foodItem.name
            cell.priceLabel.text = "$\(foodItem.price)"
            cell.quantityLabel.text = String(foodItem.quantity)
            cell.plusButton.tag = indexPath.row
            cell.minusButton.tag = indexPath.row
            cell.plusButton.addTarget(self, action: #selector(plusButtonClicked(_:)), for: .touchUpInside)
            cell.minusButton.addTarget(self, action: #selector(minusButtonClicked(_:)), for: .touchUpInside)
            return cell
        } else {
            let cell: UITableViewCell = UITableViewCell()
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "erterufgksuegvw8e76hfer78tygyohdfskjghiughdfsiughydfugiheriugdhsfgiudfshgfdijsghuidsfghdfuighdfsiughdfiguhdfsguidhfgiudfhgiudfghidfuhgisudfghdfiughdfsiughdfsgiudfhgiudfghiudfghuodfighidfusghfduighfduighfgiuhfdgiudfhguisdfhsiughfdiguhfdiushgiuh"//arrMobileItems[indexPath.row].name
            return cell
        }
        
    }
    
    @objc
    func plusButtonClicked(_ addButton: UIButton) {
        print("plus button click")
        arrFoodItems[addButton.tag].quantity = arrFoodItems[addButton.tag].quantity + 1
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
        if indexPath.section == 0 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let foodViewController = storyBoard.instantiateViewController(withIdentifier: "FoodViewController") as! FoodViewController
            foodViewController.arrFoodItems = arrFoodItems
            navigationController?.pushViewController(foodViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Food Items Header" : "Mobile Items Header"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return section == 0 ? "Food Items Footer" : "Mobile Items Footer"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 32))
            headerView.backgroundColor = .white
            let titleLabel: UILabel = UILabel(frame: CGRect(x: 16, y: 8, width: (tableView.frame.width-32)/2, height: 16))
            titleLabel.text = "Section \(section+1) Header"
            titleLabel.backgroundColor = .white
            let selectionSelectionButton: UIButton = UIButton(frame: CGRect(x: tableView.frame.width-32, y: 8, width: 16, height: 16))
            selectionSelectionButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            
            selectionSelectionButton.tag = section
            selectionSelectionButton.addTarget(self, action: #selector(headerSectionCheckBoxButtonClicked(_:)), for: .touchUpInside)
            
            headerView.addSubview(titleLabel)
            headerView.addSubview(selectionSelectionButton)
            //headerView.addSubview(title2Label)
            return headerView
        } else {
            return nil
        }
        
    }
    
    @objc
    func headerSectionCheckBoxButtonClicked(_ checkBoxButton: UIButton) {
        print("header Section CheckBox Button Clicked")
        
////        var sum: Int = 0
////        for i in 0..<arrFoodItems.count {
////            sum = sum + arrFoodItems[i].quantity
////        }
////
////        title = "Total Quantity \(sum)"
        ///
        let quantity = String(arrFoodItems.map { $0.quantity }.reduce(0, +))
        title = "Total Quantity \(quantity)"
        print(arrFoodItems.map { $0.quantity })
        print(arrFoodItems.map { $0.quantity })
        //print(arrFoodItems.filter { $0.quantity > 0 })
        //print(arrFoodItems.filter { $0.quantity > 0 }.map{ $0.quantity}.reduce(10, +))
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
   
}

