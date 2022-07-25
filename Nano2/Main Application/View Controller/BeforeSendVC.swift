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
    
    private lazy var headingLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: "Before we send, one last check")
        return label
    }()
    
    private lazy var reflectionTitleLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: "Nano Challenge 2 - Day 01")
        label.font = UIFont(name: "Raleway-Bold", size: 20)
        return label
    }()
    
    private lazy var reflectionEmojiLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: "Your mood today: 😉")
        label.font = UIFont(name: "Raleway-Bold", size: 16)
        return label
    }()
    
    private lazy var textView: UITextView = {
        let tv = AppTextView(style: .nonEditable ,placeholderText: "Write it down here...")
        tv.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi lacus tellus, auctor vel facilisis ac, scelerisque a diam. Mauris at imperdiet orci. Nulla ac velit ut mauris aliquet varius. Cras vitae nibh eu nunc suscipit placerat ac ut ipsum. Suspendisse vestibulum et ante hendrerit ornare. Cras dignissim laoreet risus at egestas. Proin purus ante, luctus et lacinia non, rhoncus a nisl. Vestibulum pulvinar, nunc in eleifend pharetra, nulla sem hendrerit ligula, at fermentum est arcu ut massa. Sed vitae mi sit amet libero ullamcorper efficitur. Quisque volutpat ornare lacus, vitae dapibus nisl varius quis. Aenean et purus lobortis, ornare lorem a, tincidunt diam. Sed tempus felis id imperdiet malesuada. Morbi ullamcorper suscipit augue, fringilla semper erat pellentesque quis.Morbi hendrerit aliquam massa, ac euismod quam sollicitudin ac. Praesent commodo nisl quis sem lacinia rhoncus. Etiam at sollicitudin ligula. Donec leo mauris, ornare id placerat at, rhoncus vitae elit. Nam hendrerit feugiat velit. Fusce eu pretium massa. Proin lacinia eu mi vel condimentum. Ut sit amet est in neque bibendum aliquam.In tristique dignissim quam interdum lobortis. Sed a orci a sapien interdum dignissim. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed venenatis, libero nec luctus imperdiet, lectus justo tempus tortor, non bibendum elit ipsum sed mi. Sed nec sodales leo, et fermentum justo. Sed sit amet nunc eleifend, lacinia augue nec, hendrerit ligula. Aliquam neque neque, suscipit ac enim ut, blandit commodo sapien. Aenean tincidunt dolor aliquam sem pulvinar sollicitudin.Vestibulum maximus dolor arcu, vitae bibendum est maximus eget. Cras risus nulla, ornare et sodales placerat, ullamcorper eu eros. Praesent varius velit bibendum feugiat accumsan. Vivamus in cursus quam, quis pellentesque ipsum. Curabitur vel vestibulum risus. Sed finibus lectus vitae magna hendrerit tincidunt. Nulla nec aliquet nulla, in posuere massa. Aenean nec elit in arcu convallis luctus. Vestibulum nec turpis quis arcu ullamcorper eleifend. Vivamus ac nunc ornare risus tempor vulputate. Ut efficitur est vel lacus interdum ultrices. Sed egestas ipsum varius, dapibus orci sed, congue quam. Vivamus lorem metus, porttitor non condimentum vel, consectetur tempor ante.Quisque convallis eros et odio venenatis, vitae pellentesque massa mattis. Donec magna arcu, sollicitudin ac nunc quis, pulvinar lacinia sapien. Duis vitae suscipit nunc. Nulla ullamcorper fermentum odio, eu cursus nisi mollis eget. In pretium consectetur libero, eget efficitur metus condimentum ac. Suspendisse laoreet luctus velit nec interdum. Nam ut accumsan enim, nec gravida enim. Interdum et malesuada fames ac ante ipsum primis in faucibus. Mauris tempus tortor sit amet arcu consequat porttitor. Donec bibendum sapien urna, sed pulvinar neque auctor ac. Aliquam ipsum risus, tempor id aliquam nec, scelerisque eu ante. Sed maximus turpis ut turpis interdum eleifend. Quisque commodo turpis et nisl tincidunt scelerisque. Pellentesque eget massa ut turpis lobortis placerat sit amet quis arcu. Duis maximus vulputate rutrum."
        return tv
    }()
    
    private lazy var sendButton: AppButton = {
        let button = AppButton(style: .normal, text: "Send", #selector(handleSendButtonTapped), self)
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
//        UserDefaults.standard.set(textView.text ?? "", forKey: "reflectionBody")
//        navigationController?.popViewController(animated: true)
        print(UserDefaults.standard.string(forKey: "reflectionBody"))
    }
    
    @objc func handleSendButtonTapped() {
        print("SEND")
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
            paddingBottom: 5
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
