//
//  ViewController.swift
//  RoundCorner-Swift
//
//  Created by virusbee on 2021/4/25.
//

import UIKit

class ViewController: UIViewController {

    lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        view.center = self.view.center
        
        var config = Configuration(rect: view.bounds)
        config.cornerMask = .All
        config.cornerRadius = 20
        config.strokeColor = UIColor.red.cgColor
        view.layer.setRoundCorner(config: config)
        
        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 125, height: 125))
        var config = Configuration(rect: label.bounds)
        
        config.cornerMask = [.MinXMinY, .MaxXMinY, .MinXMaxY]
        config.cornerRadius = 20
        config.fillColor = UIColor.red.cgColor
        label.layer.setRoundCorner(config: config)
        
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 155, y: 20, width: 125, height: 125))
        button.setTitle("Touch Me", for: .normal)
        button.addTarget(self, action: #selector(showRoundSectionTableViewController), for: .touchUpInside)
        
        var config = Configuration(rect: button.bounds)
        config.cornerMask = [.MinXMinY, .MaxXMinY, .MaxXMaxY]
        config.cornerRadius = 20
        config.fillColor = UIColor.red.cgColor
        button.layer.setRoundCorner(config: config)
        
        return button
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 155, width: 125, height: 125))
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Input"
        
        var config = Configuration(rect: textField.bounds)
        config.cornerMask = [.MinXMinY, .MaxXMaxY, .MinXMaxY]
        config.cornerRadius = 20
        config.strokeColor = UIColor.red.cgColor
        
        textField.layer.setRoundCorner(config: config)
        
        return textField
    }()
    
    lazy var emptyView: UIView = {
        let view = UIView(frame: CGRect(x: 155, y: 155, width: 125, height: 125))
        
        var config = Configuration(rect: view.bounds)
        config.cornerMask = [.MaxXMinY, .MinXMaxY, .MaxXMaxY]
        config.cornerRadius = 20
        config.strokeColor = UIColor.red.cgColor
        view.layer.setRoundCorner(config: config)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(button)
        contentView.addSubview(textField)
        contentView.addSubview(emptyView)
    }

    @objc func showRoundSectionTableViewController() {
        self.present(RoundSectionTableViewController(), animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

