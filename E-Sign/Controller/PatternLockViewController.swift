//
//  PatternLockViewController.swift
//  E-Sign
//
//  Created by Kamesh on 19/06/18.
//  Copyright © 2018 fashionexpress. All rights reserved.
//

import UIKit
import OXPatternLock
import CoreGraphics

class PatternLockViewController: UIViewController {

    @IBOutlet weak var patternView: OXPatternLock!
    var signaTureImage = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        patternView.delegate = self
        patternView.dot = UIImage(named: "dotSelect")
        patternView.dotSelected = UIImage(named: "dotSelect")
    }
    /*
 public func getSignature(scale:CGFloat = 1) -> UIImage? {
 if !doesContainSignature { return nil }
 UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, scale)
 self.strokeColor.setStroke()
 self.path.stroke()
 let signature = UIGraphicsGetImageFromCurrentImageContext()
 UIGraphicsEndImageContext()
 return signature
 }
 
 // Save the Signature (cropped of outside white space) as a UIImage
 public func getCroppedSignature(scale:CGFloat = 1) -> UIImage? {
 guard let fullRender = getSignature(scale:scale) else { return nil }
 let bounds = self.scale(path.bounds.insetBy(dx: -strokeWidth/2, dy: -strokeWidth/2), byFactor: scale)
 guard let imageRef = fullRender.cgImage?.cropping(to: bounds) else { return nil }
 return UIImage(cgImage: imageRef)
 }
 */
    public func getSignature(scale:CGFloat = 1) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(patternView.bounds.size, false, scale)
        let pattern = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return pattern
    }
}
extension PatternLockViewController: OXPatternLockDelegate {
    func didPatternInput(patterLock: OXPatternLock, track: [Int]) {
        print(track)
        let renderer = UIGraphicsImageRenderer(size: patternView.bounds.size)
        let image = renderer.image { (ctx) in
            patternView.drawHierarchy(in: patterLock.bounds, afterScreenUpdates: false)
        }
        signaTureImage = image
        UIImageWriteToSavedPhotosAlbum(signaTureImage, nil, nil, nil)
        let alertVC = UIAlertController(title: "Success", message: "Pattern Saved successfully", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        alertVC.addAction(UIAlertAction(title: "Open Photos", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
            UIApplication.shared.open(URL(string:"photos-redirect://")!)
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
}
extension UIImage {
    func imageBGColor(tintColor: UIColor, imageView: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        tintColor.setFill()
        let pattern = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return pattern!
    }
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        tintColor.setFill()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
