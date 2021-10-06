//
//  FoodTableViewCell.swift
//  ShoppingAppDemo
//
//  Created by Harsh Purohit on 31/08/21.
//  Copyright © 2021 Harsh Purohit. All rights reserved.
//

import UIKit

protocol FoodTableViewCellProtocol {
    func addSubItem(data:SubItem, tag:Int, cell:FoodTableViewCell)
    func removeSubItem(data:SubItem, tag:Int)
}


class FoodTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgView:UIImageView!
    @IBOutlet weak var lblFoodPrice:UILabel!
    @IBOutlet weak var lblFoodName:UILabel!
    @IBOutlet weak var lblFoodQuantity:UILabel!
    @IBOutlet weak var lblQuantitySelected:UILabel!
    @IBOutlet weak var btnAdd:UIButton!
    @IBOutlet weak var btnMinus:UIButton!
    @IBOutlet weak var addStackView:UIView!
    @IBOutlet weak var btnAddQuan:UIButton!
    
    var delegate:FoodTableViewCellProtocol?
    var getData:Product?
    var index = Int()
    var indexpath = IndexPath()
    var data:SubItem?{
        didSet{
            self.lblFoodName.text = data?.name
            self.lblFoodPrice.text = data?.price
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btnAddAction(sender: UIButton){
        if let getData = getData{
            if !(getData.quantity == 0){
                let quan =  (getData.quantity ) - 1
                 self.data?.quantity = Int(quan)
                let tableView = superview as? UITableView
                let buttonPosition : CGPoint = sender.convert(sender.bounds.origin, to: tableView)
                
                let indexPath = tableView?.indexPathForRow(at: buttonPosition)!
                
                let cell = tableView?.cellForRow(at: indexPath!) as! FoodTableViewCell
                
                self.delegate?.addSubItem(data: self.data!, tag: sender.tag, cell: cell)
            }
        }
    }
    
    @IBAction func btnAddItem(sender: UIButton){
        if let getData = getData{
            if !(getData.quantity == 0){
                var quan =  (getData.quantity)
                   quan = quan - 1
                
                 self.data?.quantity = Int(quan)
            let tableView = superview as? UITableView
                           let buttonPosition : CGPoint = sender.convert(sender.bounds.origin, to: tableView)
                           
                           let indexPath = tableView?.indexPathForRow(at: buttonPosition)!
                           
                           let cell = tableView?.cellForRow(at: indexPath!) as! FoodTableViewCell
                self.delegate?.addSubItem(data: self.data!, tag: sender.tag, cell: cell)
            }
        }
    }
    
    @IBAction func btnMinusItem(sender: UIButton){
       if let getData = getData{
            //if !(getData.quantity == 0){
                let quan =  (getData.quantity ) + 1
                 self.data?.quantity = Int(quan)
                self.delegate?.removeSubItem(data: self.data!, tag: sender.tag)
          //  }
        }
    }
    
}
