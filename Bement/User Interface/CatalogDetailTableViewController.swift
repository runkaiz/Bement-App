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
        case 2:
            titleTextDetail.title = "Grade 1"
        case 3:
            titleTextDetail.title = "Grade 2"
        case 4:
            titleTextDetail.title = "Grade 3"
        case 5:
            titleTextDetail.title = "Grade 4"
        case 6:
            titleTextDetail.title = "Grade 5"
        case 7:
            titleTextDetail.title = "Grade 6"
        case 8:
            titleTextDetail.title = "Grade 7"
        case 9:
            titleTextDetail.title = "Grade 8 & 9"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch segueData {
        case 1: cell.textLabel?.text = catalog.Gradek3[indexPath.row]
        case 2: cell.textLabel?.text = catalog.Gradek3[indexPath.row]
        case 3: cell.textLabel?.text = catalog.Gradek3[indexPath.row]
        case 4: cell.textLabel?.text = catalog.Gradek3[indexPath.row]
        case 5: cell.textLabel?.text = catalog.Grade45[indexPath.row]
        case 6: cell.textLabel?.text = catalog.Grade45[indexPath.row]
        case 7: cell.textLabel?.text = catalog.Grade6[indexPath.row]
        case 8: cell.textLabel?.text = catalog.Grade789[indexPath.row]
        case 9: cell.textLabel?.text = catalog.Grade789[indexPath.row]
        default:
            print("This should not happen!")
        }
        
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
            
        if userInterfaceStyle == .dark {
            self.view.backgroundColor = .black
        } else {
            self.view.backgroundColor = .white
        }
    }
}
