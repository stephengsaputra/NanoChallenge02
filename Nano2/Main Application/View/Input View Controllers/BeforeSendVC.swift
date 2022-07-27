//
//  BeforeSendVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit

class BeforeSendVC: UIViewController {

    //MARK: - Properties
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .textColor
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var headingLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "Before we send, one last check")
        return label
    }()
    
    private lazy var reflectionTitleLabel: RLabel = {
        let label = RLabel(style: .heading, textString: UserDefaults.standard.string(forKey: "reflectionTitle") ?? "")
        label.font = UIFont(name: "Raleway-Bold", size: 20)
        return label
    }()
    
    private lazy var reflectionEmojiLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "Your mood today: \(UserDefaults.standard.string(forKey: "emoji") ?? "")")
        label.font = UIFont(name: "Raleway-Bold", size: 16)
        return label
    }()
    
    private lazy var textView: UITextView = {
        let tv = RTextView(style: .nonEditable ,placeholderText: "Write it down here...")
        tv.text = UserDefaults.standard.string(forKey: "reflectionBody")
        return tv
    }()
    
    private lazy var sendButton: RTButton = {
        let button = RTButton(isEnabled: true, style: .normal, text: "Send", #selector(handleSendButtonTapped), self)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    //MARK: - Selectors
    @objc func handleBackButtonTapped() {
        navigationController?.popViewController(animated: true)
        print(UserDefaults.standard.string(forKey: "reflectionBody"))
    }
    
    @objc func handleSendButtonTapped() {
        
//        Helper.sendReflection()
        sendReflection()
    }
    
    //MARK: - Helpers
    private func configureUI() {
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(backButton)
        backButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            paddingTop: 26,
            paddingLeft: 20
        )
        
        view.addSubview(headingLabel)
        headingLabel.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 151,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        view.addSubview(reflectionTitleLabel)
        reflectionTitleLabel.anchor(
            top: headingLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 32,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        view.addSubview(reflectionEmojiLabel)
        reflectionEmojiLabel.anchor(
            top: reflectionTitleLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 10,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        view.addSubview(sendButton)
        sendButton.centerX(inView: view)
        sendButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingLeft: 20,
            paddingBottom: 20
        )
        
        view.addSubview(textView)
        textView.anchor(
            top: reflectionEmojiLabel.bottomAnchor,
            left: view.leftAnchor,
            bottom: sendButton.topAnchor,
            right: view.rightAnchor,
            paddingTop: 16,
            paddingLeft: 20,
            paddingBottom: 20,
            paddingRight: 20
        )
    }
}

extension BeforeSendVC {
    
    func sendReflection() {
        
        let url = URL(string: "https://api.notion.com/v1/pages")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        request.allHTTPHeaderFields = [
            "Authorization"  : "Bearer \(UserDefaults.standard.string(forKey: "integrationToken")!)",
            "Content-Type"   : "application/json",
            "Notion-Version" : "2022-06-28"
        ]

        request.httpBody = try! JSONSerialization.data(withJSONObject: [
            "parent": [
                "database_id": "\(UserDefaults.standard.string(forKey: "databaseID")!)"
            ],
            "icon": [
                "type": "emoji",
                "emoji": "\(UserDefaults.standard.string(forKey: "emoji") ?? "")"
            ],
            "properties": [
                "title": [
                    [
                        "type": "text",
                        "text": [
                            "content": UserDefaults.standard.string(forKey: "reflectionTitle")!
                        ]
                    ]
                ]
            ],
            "children": [
                [
                    "object": "block",
                    "type": "heading_2",
                    "heading_2": [
                        "rich_text": [[ "type": "text", "text": [ "content": "What did you do today?" ] ]]
                    ]
                ],
                [
                    "object": "block",
                    "type": "paragraph",
                    "paragraph": [
                        "rich_text": [
                            [
                                "type": "text",
                                "text": [
                                    "content": UserDefaults.standard.string(forKey: "reflectionBody")!
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ])

        URLSession.shared.dataTask(with: request) { (data, response, error) in

            Helper.getNetworkResponse(data: data, response: response, error: error)
            let httpResponse = response as? HTTPURLResponse

            if httpResponse?.statusCode == 200 {
                print("Success")
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(SuccessSubmitVC(), animated: true)
                }
            } else {
                print("Failed")
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(FailedSubmitVC(), animated: true)
                }
            }
        }
        .resume()
    }
}
