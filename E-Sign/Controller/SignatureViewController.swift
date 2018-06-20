//
//  SignatureViewController.swift
//  E-Sign
//
//  Created by Kamesh on 19/06/18.
//  Copyright © 2018 fashionexpress. All rights reserved.
//

import UIKit

class SignatureViewController: UIViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var signTable: UITableView!
    
    var records = [Record]()
    let noLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        signTable.delegate = self
        signTable.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    func loadData() {
        fetchCoreData { (results) in
            self.records = results
            if self.records.count > 0 {
                self.noLabel.removeFromSuperview()
            } else {
                self.noLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)
                self.noLabel.text = "No Signature found, Add signature for future use"
                self.noLabel.textAlignment = .center
                self.noLabel.center = self.signTable.center
                self.signTable.addSubview(self.noLabel)
            }
        }
        DispatchQueue.main.async {
            self.signTable.reloadData()
        }
    }
    @IBAction func EditButtonAction(_ sender: Any) {
        // PatternLockViewController
//        let addVC = self.storyboard?.instantiateViewController(withIdentifier: "PatternLockViewController") as! PatternLockViewController
//        addVC.modalPresentationStyle = .overFullScreen
//        present(addVC, animated: true, completion: nil)
        
        self.signTable.allowsMultipleSelectionDuringEditing = true
    }
    @IBAction func AddButtonAction(_ sender: Any) {
        let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddSignatureViewController") as! AddSignatureViewController
        addVC.modalPresentationStyle = .overFullScreen
        addVC.delegate = self
        present(addVC, animated: true, completion: nil)
    }
}
extension SignatureViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SignatureTableViewCell
        cell.signImageView.image = UIImage(data: records[indexPath.row].image!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewSignatureViewController") as! ViewSignatureViewController
        viewVC.modalPresentationStyle = .overFullScreen
        viewVC.showRecord = records[indexPath.row]
        present(viewVC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexpath) in
            // Delete record and remove cell
            self.records.remove(at: indexpath.row)
            deleteCoreData(row: indexpath.row)
            self.signTable.deleteRows(at: [indexpath], with: UITableViewRowAnimation.fade)
            self.loadData()
        }
        return [delete]
    }
}
extension SignatureViewController: NavigationDelegate {
    func viewDismissed(action: Int) {
        loadData()
    }
}
