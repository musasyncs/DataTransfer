//
//  FirstEditTableViewController.swift
//  DataTransfer
//
//  Created by Ewen on 2021/9/27.
//

import UIKit

class BlueEditTableViewController: UITableViewController {
    var contact: Contact?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image    = contact?.photo
        nameTextField.text      = contact?.name
        positionTextField.text  = contact?.position
        emailTextField.text     = contact?.email
        phoneTextField.text     = contact?.phone
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photo         = photoImageView.image,
           let name          = nameTextField.text,
           let position      = positionTextField.text,
           let email         = emailTextField.text,
           let phone         = phoneTextField.text
        {
            self.contact = Contact(photo: photo, name: name, position: position, email: email, phone: phone)
        }
    }
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if photoImageView.image != nil,
//           nameTextField.text?.isEmpty == false,
//           positionTextField.text?.isEmpty == false,
//           emailTextField.text?.isEmpty == false,
//           phoneTextField.text?.isEmpty == false {
//            return true
//        }
//        else {
//            let alertController = UIAlertController(title: "錯誤", message: "資料不可為空白", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
//            present(alertController, animated: true, completion: nil)
//            return false
//        }
//    }
    
}
