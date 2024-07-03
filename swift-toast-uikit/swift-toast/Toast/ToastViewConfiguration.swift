//
//  ToastViewConfiguration.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import UIKit

public struct ToastViewConfiguration {
    
    public let minWidth: CGFloat
    public let minHeight: CGFloat
    
    public let darkBackgroundColor: UIColor
    public let lightBackgroundColor: UIColor
    
    public let titleNumberOfLines: Int
    public let subtitleNumberOfLines: Int
    
    public let cornerRadius: CGFloat?
    
    public init(
        minWidth: CGFloat = 150,
        minHeight: CGFloat = 58,
        darkBackgroundColor: UIColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0),
        lightBackgroundColor: UIColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.0),
        titleNumberOfLines: Int = 1,
        subtitleNumberOfLines: Int = 1,
        cornerRadius: CGFloat? = nil
    ) {
        self.minWidth = minWidth
        self.minHeight = minHeight
        self.darkBackgroundColor = darkBackgroundColor
        self.lightBackgroundColor = lightBackgroundColor
        self.titleNumberOfLines = titleNumberOfLines
        self.subtitleNumberOfLines = subtitleNumberOfLines
        self.cornerRadius = cornerRadius
    }
    
}
