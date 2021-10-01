//
//  SecondEditTableViewController.swift
//  DataTransfer
//
//  Created by Ewen on 2021/9/27.
//

import UIKit

class RedEditTableViewController: UITableViewController {
    
    var contact: Contact?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //顯示
        photoImageView.image    = contact?.photo
        nameTextField.text      = contact?.name
        positionTextField.text  = contact?.position
        emailTextField.text     = contact?.email
        phoneTextField.text     = contact?.phone
    }
}
