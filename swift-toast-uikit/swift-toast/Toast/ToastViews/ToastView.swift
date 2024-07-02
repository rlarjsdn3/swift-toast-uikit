//
//  ToastView.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import UIKit

public protocol ToastView: UIView {
    func createView(for toast: Toast)
}
