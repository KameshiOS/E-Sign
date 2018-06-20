//
//  ImageViewDesign.swift
//  E-Sign
//
//  Created by Kamesh on 19/06/18.
//  Copyright © 2018 fashionexpress. All rights reserved.
//

import UIKit

@IBDesignable class ImageViewDesign: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    func updateView() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
        clipsToBounds = true
    }
}
