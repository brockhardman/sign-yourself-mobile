//
//  UIToolbar+Extension.swift
//  Reliant
//
//  Created by Yuichi Fujiki on 11/16/16.
//  Copyright © 2016 Relaint. All rights reserved.
//

import Foundation

extension UIToolbar {

    /// A lot of keyboard uses tool bar with 'done' button on the right side.
    /// You should call this method on those occasions in order to have unified look.
    ///
    /// - Parameters:
    ///   - target: target object that has selector method implementation
    ///   - selector: selector method that is invoked on tapping the 'done' button.
    /// - Returns: UIToolbar instance with the 'done' button on the right.
    static func doneButtonKeyboardAccessoryToolBar(target: Any, selector: Selector) -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        ]
        toolbar.sizeToFit()

        return toolbar
    }
}
