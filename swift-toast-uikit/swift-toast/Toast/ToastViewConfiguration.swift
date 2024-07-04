//
//  ToastViewConfiguration.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import UIKit

public struct ToastViewConfiguration {
    
    // MARK: - Properties
    
    public let minWidth: CGFloat
    public let minHeight: CGFloat
    
    public let yOffset: CGFloat
    
    public let darkBackgroundColor: UIColor
    public let lightBackgroundColor: UIColor
    
    public let isShowingShadow: Bool
    
    public let titleNumberOfLines: Int
    public let subtitleNumberOfLines: Int
    
    public let cornerRadius: CGFloat?
    
    
    // MARK: - Intializer
    
    public init(
        minWidth: CGFloat = 150,
        minHeight: CGFloat = 58,
        yOffset: CGFloat = 0,
        darkBackgroundColor: UIColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0),
        lightBackgroundColor: UIColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.0),
        titleNumberOfLines: Int = 1,
        subtitleNumberOfLines: Int = 1,
        isShowingShadow: Bool = true,
        cornerRadius: CGFloat? = nil
    ) {
        self.minWidth = minWidth
        self.minHeight = minHeight
        self.yOffset = yOffset
        self.darkBackgroundColor = darkBackgroundColor
        self.lightBackgroundColor = lightBackgroundColor
        self.titleNumberOfLines = titleNumberOfLines
        self.subtitleNumberOfLines = subtitleNumberOfLines
        self.isShowingShadow = isShowingShadow
        self.cornerRadius = cornerRadius
    }
    
}
