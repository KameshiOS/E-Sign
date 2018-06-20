//
//  ViewSignatureViewController.swift
//  E-Sign
//
//  Created by Kamesh on 19/06/18.
//  Copyright © 2018 fashionexpress. All rights reserved.
//

import UIKit

class ViewSignatureViewController: UIViewController {

    @IBOutlet weak var signImage: UIImageView!
    var showRecord = Record()
    @IBOutlet weak var printButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signImage.image = UIImage(data: showRecord.image!)
    }
    @IBAction func PrintAction(_ sender: Any) {
        let printVC = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.outputType = UIPrintInfoOutputType.general
        printInfo.jobName = "Demo Print"
        printVC.printInfo = printInfo
        printVC.printingItem = signImage.image
        printVC.showsPaperSelectionForLoadedPapers = true
        printVC.showsNumberOfCopies = true
        printVC.present(from: printButton, animated: true, completionHandler: nil)
//        printVC.present(animated: true, completionHandler: nil)
    }
    @IBAction func ShareButtonAction(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [signImage.image!], applicationActivities: nil)
        activityVC.setValue("DigiSign", forKey: "Subject")
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    @IBAction func DoneButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
