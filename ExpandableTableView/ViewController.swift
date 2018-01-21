//
//  ViewController.swift
//  ExpandableTableView
//
//  Created by Pratik Lad on 29/12/17.
//  Copyright © 2017 Pratik Lad. All rights reserved.
//

import UIKit

enum cellHeight : CGFloat{
    case Header = 44
    case Row = 40
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var data : [Section] = [Section(title: "Section 1", list: ["Row 1", "Row 2", "Row 3"], isColleps: true),Section(title: "Section 2", list: ["Row 1", "Row 2", "Row 3"], isColleps: true),Section(title: "Section 3", list: ["Row 1", "Row 2", "Row 3"], isColleps: true),Section(title: "Section 4", list: ["Row 1", "Row 2", "Row 3"], isColleps: true),Section(title: "Section 5", list: ["Row 1", "Row 2", "Row 3"], isColleps: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetup()
    }

}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableViewSetup()  {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellHeight.Header.rawValue
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header : HeaderCell = tableView.dequeueReusableCell(withIdentifier: String(describing : HeaderCell.self)) as! HeaderCell
        
        let sectionData = data[section]
        header.labelTitle.text = sectionData.title
      
        ///arrow rotate
        header.buttonArrow.transform = CGAffineTransform(rotationAngle: (sectionData.isColleps)! ? 0.0 : .pi)
        header.buttonArrow.tag = section
        header.buttonArrow.addTarget(self, action: #selector(buttonHandlerSectionArrowTap(sender:)), for: .touchUpInside)
        return header.contentView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  data[section].isColleps ?? false ? (data[section].list?.count ?? 0) : 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight.Row.rawValue
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ContentCell = tableView.dequeueReusableCell(withIdentifier: String(describing : ContentCell.self)) as! ContentCell
        
        let listData = data[indexPath.section].list
        cell.labelTitle.text = listData?[indexPath.row]
        
        return cell
    }

    ///Button action arrow in header
    func buttonHandlerSectionArrowTap(sender : UIButton)  {
        let sectionData = data[sender.tag]
        sectionData.isColleps = !sectionData.isColleps!
        tableView.reloadSections(IndexSet(integer: sender.tag), with: .automatic)
    }
}
