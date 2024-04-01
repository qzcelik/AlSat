//
//  MessageViewController.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 1.04.2024.
//

import UIKit

class MessageViewController: UIViewController {

    let messageListContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    var messageQueue : [String] = []
    
    let messageInput : UITextField = {
        let textBox = UITextField()
        textBox.layer.cornerRadius = ConstantVariable.cornerRadius
        textBox.placeholder = "Mesajınızı Yazın"
        textBox.layer.borderWidth  = 1
        textBox.layer.borderColor  = UIColor.white.cgColor
        return textBox
    }()
    
    let sendMessageButton : UIButton = {
       let button = UIButton()
       button.layer.cornerRadius = ConstantVariable.cornerRadius
       button.setImage(UIImage(systemName:"paperplane"), for: [])
       button.tintColor = .white
       return button
    }()
    
    let messageBottomPanel : UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        prepareUI()
        constraint()
    }
    
    func prepareUI()
    {
        view.addSubview(messageBottomPanel)
        messageBottomPanel.addSubview(sendMessageButton)
        messageBottomPanel.addSubview(messageInput)
        view.addSubview(messageListContainer)
        sendMessageButton.addTarget(self, action: #selector(addMessageToQuee), for: .touchUpInside)
    }
    
    @objc func addMessageToQuee()
    {
        messageQueue.append(messageInput.text ?? "")
        refreshMessageView()
    }
    
    func refreshMessageView()
    {
        let messageView = MessageTableViewController(messages: messageQueue)
        messageView.willMove(toParent: self)
        self.messageListContainer.addSubview(messageView.view)
        messageView.view.frame = self.messageListContainer.bounds
        self.addChild(messageView)
        messageView.didMove(toParent: self)
        messageInput.text = ""
    }
    
    func constraint()
    {
        messageBottomPanel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.centerY.top.equalToSuperview().offset(310)
        }
        
        messageInput.snp.makeConstraints { make in
            make.width.equalTo(325)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
            make.leftMargin.equalTo(15)
        }
        
        sendMessageButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview().offset(175)
            make.centerY.equalToSuperview()
        }
        
        messageListContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(600)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(30)
        }
    }

}
