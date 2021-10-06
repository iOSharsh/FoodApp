//
//  RestaurantListCell.swift
//  ShoppingAppDemo
//
//  Created by Harsh Purohit on 31/08/21.
//  Copyright © 2021 Harsh Purohit. All rights reserved.
//

import UIKit

class RestaurantListCell: UITableViewCell {
    
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var imgRestaurant:UIImageView!
    @IBOutlet weak var bgview:UIView!
    
    var resData:RestaurantList?{
        didSet{
            self.lblName.text = resData?.name ?? ""
            self.imgRestaurant.sd_setImage(with: URL.init(string: resData?.imageUrl ?? "")) { (image, err, cache, url) in
                if err == nil{
                    if let img = image{
                        self.imgRestaurant.image = img
                    }
                }else{
                    
                }
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.bgview.layer.cornerRadius = 10
        self.bgview.layer.borderWidth = 3.0
        self.bgview.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
