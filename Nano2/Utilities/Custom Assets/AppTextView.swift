//
//  AppTextView.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit

class AppTextView: UITextView {

    enum Style {
        case editable
        case nonEditable
    }
    
    //MARK: - Initializers
    public private(set) var style: Style
    public private(set) var placeholderText: String
    
    init(style: Style, placeholderText: String) {
        
        self.style = style
        self.placeholderText = placeholderText
        
        super.init(frame: .zero, textContainer: nil)
        configureTV()
        
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func configureTV() {
        
        configureTVStyle()
    }
    
    private func configureTVStyle() {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = CGFloat(24)
        paragraphStyle.maximumLineHeight = CGFloat(24)
        
        switch style {
        case .editable:
            self.textColor = UIColor(named: "tFHintTextColor")
        case .nonEditable:
            self.textColor = .textColor
            self.isEditable = false
            self.attributedText = NSAttributedString(
                string: placeholderText,
                attributes: [
                    .paragraphStyle: paragraphStyle,
                    .font: UIFont.body()
                ])
        }
        
        self.backgroundColor = .clear
        self.autocapitalizationType = .none
        self.keyboardType = .default
        self.font = UIFont.body()
        self.text = placeholderText
    }
}

extension AppTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor(named: "tFHintTextColor") {
            textView.text = nil
            textView.textColor = .textColor
        }
    }
}
