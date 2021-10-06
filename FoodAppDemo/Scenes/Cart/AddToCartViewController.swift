//
//  AddToCartViewController.swift
//  ShoppingAppDemo
//
//  Created by Harsh Purohit on 02/09/21.
//  Copyright © 2021 Harsh Purohit. All rights reserved.
//

import UIKit
import RaveSDK
import IQKeyboardManagerSwift

class AddToCartViewController: BaseViewController {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var lblTotalAmount:UILabel!
    
    
    var totalAmount = 0
    var productArr = [Product]()
    var selectedProuctArr = [Product]()
    var index = [Int]()
    var subItemsArr = [SubItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.title = "ADD TO CART"
    }
    
    func setView(){
        self.tableView.registerCell(tableView: self.tableView, cellIdentifier: "AddToCartTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.selectedProuctArr = self.productArr
        self.selectedProuctArr = self.selectedProuctArr.removeDuplicates()
        self.selectedProuctArr.compactMap { (data) -> Product? in
            if data.selectedQuantity == 0{
                self.selectedProuctArr.removeAll { (data1) -> Bool in
                    return data1.id ==  data.id
                }
            }else{
                totalAmount = totalAmount + (((data.price as! NSString).integerValue) * Int(data.selectedQuantity ))
            }
            
            
            return data
        }
        self.selectedProuctArr = self.selectedProuctArr.sorted(by: { ($0.id as! NSString).intValue < ($1.id as! NSString).intValue })
        print(selectedProuctArr)
        
        self.tableView.reloadData()
        
        
    }
    
    
    func setUpRavePay(){
        
                        DispatchQueue.main.async(execute: { [self] in
                            let config = RaveConfig.sharedConfig()
                            config.country = "NG" // Country Code
                            config.currencyCode = "NGN" // Currency
                            config.email = "sj@gmail.com"
                            config.phoneNumber = "7845128575"  //Phone number
                            config.transcationRef = "5478957140" // transaction ref
                            config.firstName = "Saurabh"
                            config.lastName = "Jaiswal"
                            
                            config.meta = [["metaname":"rave_escrow_tx", "metavalue":"1"]]
                           
                            // MARK:-    ----------------for Testing---------
                    config.publicKey =  "FLWPUBK_TEST-d4b50067571edfb8f4bc0d2c3bc177e3-X"  //Public key
                  //  config.secretKey = "FLWSECK_TEST-dbd5d27df95a6b1ce8acaf52460c853b-X" //Secret key
                    config.encryptionKey = "FLWSECK_TEST53c6cb56d72d" //Encryption key
                              config.isStaging = true
                            
                            
                            
                            //    ----------------for live---------
    //                        config.publicKey = self.paystack?.publicKey //Public key
    //                        config.secretKey = self.paystack?.secretKey   //Secret key
    //                        config.encryptionKey = RAVE_ENCRYPTION_KEY //Encryption key
    //                        config.isStaging = false
                            
                            let controller = NewRavePayViewController()
                            let nav = UINavigationController(rootViewController: controller)
                            
                            controller.amount = self.lblTotalAmount.text ?? "0"
                            controller.delegate = self
                            
                            IQKeyboardManager.shared.enableAutoToolbar = false
                            IQKeyboardManager.shared.enable = false
                            self.present(nav, animated: true)
                            
                        })
                    }
    
    
    @IBAction func btnCheckout(_ sender:UIButton){
        self.setUpRavePay()
        
    }
    
    
}

extension AddToCartViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedProuctArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddToCartTableViewCell", for: indexPath) as! AddToCartTableViewCell
        let data = self.selectedProuctArr[indexPath.row]
        cell.delegate = self
        
        self .lblTotalAmount.text = "\(totalAmount)"
        self.productArr.forEach { (product) in
            if data.id == product.id{
                cell.getData = product
                cell.lblItemName.text = data.name ?? ""
                cell.lblItemPrice.text = data.price ?? ""
                cell.lblquantity.text = "\(data.selectedQuantity)"
            }
        }
        
        
        self.subItemsArr.forEach { (subItem) in
            if subItem.id == data.id{
                cell.data = subItem
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}


extension AddToCartViewController:AddToCartTableViewCellProtocol{
    func addSubItem(data:SubItem, tag:Int) {
        var value = UserDefaults.standard.value(forKey: "cart_value") as? String
        value = "\(Int(value!)! + 1)"
        UserDefaults.standard.set(value, forKey: "cart_value")
        DataBaseHelper.sharedInstance.updateParticularItem(productData: data)
        let data1 = DataBaseHelper.sharedInstance.fetchData()
        self.productArr = data1
        self.index.append(tag)
        self.selectedProuctArr.forEach { (selectedProduct) in
            let id = Int.init(selectedProduct.id ?? "") ?? 0
            if id == Int(data.id ?? "0"){
                totalAmount = totalAmount + (((selectedProduct.price as! NSString).integerValue) * 1)
            }
        }
        self.lblTotalAmount.text = "\(totalAmount)"
        
        self.tableView.reloadData()
        
    }
    
    func removeSubItem(data:SubItem, tag:Int){
        var value = UserDefaults.standard.value(forKey: "cart_value") as? String
        value = "\(Int(value!)! - 1)"
        UserDefaults.standard.set(value, forKey: "cart_value")
        DataBaseHelper.sharedInstance.updateParticularItem(productData: data)
        let data1 = DataBaseHelper.sharedInstance.fetchData()
        self.productArr = data1
        
        self.productArr.forEach { (product) in
            self.selectedProuctArr.forEach { (selectedProduct) in
                if product.id == selectedProduct.id{
                    selectedProduct.selectedQuantity = product.selectedQuantity
                    selectedProduct.quantity = product.quantity
                    
                }
            }
        }
        self.selectedProuctArr.forEach { (selectedProduct) in
            let id = Int.init(selectedProduct.id ?? "") ?? 0
            if id == Int(data.id ?? "0"){
                totalAmount = totalAmount - (((selectedProduct.price as! NSString).integerValue) * 1)
            }
        }
        self .lblTotalAmount.text = "\(totalAmount)"
        self.selectedProuctArr.forEach { (selectedProduct) in
            if selectedProduct.selectedQuantity == 0{
                let id = selectedProduct.id ?? ""
                if let index = selectedProuctArr.index(where: {$0.id == id}) {
                    selectedProuctArr.remove(at: index)
                }
                
                
            }
            
        }
        
        if selectedProuctArr.count == 0{
            self.productArr.removeAll()
        }
        
        self.index.append(tag)
        self.tableView.reloadData()
    }
    
    
}

extension AddToCartViewController:RavePayProtocol{
    func onDismiss() {
        print("DISMISS")
    }
    
    // MARK: - RavePayProtocol
    
    func tranasctionSuccessful(flwRef: String?, responseData: [String : Any]?) {
         print("Success - \(responseData ?? [:])")
               var dataString = ""

               if let responseData = responseData {
                   var postData: Data? = nil
                   do {
                       postData = try JSONSerialization.data(withJSONObject: responseData, options: .prettyPrinted)
                   } catch {
                   }
                   if let postData = postData {
                       dataString = String(data: postData, encoding: .utf8) ?? ""
                   }
                
                self.navigationController?.popToRootViewController(animated: true)
                  // self.addtoWalletApi(response: dataString)
               } else {
                 //  self.addtoWalletApi(response: dataString)
               }
    }
    
    func tranasctionFailed(flwRef: String?, responseData: [String : Any]?) {
        print("Error - \(responseData ?? [:])")
    }
}
