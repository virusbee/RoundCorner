//
//  RoundSectionTableViewController.swift
//  RoundCorner-Swift
//
//  Created by virusbee on 2021/4/25.
//

import UIKit

class RoundSectionTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)), style: .grouped)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var data: [[String]] = {
        [["The Shawshank Redemption"],
         ["Farewell My Concubine", "Forrest Gump", "Léon"],
         ["Titanic", "La vita è bella", "Schindler's List", "Hachi: A Dog's Tale"]
        ]
    }()
    
    lazy var titles: [String] = {
        ["Top 1", "Top 2-4", "Top 5-8"]
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .groupTableViewBackground
        self.view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        titles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            let newCell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            newCell.backgroundColor = .clear
            newCell.selectionStyle = .none
            cell = newCell
        }
        
        cell?.textLabel?.text = data[indexPath.section][indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = Configuration(rect: cell.bounds)
        config.cornerMask = cornerMaskForTableView(tableView, at: indexPath)
        config.cornerRadius = 10;
        config.fillColor = UIColor.white.cgColor;
        config.strokeColor = nil;
        cell.contentView.layer.setRoundCorner(config: config)
    }
    
    private func cornerMaskForTableView(_ tableView: UITableView, at indexPath: IndexPath) -> CornerMask {
        let lastRow = tableView.numberOfRows(inSection: indexPath.section) - 1
        switch indexPath.row {
        case let x where x == 0 && x == lastRow:
            return .All
        case let x where x == 0:
            return [.MinXMinY, .MaxXMinY]
        case let x where x == lastRow:
            return [.MinXMaxY, .MaxXMaxY]
        default:
            return .None
        }
    }
}
