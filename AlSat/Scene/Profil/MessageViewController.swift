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
        return view
    }()
    
    var productData : ProductModel = ProductModel()
    var messageData : MessageModel = MessageModel()
    var messageQueue : [MessageShowModel] = []
    
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
        getMessageData()
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
        dismissKeyboard()
    }
    
    @objc func addMessageToQuee()
    {
        var messageShowModel = MessageShowModel()
        messageShowModel.message = messageInput.text ?? ""
        messageShowModel.labelTextAlign = "right"
        messageQueue.append(messageShowModel)
        
        
        var parameters : [String:Any] = [
            "userId" : "",
            "productId" : "",
            "ownerId" : "",
            "message" : "",
            "textAlign" : ""
        ]
        
        if(productData.id != nil)
        {
            parameters = [
               "userId" : LoginViewController.user.id!,
               "productId" :   productData.id ?? "",
               "ownerId" : productData.userId ?? "",
               "message" : messageInput.text ?? "",
               "textAlign" : "left"
           ]
        }
        else
        {
            parameters = [
               "userId" :  messageData.userId ?? "",
               "productId" : messageData.productId ?? "",
               "ownerId" : LoginViewController.user.id!,
               "message" : messageInput.text ?? "",
               "textAlign" : "right"
           ]
        }
        
        MessageService().request(url: "messages.php", parameters: parameters, method: .post){(result) -> () in}
        refreshMessageView()
    }
    
    func dismissKeyboard()
    {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    func getMessageData()
    {
        var parameters : [String:Any] = [
            "userId" : "0",
            "ownerId" :  "0",
            "productId" : "0"
        ]
        
        if(productData.id != nil)
        {
            parameters = [
                "userId" : LoginViewController.user.id!,
                "ownerId" : productData.userId ?? "",
                "productId" :   productData.id ?? ""
            ]
        }
        else
        {
            parameters = [
                "userId" : messageData.userId ?? "",
                "ownerId" : LoginViewController.user.id!,
                "productId" :   messageData.productId ?? ""
            ]
        }
            
        
        MessageService().request(url: "messageGetData.php", parameters: parameters, method: .post){(result) -> () in
           
            for item in result
            {
                  let resultMessageData =  item as? MessageModel
                  var messageShowModel = MessageShowModel()
                  messageShowModel.message = resultMessageData?.message ?? ""
              
                if(self.productData.id != nil)
                  {
                      if(resultMessageData?.textAlign! == "right")
                          {
                              messageShowModel.labelTextAlign = "left"
                          }
                          else
                          {
                              messageShowModel.labelTextAlign = "right"
                          }
                  }
                else
                {
                    if(resultMessageData?.textAlign! == "right")
                        {
                            messageShowModel.labelTextAlign = "right"
                        }
                        else
                        {
                            messageShowModel.labelTextAlign = "left"
                        }
                }
                
                
                self.messageQueue.append(messageShowModel)
            }
            self.refreshMessageView()
        }
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
