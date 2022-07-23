//
//  ViewController.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 22/07/22.
//

import UIKit

class FirstDownloadView: UIViewController {

    let button1 = AppButton(style: .normal, text: "Button")
    let button2 = AppButton(style: .destructive, text: "Button")
    let button3 = AppButton(style: .disabled, text: "Button")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        let stack = UIStackView(arrangedSubviews: [button1, button2, button3])
        stack.axis = .vertical
        stack.spacing = 150
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
    }
}

