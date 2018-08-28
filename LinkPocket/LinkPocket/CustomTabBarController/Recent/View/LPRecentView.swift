//
//  LPRecentView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 9..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPRecentView: UIView {
    
    @IBOutlet weak var mSearchBar: UISearchBar!
    @IBOutlet weak var mLPCategoryTable: UITableView!
    
    var tableItems: [LPTableSectionModel] = []
    
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []

    override func awakeFromNib() {
   
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        
        mLPCategoryTable.register(LPCategoryTableCell.self, forCellReuseIdentifier: "Cell")
        
        tableItems = LPGroupingTable(urls: urls)
        mLPCategoryTable.reloadData()
        
    }
    
}

extension LPRecentView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("LPLinkTableCell", owner: self, options: nil)?.first as! LPLinkTableCell
        let item = tableItems[indexPath.section].urls[indexPath.row]
        cell.modifyCell(img: item.imageName!, url: item.url!, title: item.title!, category: item.category!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.contentView.backgroundColor = UIColor.colorFromRGB(0xFCFCFC)
            headerTitle.textLabel?.frame = R(0, 0, headerTitle.bounds.width, headerTitle.bounds.height)
            headerTitle.textLabel?.textColor = UIColor.colorFromRGB(0x4D4D4D)
            headerTitle.textLabel?.font = UIFont(name: "Roboto-Bold", size: 12*r)
            headerTitle.textLabel?.textAlignment = .center
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableItems.count != 0 {
            if (tableItems[section].section) == date("YYYY MM dd") {
                return "TODAY"
            } else {
                return tableItems[section].section
            }
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableItems.count != 0 {
            return tableItems[section].urls.count
            
        } else {
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61 * r
    }
    
}