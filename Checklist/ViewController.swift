//
//  ViewController.swift
//  Checklist
//
//  Created by Johnathan Tam on 2019-06-16.
//  Copyright © 2019 John's Apps. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var savedTasks = [Task]()
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(ChecklistHeader.self, forHeaderFooterViewReuseIdentifier: "headerId")
        tableView.sectionHeaderHeight = self.view.bounds.height * 0.1
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let checklistHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId") as! ChecklistHeader
        checklistHeader.viewController = self
        
        return checklistHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        return cell
    }
}

class ChecklistHeader: UITableViewHeaderFooterView {

    var viewController: ViewController?

    let taskEntryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a new task"
        textField.textColor = UIColor.black
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    let taskEntryButton: UIButton = {
        let button = UIButton()
        button.setTitle(" + ", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(taskEntryTextField)
        addSubview(taskEntryButton)
        setupViews()
    }

    func setupViews() {
        taskEntryTextField.topAnchor.constraint(equalToSystemSpacingBelow: self.contentView.topAnchor, multiplier: 1).isActive = true
        taskEntryTextField.leftAnchor.constraint(equalToSystemSpacingAfter: self.contentView.leftAnchor, multiplier: 1.3).isActive = true
        taskEntryTextField.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8).isActive = true
        taskEntryTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4).isActive = true

        taskEntryButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        taskEntryButton.leftAnchor.constraint(equalToSystemSpacingAfter: taskEntryTextField.rightAnchor, multiplier: 3).isActive = true
        taskEntryButton.addTarget(self, action: #selector(addListEntry), for: .touchUpInside)
    }

    @objc func addListEntry() {
//        viewController?.addChecklistItem(checklistItem: taskEntryTextField.text!)
//        taskEntryTextField.text = ""
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 }

