//
//  AddToCartTableViewCell.swift
//  ShoppingAppDemo
//
//  Created by Harsh Purohit on 02/09/21.
//  Copyright © 2021 Harsh Purohit. All rights reserved.
//

import UIKit

protocol AddToCartTableViewCellProtocol {
    func addSubItem(data:SubItem, tag:Int)
    func removeSubItem(data:SubItem, tag:Int)
}

class AddToCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblItemName:UILabel!
    @IBOutlet weak var lblItemPrice:UILabel!
    @IBOutlet weak var lblquantity:UILabel!
    @IBOutlet weak var btnAdd:UIButton!
    @IBOutlet weak var btnMinus:UIButton!
    @IBOutlet weak var addStackView:UIView!
    @IBOutlet weak var bgView:UIView!
    
    var delegate:AddToCartTableViewCellProtocol?
    
    var getData:Product?
    var data:SubItem?

    var index = Int()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.bgView.layer.cornerRadius = 10
        self.bgView.layer.borderWidth = 1.2
        self.bgView.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btnAddItem(sender: UIButton){
        if let getData = getData{
            if !(getData.quantity == 0){
                var quan =  (getData.quantity)
                quan = quan - 1
                getData.selectedQuantity = getData.selectedQuantity + 1
                self.data?.quantity = Int(quan)
                self.delegate?.addSubItem(data: self.data!, tag: sender.tag)
            }
        }
        
    }
    
    @IBAction func btnMinusItem(sender: UIButton){
        if let getData = getData{
            //if !(getData.quantity == 0){
            var quan =  (getData.quantity)
            quan = quan + 1
            getData.selectedQuantity = getData.selectedQuantity - 1
            self.data?.quantity = Int(quan)
            self.delegate?.removeSubItem(data: self.data!, tag: sender.tag)
            // }
        }
    }
}
