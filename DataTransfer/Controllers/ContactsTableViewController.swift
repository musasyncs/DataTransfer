//
//  ContactsTableViewController.swift
//  DataTransfer
//
//  Created by Ewen on 2021/9/27.
//

import UIKit
import Foundation

class ContactsTableViewController: UITableViewController {
    var stateManager: StateManager?
    var favoritesOnly = false
    var contacts: [Contact] {
        if favoritesOnly {
            return stateManager?.favorites ?? []
        } else {
            return stateManager?.contacts ?? []
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - 1 segue (ContactsTVC -> DetailTVC)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailTVC = segue.destination as? DetailTableViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            detailTVC.contact = contacts[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            
            // 4 assign delegate
            detailTVC.delegate = self
            // 5 assign closure
            detailTVC.updateContactClosure = { [weak self] contact in
                self?.stateManager?.update(contact)
            }
        }
    }
    
    
    // MARK: - 3 unwindSegue (DetailTVC -> ContactsTVC)
    @IBAction func unwindToContactsTVC(_ unwindSegue: UIStoryboardSegue) {
        if let detailTVC = unwindSegue.source as? DetailTableViewController,
           let contact = detailTVC.contact
        {
            self.stateManager?.update(contact)
        }
    }
    
    
    // MARK: - table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = contacts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
        cell.photoImageView.image  = contact.photo
        cell.nameLabel.text        = contact.name
        cell.positionLabel.text    = contact.position
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { [weak self] action, view, completionHandler in
            guard let favorite = self?.stateManager?.contacts[indexPath.row] else {
                completionHandler(false)
                return
            }
            self?.stateManager?.favorites.append(favorite)
            completionHandler(true)
        }
        
        favoriteAction.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [favoriteAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
}


// 4 define delegate method
extension ContactsTableViewController: DetailTableViewControllerDelegate {
    func detailTableViewController(_ controller: DetailTableViewController, didUpdate contact: Contact) {
        self.stateManager?.update(contact)
    }
}


class ContactCell: UITableViewCell {
    static let identifier = "ContactCell"
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
}
