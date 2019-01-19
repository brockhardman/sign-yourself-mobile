

import Foundation

extension UIImage {
    /**
     Creates an image from a desired color.
     - Parameter color: Color the image will be
     - Parameter bounds: The size of the image.
     
     - Returns: Image from Color.
     */
    public class func from(_ color: UIColor, bounds: CGRect) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(color.cgColor);
        context?.fill(bounds);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!;
    }
    
    /// Apply color to an image
    ///
    /// - Parameters:
    ///   - color: Color that is applied to image
    /// - Returns: Image filled with color
    public func apply(color: UIColor) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.colorBurn)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        if let cgImage = self.cgImage {
            context?.draw(cgImage, in: rect)
            context?.setBlendMode(CGBlendMode.sourceIn)
            context?.addRect(rect)
            context?.drawPath(using: CGPathDrawingMode.fill)
            
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return colorImage
        }
        
        return nil
    }
    
    /// Overlay color to an image
    ///
    /// - Parameters:
    ///   - color: Color that is overlayed to image
    /// - Returns: Image with color overlay
    public func overlay(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale);
        let context = UIGraphicsGetCurrentContext();
        color.setFill()
        
        context?.translateBy(x: 0, y: self.size.height);
        context?.scaleBy(x: 1.0, y: -1.0);
        
        context?.setBlendMode(CGBlendMode.colorBurn);
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height);
        context?.draw(self.cgImage!, in: rect);
        
        context?.setBlendMode(CGBlendMode.sourceIn);
        context?.addRect(rect);
        context?.drawPath(using: CGPathDrawingMode.fill);
        
        let coloredImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return coloredImg!;
    }
    
    /// Scales image from CGAffineTransform
    ///
    /// - Parameter transform: CGAffineTransformMakeScale
    /// - Returns: Scaled Image.
    public func scale(transform : CGAffineTransform) -> UIImage {
        
        let size = self.size.applying(transform)
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    /// Fixes orientation of image back to up
    ///
    /// - Returns: Image with a orientation of up
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case UIImage.Orientation.down, UIImage.Orientation.downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
            break
        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi/2))
            break
        case UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi/2))
            break
        case UIImage.Orientation.up, UIImage.Orientation.upMirrored:
            break
        }
        
        switch self.imageOrientation {
        case UIImage.Orientation.upMirrored, UIImage.Orientation.downMirrored:
            transform.translatedBy(x: self.size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case UIImage.Orientation.leftMirrored, UIImage.Orientation.rightMirrored:
            transform.translatedBy(x: self.size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case UIImage.Orientation.up, UIImage.Orientation.down, UIImage.Orientation.left, UIImage.Orientation.right:
            break
        }
        
        let ctx:CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch self.imageOrientation {
        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored, UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
            
            ctx.draw(self.cgImage!, in: CGRect(x:0, y:0, width:self.size.height, height:self.size.width))
            break
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y:0, width:self.size.width, height:self.size.height))
            break
        }
        
        let cgimg:CGImage = ctx.makeImage()!
        let img:UIImage = UIImage(cgImage: cgimg)
        
        return img
    }
    
    /// Resizes an image instance.
    ///
    /// - parameter size: The new size of the image.
    /// - returns: A new resized image instance.
    public func resized(to size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    
    /// Resizes an image instance to fit inside a constraining size while keeping the aspect ratio.
    ///
    /// - parameter size: The constraining size of the image.
    /// - returns: A new resized image instance.
    public func aspectFit(in size: CGSize) -> UIImage {
        let newSize = size.aspectFit(size: size)
        return resized(to: newSize)
    }
    
    /// Resizes an image instance to fill a constraining size while keeping the aspect ratio.
    ///
    /// - parameter size: The constraining size of the image.
    /// - returns: A new resized image instance.
    public func aspectFill(in size: CGSize) -> UIImage {
        let newSize = size.aspectFill(size: size)
        return resized(to: newSize)
    }
    
    /// Returns a new `UIImage` instance using raw image data and a size.
    ///
    /// - parameter data: Raw image data.
    /// - returns: A new image instance from the passed in data.
    public class func image(from data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    /// Returns a new `UIImage` instance using size, color and (optional line width).
    ///
    /// - parameter size: size of the paging dot
    /// - parameter color: color of the paging dot border
    /// - returns: A new image instance from the passed in data.
    public class func outlinedEllipse(size: CGSize, color: UIColor, lineWidth: CGFloat = 1.0) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth * 0.5, dy: lineWidth * 0.5)
        context.addEllipse(in: rect)
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
