//
//  Section.swift
//  ExpandableTableView
//
//  Created by Pratik Lad on 01/01/18.
//  Copyright © 2018 Pratik Lad. All rights reserved.
//

import Foundation
class Section {
    var title : String?
    var list : [String]?
    var isColleps : Bool?
    init() {
    }
    
    init(title : String? , list : [String]?, isColleps : Bool?) {
        self.title = title
        self.list = list
        self.isColleps = isColleps
    }
}
