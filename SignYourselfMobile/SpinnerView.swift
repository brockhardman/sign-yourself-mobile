//
//  SpinnerView.swift

import UIKit


/// Custom UIView that animates a spinner. The spinner is composed of circles that descrease in size and gradients from one color to another. 
open class SpinnerView: UIView {
    
    public var headColor: UIColor = UIColor.black
    public var tailColor: UIColor = UIColor.lightGray
    
    public var isAnimating: Bool  {
        if animationLayer.animation(forKey: "rotate") != nil {
            return true
        } else {
            return false
        }
    }
    
    private var animationLayer = CALayer()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        backgroundColor = UIColor.clear
    }

    public convenience init(headColor: UIColor, tailColor: UIColor) {
        self.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        backgroundColor = UIColor.clear
        self.headColor = headColor
        self.tailColor = tailColor
    }
    
    deinit {
        animationLayer.sublayers?.forEach({ (layer) in
            layer.removeFromSuperlayer()
        })
        animationLayer.removeAllAnimations()
        animationLayer.removeFromSuperlayer()
    }
    
    override open func draw(_ rect: CGRect) {
        
        guard !isAnimating else {
            return
        }
        
        // recreate AnimationLayer
        animationLayer.removeFromSuperlayer()
        animationLayer = CALayer()
        
        animationLayer.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        animationLayer.position = CGPoint(x: layer.position.x-layer.frame.origin.x, y: layer.position.y-layer.frame.origin.y)
        layer.addSublayer(animationLayer)
        
        // draw ActivityIndicator
        let colors: [CGColor] = getGradientColors()
        let paths: [CGPath] = spinnerPaths()
        
        for i in 0..<8 {
            let pathLayer = CAShapeLayer()
            pathLayer.frame = animationLayer.bounds
            pathLayer.fillColor = colors[i]
            pathLayer.lineWidth = 0
            pathLayer.path = paths[i]
            animationLayer.addSublayer(pathLayer)
        }
        
        startAnimating()
    }
    
    public func startAnimating() {
        if let _ = animationLayer.animation(forKey: "rotate") { return }
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = Double.pi*2
        animation.duration = 1.1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.isRemovedOnCompletion = false
        animation.repeatCount = Float(NSIntegerMax)
        animation.fillMode = kCAFillModeForwards
        animation.autoreverses = false
        
        animationLayer.isHidden = false
        animationLayer.add(animation, forKey: "rotate")
    }
}

private extension SpinnerView {
    
    func getGradientColors() -> [CGColor] {
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: 1, height: 70)
        gradient.colors = [headColor.cgColor, tailColor.cgColor]
        
        var colors: [CGColor] = [headColor.cgColor]
        colors.append(
            contentsOf: (1..<7).map {
                let point = CGPoint(x: 0, y: 10*CGFloat($0))
                return gradient.color(point: point).cgColor
            }
        )
        colors.append(tailColor.cgColor)
        
        return colors
    }
    
    func spinnerPaths() -> [CGPath] {
        return [
            UIBezierPath(ovalIn: CGRect(x: 12.013, y: 1.962, width: 8.336, height: 8.336)).cgPath,
            UIBezierPath(ovalIn: CGRect(x: 1.668, y: 14.14, width: 7.502, height: 7.502)).cgPath,
            UIBezierPath(ovalIn: CGRect(x: 2.792, y: 30.484, width: 6.668, height: 6.668)).cgPath,
            UIBezierPath(ovalIn: CGRect(x: 14.968, y: 41.665, width: 5.835, height: 5.835)).cgPath,
            UIBezierPath(ovalIn: CGRect(x: 31.311, y: 41.381, width: 5.001, height: 5.001)).cgPath,
            UIBezierPath(ovalIn: CGRect(x: 42.496, y: 30.041, width: 4.168, height: 4.168)).cgPath,
            UIBezierPath(ovalIn: CGRect(x: 42.209, y: 14.515, width: 3.338, height: 3.338)).cgPath,
            UIBezierPath(ovalIn: CGRect(x: 30.857, y: 4.168, width: 2.501, height: 2.501)).cgPath,
            ]
    }
}

private extension CAGradientLayer {
    func color(point: CGPoint) -> UIColor {
        var pixel: [CUnsignedChar] = [0, 0, 0, 0]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmap = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmap.rawValue)
        
        context?.translateBy(x: -point.x, y: -point.y)
        render(in: context!)
        
        let red: CGFloat = CGFloat(pixel[0])/255.0
        let green: CGFloat = CGFloat(pixel[1])/255.0
        let blue: CGFloat = CGFloat(pixel[2])/255.0
        let alpha: CGFloat = CGFloat(pixel[3])/255.0
        
        return UIColor(red:red, green: green, blue:blue, alpha:alpha)
    }
}
