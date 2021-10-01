//
//  DetailTableViewController.swift
//  DataTransfer
//
//  Created by Ewen on 2021/9/27.
//

import UIKit

// 4 invent protocol and declare its methods
protocol DetailTableViewControllerDelegate: AnyObject {
    func detailTableViewController(_ controller: DetailTableViewController, didUpdate contact: Contact)
}

class DetailTableViewController: UITableViewController {
    var contact: Contact?
    
    weak var delegate: DetailTableViewControllerDelegate? // 4 declare delegate
    var updateContactClosure: ((Contact) -> Void)? // 5 declare closure
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoImageView.image    = contact?.photo
        nameLabel.text          = contact?.name
        positionLabel.text      = contact?.position
        emailButton.setTitle(contact?.email, for: .normal)
        phoneButton.setTitle(contact?.phone, for: .normal)
    }
        
    // MARK: - 2 segue (DetailTVC -> BlueEditTVC)
    // 2 segue + prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navC = segue.destination as? UINavigationController,
           let blueEditTVC = navC.viewControllers[0] as? BlueEditTableViewController {
            blueEditTVC.contact = contact
        }
    }
    
    // 2 segue + IBSegueAction
    @IBSegueAction func orangeEdit(_ coder: NSCoder, sender: Any?) -> OrangeEditTableViewController? {
        let orangeEditTVC = OrangeEditTableViewController(coder: coder)
        orangeEditTVC?.contact = contact
        return orangeEditTVC
    }
    // 2 segue + IBSegueAction + init
    @IBSegueAction func yellowEdit(_ coder: NSCoder, sender: Any?) -> YellowEditTableViewController? {
        if let contact = contact {
            return YellowEditTableViewController(coder: coder, contact: contact)
        } else {
            return nil
        }
    }
    
    // 2 instantiateViewController + present
    @IBAction func redEdit(_ sender: Any) {
        if let contact = contact,
           let redEditTVC = storyboard?.instantiateViewController(withIdentifier: "RedEdit") as? RedEditTableViewController {
            redEditTVC.contact = contact
            let navC = UINavigationController(rootViewController: redEditTVC)
            present(navC, animated: true)
        }
    }
    // 2 instantiateViewController + present + init
    @IBAction func greenEdit(_ sender: Any) {
        if let contact = contact,
           let greenEditTVC = storyboard?.instantiateViewController(identifier: "GreenEdit", creator: { coder in
               GreenEditTableViewController(coder: coder, contact: contact)
           }) {
            let navC = UINavigationController(rootViewController: greenEditTVC)
            present(navC, animated: true)
        }
    }
    
    
    // MARK: - 3 unwindSegue (BlueEditTVC -> DetailTVC)
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {}
    
    @IBAction func save(_ unwindSegue: UIStoryboardSegue) {
        if let blueEditTVC = unwindSegue.source as? BlueEditTableViewController {
            self.contact = blueEditTVC.contact
        }
    }
    
    @IBAction func saveWithDelegate(_ unwindSegue: UIStoryboardSegue) {
        if let blueEditTVC = unwindSegue.source as? BlueEditTableViewController {
            self.contact = blueEditTVC.contact
            // 4 call delegate method
            if let contact = contact {
                delegate?.detailTableViewController(self, didUpdate: contact)
            }
        }
    }
    
    @IBAction func saveWithClosure(_ unwindSegue: UIStoryboardSegue) {
        if let blueEditTVC = unwindSegue.source as? BlueEditTableViewController {
            self.contact = blueEditTVC.contact
            // 5 call closure
            if let contact = contact {
                updateContactClosure?(contact)
            }
        }
    }
    
}
