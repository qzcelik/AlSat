//
//  MessageTableViewController.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 1.04.2024.
//

import UIKit

class MessageTableViewController: UIViewController {

    var messagesList : [MessageShowModel]
    
    init(messages: [MessageShowModel]) {
        messagesList = messages
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let messageTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableView.dataSource = self
        messageTableView.delegate = self
        view.addSubview(messageTableView)
        constraint()
    }
    
    func constraint()
    {
        messageTableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
    
}

extension MessageTableViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text  = messagesList[indexPath.row].message
        cell.backgroundColor = .orange
        if(messagesList[indexPath.row].labelTextAlign! == "right")
        {
            cell.textLabel?.textAlignment = .right
        }
        else
        {
            cell.textLabel?.textAlignment = .left
        }
        return cell
    }
    
    
}

