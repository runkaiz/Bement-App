//
//  CatalogDetailTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 10/31/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit

class CatalogDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var titleTextDetail: UINavigationItem!
    var segueData = Int()
    var catalogs = [String()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch segueData {
        case 1:
            titleTextDetail.title = "Kindergarten"
            catalogs = catalog.Gradek3
        case 2:
            titleTextDetail.title = "Grade 1"
            catalogs = catalog.Gradek3
        case 3:
            titleTextDetail.title = "Grade 2"
            catalogs = catalog.Gradek3
        case 4:
            titleTextDetail.title = "Grade 3"
            catalogs = catalog.Gradek3
        case 5:
            titleTextDetail.title = "Grade 4"
            catalogs = catalog.Grade45
        case 6:
            titleTextDetail.title = "Grade 5"
            catalogs = catalog.Grade45
        case 7:
            titleTextDetail.title = "Grade 6"
            catalogs = catalog.Grade6
        case 8:
            titleTextDetail.title = "Grade 7"
            catalogs = catalog.Grade789
        case 9:
            titleTextDetail.title = "Grade 8 & 9"
            catalogs = catalog.Grade789
        default:
            print("This should not happen!")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CatalogTableViewCell
        
        cell.title.text = catalogs[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        globalVariable.row = indexPath.row
        switch segueData {
        case 1:
            globalVariable.catalogGrade = "Kindergarten"
        case 2:
            globalVariable.catalogGrade = "Grade 1"
        case 3:
            globalVariable.catalogGrade = "Grade 2"
        case 4:
            globalVariable.catalogGrade = "Grade 3"
        case 5:
            globalVariable.catalogGrade = "Grade 4"
        case 6:
            globalVariable.catalogGrade = "Grade 5"
        case 7:
            globalVariable.catalogGrade = "Grade 6"
        case 8:
            globalVariable.catalogGrade = "Grade 7"
        case 9:
            globalVariable.catalogGrade = "Grade 8 & 9"
        default:
            print("This should not happen!")
        }
        self.performSegue(withIdentifier: "toWeb", sender: self)
    }
}
