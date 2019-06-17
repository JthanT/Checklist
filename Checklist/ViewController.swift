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
    
    private var tasks = [Task]()
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - barHeight))
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            let tasks = try PersistenceService.context.fetch(fetchRequest)
            self.tasks = tasks
            self.tableView.reloadData()
        } catch {
            
        }
        
        
        self.tableView.register(ChecklistHeader.self, forHeaderFooterViewReuseIdentifier: "headerId")
        self.tableView.sectionHeaderHeight = self.view.bounds.height * 0.1
        self.tableView.register(TaskCell.self, forCellReuseIdentifier: "MyCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let checklistHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId") as! ChecklistHeader
        checklistHeader.viewController = self
        
        return checklistHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TaskCell
        cell.taskItemLabel.text = self.tasks[indexPath.row].task
        
        return cell
    }
    
    func addChecklistItem(checklistItem: String) {
        let taskItem = Task(context: PersistenceService.context)
        taskItem.task = checklistItem
        PersistenceService.saveContext()
        self.tasks.append(taskItem)
        self.tableView?.reloadData()
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
        self.taskEntryTextField.topAnchor.constraint(equalToSystemSpacingBelow: self.contentView.topAnchor, multiplier: 1).isActive = true
        self.taskEntryTextField.leftAnchor.constraint(equalToSystemSpacingAfter: self.contentView.leftAnchor, multiplier: 1.3).isActive = true
        self.taskEntryTextField.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8).isActive = true
        self.taskEntryTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4).isActive = true

        self.taskEntryButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.taskEntryButton.leftAnchor.constraint(equalToSystemSpacingAfter: self.taskEntryTextField.rightAnchor, multiplier: 3).isActive = true
        self.taskEntryButton.addTarget(self, action: #selector(addListEntry), for: .touchUpInside)
    }

    @objc func addListEntry() {
        self.viewController?.addChecklistItem(checklistItem: self.taskEntryTextField.text!)
        self.taskEntryTextField.text = ""
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 }

class TaskCell: UITableViewCell {
    
    let taskItemLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(self.taskItemLabel)
        setupViews()
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    func setupViews() {
        self.taskItemLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.contentView.topAnchor, multiplier: 1.5).isActive = true
//        taskItemLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.taskItemLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.contentView.leftAnchor, multiplier: 1.5).isActive = true
        self.taskItemLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
