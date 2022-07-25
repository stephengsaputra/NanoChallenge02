//
//  AppTextView.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit

class AppTextView: UITextView {

    //MARK: - Initializers
    public private(set) var placeholderText: String
    
    init(placeholderText: String) {
        
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
        
        self.backgroundColor = .clear
        self.autocapitalizationType = .none
        self.keyboardType = .default
        self.textColor = .textColor
        self.font = UIFont.body()
        self.text = placeholderText
        self.textColor = UIColor(named: "tFHintTextColor")
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
