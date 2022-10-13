//
//  ViewController.swift
//  InappPurchaseDemo
//
//  Created by Piyush Naranje on 12/01/22.
//
import StoreKit
import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SKProductsRequestDelegate,SKPaymentTransactionObserver {
private var models = [SKProduct]()
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        SKPaymentQueue.default().add(self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        fetchProducts()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let products = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "In app purchase \(products.localizedTitle): \(products.localizedDescription) - \(products.priceLocale.currencySymbol ?? "$")\(products.price)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        show purchase
        let payment = SKPayment(product: models[indexPath.row])
        SKPaymentQueue.default().add(payment)
        
        
        
        
        
        
        
        
    }
    
//    Products
    enum product: String,CaseIterable{
        case removeAds = "com.myapp.removeAds"
        case unlockEverything = "com.myapp.unlockEverything"
        case getGems = "com.myapp.getGems"
        
    }
    private func fetchProducts(){
        let request = SKProductsRequest(productIdentifiers: Set(product.allCases.compactMap({$0.rawValue })))
        request.delegate = self
        request.start()
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            print("count: \(response.products)")
            self.models = response.products
            self.tableView.reloadData()
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        no idea
//        transactions.forEach({
//            switch $0.transactionState{
//            case .purchasing:
//                print("purchasing")
//                SKPaymentQueue.default().finishTransaction($0)
//            case .purchased:
//                print("purchased")
//                SKPaymentQueue.default().finishTransaction($0)
//            case .failed:
//                print("Failed")
//
//            default: break
//            }
//        })
    }
}

