//
//  AddSignatureViewController.swift
//  E-Sign
//
//  Created by Kamesh on 19/06/18.
//  Copyright © 2018 fashionexpress. All rights reserved.
//

import UIKit

// Step 1
protocol NavigationDelegate: class {
    func viewDismissed(action: Int)
}
class AddSignatureViewController: UIViewController {

    @IBOutlet weak var signView: SignatureView!
    var signViewWidth = CGFloat()
    var signViewHeight = CGFloat()
    
    @IBOutlet var colorView: UIView!
    @IBOutlet weak var colorPicker: ChromaColorPicker!
    
    var stringDate: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = "dd-mm-yyyy hh:mm:ss A"
        return dateFormatter
    }
    
    // Step 2
    weak var delegate: NavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeUI()
    }
    func customizeUI() {
        signView.layer.cornerRadius = 10
        signView.layer.borderColor = UIColor.lightGray.cgColor
        signView.layer.borderWidth = 1
        signViewWidth = signView.frame.width
        signViewHeight = signView.frame.height
    }
    @IBAction func ColorPickerButtonAction(_ sender: Any) {
        colorView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 400)
        view.addSubview(colorView)
        colorPicker.delegate = self
        colorPicker.padding = 5
        colorPicker.stroke = 3
        colorPicker.hexLabel.textColor = .black
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.colorView.frame = CGRect(x: 0, y: self.view.frame.height - 430, width: self.view.frame.width, height: 400)
        }, completion: nil)
    }
    @IBAction func ClearButtonAction(_ sender: Any) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
//            self.signView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height - 30)
//            self.signView.frame = CGRect(x: self.signView.frame.origin.x, y: self.signView.frame.origin.y, width: 0, height: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.signView.clear()
//                self.signView.transform = CGAffineTransform.identity
//                self.signView.frame = CGRect(x: self.signView.frame.origin.x, y: self.signView.frame.origin.y, width: self.signViewWidth, height: self.signViewHeight)
            }, completion: nil)
        }
    }
    @IBAction func CancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func DoneButtonAction(_ sender: Any) {
        if let signatureImage = self.signView.getSignature(scale: 10) {
//            UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
            let imageData = UIImageJPEGRepresentation(signatureImage, 1)
            let currentDate = stringDate.string(from: Date())
            saveSign(image: imageData!, date: currentDate)
            self.signView.clear()
        }
        delegate?.viewDismissed(action: 1)
        self.dismiss(animated: true, completion: nil)
    }
}
extension AddSignatureViewController: ChromaColorPickerDelegate {
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        self.signView.strokeColor = color
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.colorView.removeFromSuperview()
        }, completion: nil)
    }
}
