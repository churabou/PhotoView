import UIKit

class BaseView: UIView {
    
    fileprivate var constraintsInitialized = false
    
    var skipInitializer: Bool {
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if !skipInitializer {
            initializeView()
        }
    }
    
    override func updateConstraints() {
        if !constraintsInitialized {
            constraintsInitialized = true
            initializeConstraints()
        }
        modifyConstraints()
        super.updateConstraints()
    }
    
    func initializeView() { /* don't write code here */ }
    func initializeConstraints() { /* don't write code here */ }
    func modifyConstraints() { /* don't write code here */ }
}

