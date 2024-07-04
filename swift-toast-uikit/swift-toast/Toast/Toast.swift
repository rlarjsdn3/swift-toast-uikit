//
//  Toast.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import UIKit

public class Toast {
    
    // MARK: - Properties
    
    private static var activeToasts = [Toast]()
    
    public let view: ToastView
    private var backgroundView: UIView?
    
    private var closeTimer: Timer?
    
    private var startY: CGFloat = 0
    private var startShiftY: CGFloat = 0
    
    public static var defaultImageTint: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }
    
    private var multicast = MulticastDelegate<ToastDelegate>()
    
    public private(set) var config: ToastConfiguration
    
    
    // MARK: - Intializer
    
    public required init(view: ToastView, config: ToastConfiguration) {
        self.config = config
        self.view = view
        
        for dismissable in config.dismissables {
            switch dismissable {
            case .tap:
                enableTapToClose()
            case .longPress:
                enableLongPressToClose()
            case .swipe:
                enablePanToClose()
            default:
                break
            }
        }
        
    }
    
    
    
    // MARK: - Toast
    
    public static func text(
        _ title: NSAttributedString,
        subtitle: NSAttributedString? = nil,
        viewConfig: ToastViewConfiguration = ToastViewConfiguration(),
        config: ToastConfiguration = ToastConfiguration()
    ) -> Toast {
        let view = AppleToastView(
            child: TextToastView(
                title,
                subtitle: subtitle,
                viewConfig: viewConfig
            ),
            viewConfig: viewConfig
        )
        return self.init(view: view, config: config)
    }
    
    public static func text(
        _ title: String,
        subtitle: String? = nil,
        viewConfig: ToastViewConfiguration = ToastViewConfiguration(),
        config: ToastConfiguration = ToastConfiguration()
    ) -> Toast {
        let view = AppleToastView(
            child: TextToastView(
                title,
                subtitle: subtitle,
                viewConfig: viewConfig
            ),
            viewConfig: viewConfig
        )
        return self.init(view: view, config: config)
    }
    
    public static func `default`(
        image: UIImage,
        imageTint: UIColor? = defaultImageTint,
        title: NSAttributedString,
        subtitle: NSAttributedString? = nil,
        viewConfig: ToastViewConfiguration = ToastViewConfiguration(),
        config: ToastConfiguration = ToastConfiguration()
    ) -> Toast {
        let view = AppleToastView(
            child: IconAppleToastView(
                image: image,
                imageTint: imageTint,
                title: title,
                subtitle: subtitle,
                viewConfig: viewConfig
            ),
            viewConfig: viewConfig
        )
        return self.init(view: view, config: config)
    }
    
    public static func `default`(
        image: UIImage,
        imageTint: UIColor? = defaultImageTint,
        title: String,
        subtitle: String? = nil,
        viewConfig: ToastViewConfiguration = ToastViewConfiguration(),
        config: ToastConfiguration = ToastConfiguration()
    ) -> Toast {
        let view = AppleToastView(
            child: IconAppleToastView(
                image: image,
                imageTint: imageTint,
                title: title,
                subtitle: subtitle,
                viewConfig: viewConfig
            ),
            viewConfig: viewConfig
        )
        return self.init(view: view, config: config)
    }
    
    public static func custom(
        view: ToastView,
        config: ToastConfiguration = ToastConfiguration()
    ) -> Toast {
        self.init(view: view, config: config)
    }
    
    
    // MARK: - Show
    
#if !os(tvOS)
    public func show(haptic type: UINotificationFeedbackGenerator.FeedbackType, after time: TimeInterval = 0) {
        UINotificationFeedbackGenerator().notificationOccurred(type)
        show(after: time)
    }
#endif
    
    public func show(after delay: TimeInterval = 0) {
        if let backgroundView = self.createBackgroundView() {
            self.backgroundView = backgroundView
            config.view?.addSubview(backgroundView) ?? ToastHelper.topController()?.view.addSubview(backgroundView)
        }
        
        config.view?.addSubview(view) ?? ToastHelper.topController()?.view.addSubview(view)
        view.createView(for: self)
        
        multicast.invoke { $0.willShowToast(self) }
        
        config.enteringAnimation.apply(to: self.view)
        let endBackgroundColor = backgroundView?.backgroundColor
        backgroundView?.backgroundColor = .clear
        UIView.animate(withDuration: config.animationTime, delay: delay, options: [.curveEaseIn, .allowUserInteraction]) {
            self.config.enteringAnimation.undo(from: self.view)
            self.backgroundView?.backgroundColor = endBackgroundColor
        } completion: { [self] _ in
            multicast.invoke { $0.didShowToast(self) }
            
            configureCloseTimer()
            if !config.allowToastOverlap {
                closeOverlappedToasts()
            }
            Toast.activeToasts.append(self)
        }

    }
        
    
    // MARK: - Close
    
    public func close(animated: Bool = true, completion: (() -> Void)? = nil) {
        multicast.invoke { $0.willCloseToast(self) }
        
        UIView.animate(withDuration: config.animationTime, delay: 0, options: [.curveEaseIn]) {
            if animated {
                self.config.exitingAnimation.apply(to: self.view)
            }
            self.backgroundView?.backgroundColor = .clear
        } completion: { _ in
            self.backgroundView?.removeFromSuperview()
            self.view.removeFromSuperview()
            if let index = Toast.activeToasts.firstIndex(where: { $0 === self }) {
                Toast.activeToasts.remove(at: index)
            }
            completion?()
            self.multicast.invoke { $0.didCloseToast(self) }
        }

    }
    
    private func closeOverlappedToasts() {
        Toast.activeToasts.forEach {
            $0.closeTimer?.invalidate()
            $0.close(animated: false)
        }
    }
    
}


// MARK: - Extensions

extension Toast {
    
    public func addDelegate(delegate: ToastDelegate) -> Void {
        multicast.add(delegate)
    }
    
    private func createBackgroundView() -> UIView? {
        switch config.background {
        case .none:
            return nil
        case .color(let color):
            let backgroundView = UIView(frame: config.view?.frame
                                    ?? ToastHelper.topController()?.view.frame ?? .zero)
            backgroundView.backgroundColor = color
            backgroundView.layer.zPosition = 998 // ⭐️
            return backgroundView
        }
    }
    
}

extension Toast {
    
    private func enablePanToClose() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(toastOnPan(_:)))
        self.view.addGestureRecognizer(pan)
    }
    
    @objc private func toastOnPan(_ gesture: UIPanGestureRecognizer) {
        guard
            let topVc = ToastHelper.topController()
        else { return }
        
        switch gesture.state {
        case .began:
            startY = self.view.frame.origin.y
            startShiftY = gesture.location(in: topVc.view).y
            closeTimer?.invalidate()
            
        case .changed:
            let delta = gesture.location(in: topVc.view).y - startShiftY
            
            for dismissable in config.dismissables {
                if case .swipe(let dismissSwipeDirection) = dismissable {
                    let shouldApply = dismissSwipeDirection.shouldApply(delta, direction: config.direction)
                    
                    if shouldApply {
                        self.view.frame.origin.y = startY + delta
                    }
                }
            }
            
        case .ended:
            let threshold = 15.0
            let amountOfUserDragged = abs(startY - self.view.frame.origin.y)
            let shouldDismissToast = amountOfUserDragged > threshold
            
            if shouldDismissToast {
                close()
            } else {
                UIView.animate(withDuration: config.animationTime, delay: 0, options: [.curveEaseOut, .allowUserInteraction]) {
                    self.view.frame.origin.y = self.startY
                } completion: { [self] _ in
                    configureCloseTimer()
                }
            }
            
        case .cancelled, .failed:
            configureCloseTimer()
        default:
            break
        }
    }
    
    private func enableTapToClose() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(toastOnTap))
        self.view.addGestureRecognizer(tap)
    }
    
    private func enableLongPressToClose() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(toastOnTap))
        self.view.addGestureRecognizer(longPress)
        
    }
    
    @objc func toastOnTap(_ gesture: UITapGestureRecognizer) {
        closeTimer?.invalidate()
        close()
    }
    
    
    private func configureCloseTimer() {
        for dismissable in config.dismissables {
            if case .time(let delayTime) = dismissable {
                closeTimer = Timer.scheduledTimer(withTimeInterval: delayTime, repeats: false) { [self] _ in
                    close()
                }
            }
        }
    }
    
}

extension Toast: Equatable {
    
    public static func == (lhs: Toast, rhs: Toast) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
}
