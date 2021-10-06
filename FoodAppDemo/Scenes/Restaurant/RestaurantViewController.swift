//
//  RestaurantViewController.swift
//  ShoppingAppDemo
//
//  Created by Harsh Purohit on 31/08/21.
//  Copyright © 2021 Harsh Purohit. All rights reserved.
//

import UIKit

class RestaurantViewController: BaseViewController {
    
    
    @IBOutlet weak var resImageView:UIImageView!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var lblCount:UILabel!
    @IBOutlet weak var btnAddToCart:UIButton!
    
    var data = [Category]()
    var category = Category()
    var menuItems = [MenuItem]()
    var subItemsArr = [SubItem]()
    var productArr = [Product]()
    var selectedProductArr = [Product]()
    var index = [Int]()
    var add = 0
    var indexRow = 0
    var restaurantData = Restaurant()
    var counterItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setData()
    }
    
    
    func setView(){
        self.collectionView.registerCell(collectionView: self.collectionView, cellIdentifier: "FoodItemCollectionViewCell")
        self.tableView.registerCell(tableView: self.tableView, cellIdentifier: "FoodTableViewCell")
        self.tableView.register(UINib.init(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isPagingEnabled = false
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    func setData(){
        self.title = self.restaurantData.list?.name ?? ""
        self.resImageView.layer.borderColor = UIColor.black.cgColor
        self.resImageView.layer.borderWidth = 3.0
        self.resImageView.layer.cornerRadius = 10.0
        
        self.resImageView.sd_setImage(with: URL.init(string: self.restaurantData.list?.imageUrl ?? "")) { (image, err, cache, url) in
            if err == nil{
                if let img = image{
                    self.resImageView.image = img
                }
            }else{
                
            }
        }
        
        for data in self.data{
            for j in data.menuItems!{
                self.menuItems.append(j)
                
                
            }
        }
        
        self.menuItems.forEach { (data) in
            data.subItems?.forEach({ (subItem) in
                self.subItemsArr.append(subItem)
            })
        }
        let fetchData = DataBaseHelper.sharedInstance.fetchData()
        
        if fetchData.count == 0 || fetchData == nil{
            DataBaseHelper.sharedInstance.saveInDatabase(object: self.subItemsArr)
            let fetchData = DataBaseHelper.sharedInstance.fetchData()
            self.productArr = fetchData
        }else{
            if fetchData.contains(where: { (data) -> Bool in
                self.subItemsArr.contains{ $0.id == data.id}
            }){
                self.productArr = fetchData
                _ = self.productArr.compactMap { (obj) -> Product? in
                    let id = obj.id
                    if (obj.id == id){
                        if obj.selectedQuantity > 0{
                            self.selectedProductArr.append(obj)
                        }
                    }
                    
                    return obj
                }
                
                
                
            }else{
                if let cartValue = UserDefaults.standard.value(forKey: "cart_value"){
                    if (cartValue as! NSString).integerValue != 0{
                        self.showAlert()
                    }else{
                        self.productArr.removeAll()
                        self.selectedProductArr.removeAll()
                        UserDefaults.standard.set("0", forKey: "cart_value")
                        DataBaseHelper.sharedInstance.deleteAllData()
                        DataBaseHelper.sharedInstance.saveInDatabase(object: self.subItemsArr)
                        let fetchData = DataBaseHelper.sharedInstance.fetchData()
                        self.productArr = fetchData
                    }
                }
            }
            
        }
        self.collectionView.reloadData()
        self.tableView.reloadData()
        
    }
    
    
    func showAlert() {
        let alertSuccess = UIAlertController(title: "RESTAURANT APP", message: "If you proceed your previous item from cart will be discard.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Proceed", style: .default) { (action) in
            self.productArr.removeAll()
            self.selectedProductArr.removeAll()
            UserDefaults.standard.set("0", forKey: "cart_value")
            DataBaseHelper.sharedInstance.deleteAllData()
            DataBaseHelper.sharedInstance.saveInDatabase(object: self.subItemsArr)
            let fetchData = DataBaseHelper.sharedInstance.fetchData()
            self.productArr = fetchData
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
        
        let noAction = UIAlertAction.init(title: "No", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        
        alertSuccess.addAction(okAction)
        alertSuccess.addAction(noAction)
        
        self.present(alertSuccess, animated: true, completion: nil)
    }
    
    
    
    func updateCart(){
        if let value = UserDefaults.standard.value(forKey: "cart_value") as? String
        {
            self.lblCount.text = value
        }
    }
    
    @IBAction func addToCart(sender:UIButton){
        self.performSegue(withIdentifier: "segue_goToCart", sender: nil)
    }
    
    
    @IBAction func addToCartqqq(sender:UIButton){
        self.performSegue(withIdentifier: "segue_goToCart", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_goToCart"{
            if let vc = segue.destination as? AddToCartViewController{
                vc.productArr  = self.selectedProductArr
                vc.subItemsArr = self.subItemsArr
            }
        }
    }
    
}
extension RestaurantViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        let keyData = self.data[section]
        view.lblHeader.text = keyData.name
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.menuItems[section].subItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
        
        if self.productArr.count > 0{
            _ = self.productArr[indexPath.row]
            cell.data = self.menuItems[indexPath.section].subItems?[indexPath.row]
            let id = cell.data?.id ?? "0"
            cell.index = (indexPath.section * 1000) + indexPath.row
            cell.indexpath = IndexPath.init(row: indexPath.row, section: indexPath.section)
            cell.btnAddQuan.tag = (indexPath.section * 1000) + indexPath.row
            cell.btnAdd.tag = (indexPath.section * 1000) + indexPath.row
            cell.btnMinus.tag = (indexPath.section * 1000) + indexPath.row
            if self.index.contains((indexPath.section * 1000) + indexPath.row) {
                cell.btnAdd.isHidden = true
                cell.addStackView.isHidden = false
            }else{
                cell.btnAdd.isHidden = false
                cell.addStackView.isHidden = true
                
            }
            
            self.productArr.forEach { (data) in
                if data.id == id{
                    cell.getData = data
                    if (data.id == id) && (Int(data.quantity) == 0){
                        
                        cell.lblFoodQuantity.text = "Quantity:- \(0)"
                    }
                    
                    if (data.id == id){
                        // self.selectedProductArr.append(data)
                        cell.btnAddQuan.isUserInteractionEnabled = true
                        let  quan = (cell.data?.quantity ?? 0) - (Int(data.quantity))
                        self.updateCart()
                        self.addCart()
                        if quan == 0{
                            cell.btnAdd.isHidden = false
                            cell.lblQuantitySelected.text = "\(quan)"
                            data.selectedQuantity = Int32(quan)
                            cell.addStackView.isHidden = true
                            cell.btnAddQuan.isHidden = true
                            cell.btnAddQuan.isUserInteractionEnabled = false
                        }else{
                            
                            cell.lblQuantitySelected.text = "\(quan)"
                            data.selectedQuantity = Int32(quan)
                            cell.btnAdd.isHidden = true
                            cell.addStackView.isHidden = false
                            cell.btnAddQuan.isHidden = false
                        }
                        cell.lblFoodQuantity.text = "Quantity:- \(data.quantity )"
                    }else{
                        return
                    }
                }
                return
            }
            
            cell.delegate = self
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
}


extension RestaurantViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodItemCollectionViewCell", for: indexPath) as! FoodItemCollectionViewCell
        let keyData = self.data[indexPath.row]
        cell.bgView.isHidden = true
        if self.indexRow == indexPath.row{
            cell.bgView.isHidden = false
        }else{
            cell.bgView.isHidden = true
        }
        
        cell.lblFoodItem.text = keyData.name ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: self.collectionView.frame.width/3, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let indexPath1 = IndexPath.init(row: 0, section: indexPath.row)
            self.indexRow = indexPath.row
            self.tableView.scrollToRow(at: indexPath1, at: .top, animated: true)
            self.collectionView.reloadData()
        }
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let sections = tableView.indexPathsForVisibleRows?.map { $0.section } ?? []
        if let first = sections.first {
            self.indexRow = first
            self.collectionView.scrollToItem(at: IndexPath.init(row: first, section: 0), at: .left, animated: true)
            self.collectionView.reloadData()
            
        }
    }
    
    
    func animation(tempView : UIView)  {
        self.view.addSubview(tempView)
        UIView.animate(withDuration: 1.0,
                       animations: {
                        tempView.animationZoom(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                tempView.animationZoom(scaleX: 0.2, y: 0.2)
                tempView.animationRoted(angle: CGFloat(Double.pi))
                
                print(self.view.frame.origin.x)
                print(self.view.frame.origin.y)
                tempView.frame.origin.x = self.view.frame.width - 50
                tempView.frame.origin.y = 0
                
            }, completion: { _ in
                
                tempView.removeFromSuperview()
                
                UIView.animate(withDuration: 1.0, animations: {
                    
                    self.btnAddToCart.animationZoom(scaleX: 1.4, y: 1.4)
                }, completion: {_ in
                    self.btnAddToCart.animationZoom(scaleX: 1.0, y: 1.0)
                })
                
            })
            
        })
    }
    
}

extension RestaurantViewController:FoodTableViewCellProtocol{
    func addSubItem(data:SubItem, tag:Int, cell:FoodTableViewCell) {
        var value = UserDefaults.standard.value(forKey: "cart_value") as? String
        value = "\(Int(value!)! + 1)"
        self.lblCount.text = value
        UserDefaults.standard.set(value, forKey: "cart_value")
        DataBaseHelper.sharedInstance.updateParticularData(productData: data)
        let data1 = DataBaseHelper.sharedInstance.fetchData()
        self.productArr = data1
        self.index.append(tag)
        self.tableView.reloadData()
        _ = self.productArr.compactMap { (obj) -> Product? in
            if (obj.id == data.id){
                self.selectedProductArr.append(obj)
            }
            
            return obj
        }
        
        let imageViewPosition : CGPoint = cell.imgView.convert(cell.imgView.bounds.origin , to: self.view)
    
    
        let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.imgView.frame.size.width , height: cell.imgView.frame.size.height ))
    
        imgViewTemp.image = cell.imgView.image
    
    animation(tempView: imgViewTemp)
    }
    
    func removeSubItem(data:SubItem, tag:Int){
        var value = UserDefaults.standard.value(forKey: "cart_value") as? String
        value = "\(Int(value!)! - 1)"
        self.lblCount.text = value
        UserDefaults.standard.set(value, forKey: "cart_value")
        
        DataBaseHelper.sharedInstance.updateParticularData(productData: data)
        let data1 = DataBaseHelper.sharedInstance.fetchData()
        self.productArr = data1
        self.index.append(tag)
        self.tableView.reloadData()
        
        self.selectedProductArr.removeAll { (data1) -> Bool in
            return data1.id ==  data.id
        }
        
    }
    
}
