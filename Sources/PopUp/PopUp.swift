import UIKit

@available(iOS 10.0, *)
open class PopUp: NSObject {
    
    public var view: UIView
    var tapGes: UITapGestureRecognizer?
    let backgroundV = UIView()
    public var backgroundColor = UIColor.black.withAlphaComponent(0.3)
    public var isShowingPopUp = false
    
    public init(view: UIView) {
        self.view = view
        backgroundV.backgroundColor = self.backgroundColor
        super.init()
        tapGes = .init(target: self, action: #selector(dismiss))
        tapGes?.delegate = self
        backgroundV.addGestureRecognizer(tapGes!)
    }
    convenience public init(view: UIView, backgroundColor: UIColor) {
        self.init(view: view)
        self.backgroundColor = backgroundColor
        backgroundV.backgroundColor = self.backgroundColor
    }
    
    public func showPopUp() {
        if isShowingPopUp { return }
        let _window: UIWindow?
        if #available(iOS 13.0, *) {
            _window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
            
        } else {
            guard let _tempWindow = UIApplication.shared.delegate?.window else { return }
            _window = _tempWindow
            
        }
        guard let window = _window else { return }
        
        window.addSubview(backgroundV)
        backgroundV.frame = window.bounds
        addViewToBackground()
        isShowingPopUp = true
    }
    
    fileprivate func addViewToBackground() {
        backgroundV.addSubview(self.view)
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: backgroundV.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: backgroundV.centerYAnchor)
        ])
        view.sizeToFit()
    }

    @objc public func dismiss() {
        self.view.removeFromSuperview()
        self.backgroundV.removeFromSuperview()
        isShowingPopUp = false
    }
    
    public func toggle() {
        isShowingPopUp ? dismiss() : showPopUp()
    }
}

@available(iOS 10.0, *)
extension PopUp: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.backgroundV
    }
}
