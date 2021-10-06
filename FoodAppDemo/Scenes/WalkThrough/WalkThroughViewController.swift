//
//  WalkThroughViewController.swift
//  ShoppingAppDemo
//
//  Created by Harsh Purohit on 08/09/21.
//  Copyright © 2021 Harsh Purohit. All rights reserved.
//

import UIKit

class WalkThroughViewController: BaseViewController {
    
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var collectionViewPageControl:UICollectionView!

    var selectedIndex = 0
    //var router:SessionRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "tutorial_show")
        self.initialDataLoad()
        debugPrint(self.backButton.isHidden)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.initialDataLoad()
    }
}
//MARK:- Button Action
extension WalkThroughViewController{
    
    
    
    @IBAction func btnGetStarted(_ sender: UIButton) {
        
       //let navigation =  UINavigationController.init(nibName: "HomeNavigation", bundle: nil)
      //  let vc = self.storyboard?.instantiateViewController(identifier: "RestaurantListViewController") as! RestaurantListViewController
        
     //   self.navigationController?.pushViewController(navigation, animated: true)
        
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "RestaurantListViewController") as! RestaurantListViewController
        let nav = UINavigationController(rootViewController: homeViewController)
        appdelegate.window?.rootViewController = nav
        
        
        
        
    }
    
    
    @IBAction func btnLogin(_ sender: UIButton) {
      //  self.router?.navigateToLogin()
    }
    
}

//MARK:- Custom method
extension WalkThroughViewController{
    
    func initialDataLoad() {
        self.registerNib()
        self.setup()
        self.hideNavigationBar = true
    }
    
    func setup() {
       // self.router = SessionRouter()
       // self.router?.viewController = self
        
    }
    
    func registerNib(){
        let nib = UINib(nibName: "WalkThoughCollectionCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "WalkThoughCollectionCell")
        let nib1 = UINib(nibName: "PageControlCollectionCell", bundle: nil)
        self.collectionViewPageControl.register(nib1, forCellWithReuseIdentifier: "PageControlCollectionCell")
        
    }
    
}

//MARK:- UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource
extension WalkThroughViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionViewPageControl{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageControlCollectionCell", for: indexPath) as! PageControlCollectionCell
            cell.layer.cornerRadius = 2
            if self.selectedIndex == indexPath.row{
                cell.backgroundColor  = .red
            }else{
                cell.backgroundColor = .lightGray
            }
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalkThoughCollectionCell", for: indexPath) as! WalkThoughCollectionCell

            
            let imgArray = ["img_nutritius","img_organic","img_fastFood"]
            let titleArray = ["Food You Love","Delivered to you","So You Can Enjoy"]
           
            
            cell.imgView.image = UIImage.init(named: imgArray[indexPath.row])
            cell.lblTitle.text = titleArray[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView{
            return CGSize(width: collectionView.frame.width, height: self.collectionView.frame.height)
        }else{
            if self.selectedIndex == indexPath.row{
                return CGSize(width: 50, height: 5)
            }else{
                return CGSize(width: 10, height: 5)
            }
            
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    
    
      func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {//Get current index of visible cells
          let page = Double(scrollView.contentOffset.x / (scrollView.frame.size.width))
          
        self.selectedIndex = Int.init(page)
        print(self.selectedIndex)
        self.collectionViewPageControl.reloadData()
      }
    
    
  
    
}
