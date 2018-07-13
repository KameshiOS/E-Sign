//
//  MultiImageViewController.swift
//  E-Sign
//
//  Created by Kamesh on 21/06/18.
//  Copyright © 2018 fashionexpress. All rights reserved.
//

import UIKit

class MultiImageViewController: UIViewController {

    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    
    var imagePickerController = ImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    @IBAction func PickImageButtonAction(_ sender: Any) {
        var configuration = Configuration()
        configuration.doneButtonTitle = "Finish"
        configuration.noImagesTitle = "Sorry! There are no images here!"
        configuration.recordLocation = false
        imagePickerController = ImagePickerController(configuration: configuration)
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 6
        present(imagePickerController, animated: true, completion: nil)
    }
}
extension MultiImageViewController: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("Wrapped Did Press")
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("Done Button Did Press")
        image1.image = images[0]
        image2.image = images[1]
        image3.image = images[2]
        image4.image = images[3]
        image5.image = images[4]
        image6.image = images[5]
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        print("Cancel Button Did Press")
    }
}
