//
//  TextToastView.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import UIKit

public class TextToastView: UIStackView {
    
    private lazy var titleLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var subtitleLabel: UILabel = {
        UILabel()
    }()
    
    public init(
        _ title: NSAttributedString,
        subtitle: NSAttributedString? = nil,
        viewConfig: ToastViewConfiguration
    ) {
        super.init(frame: CGRect.zero)
        commonInit()
        
        self.titleLabel.attributedText = title
        self.titleLabel.numberOfLines = viewConfig.titleNumberOfLines
        addArrangedSubview(self.titleLabel)
        
        if let subtitle = subtitle {
            self.subtitleLabel.attributedText = subtitle
            self.subtitleLabel.numberOfLines = viewConfig.subtitleNumberOfLines
            addArrangedSubview(self.subtitleLabel)
        }
    }
    
    public init(
        _ title: String,
        subtitle: String? = nil,
        viewConfig: ToastViewConfiguration
    ) {
        super.init(frame: CGRect.zero)
        commonInit()
        
        self.titleLabel.text = title
        self.titleLabel.numberOfLines = viewConfig.titleNumberOfLines
        self.titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        addArrangedSubview(self.titleLabel)
        
        if let subtitle = subtitle {
            self.subtitleLabel.textColor = .systemGray
            self.subtitleLabel.text = subtitle
            self.subtitleLabel.numberOfLines = viewConfig.subtitleNumberOfLines
            self.subtitleLabel.font = .systemFont(ofSize: 12, weight: .bold)
            addArrangedSubview(self.subtitleLabel)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        axis = .vertical
        alignment = .center
        distribution = .fillEqually
    }
    
}