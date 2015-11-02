//
//  BrowseContactTableViewController.swift
//  ParseChat
//
//  Created by Linus Liang on 10/31/15.
//  Copyright © 2015 Linus Liang. All rights reserved.
//

import UIKit
import Foundation
import Parse

class BrowseContactTableViewController: UITableViewController {
    
    var idx: Int?
    var contacts: [PFUser] = []
    enum QueryErrors: ErrorType {
        case BadCast
    }
    

    
    override func viewDidLoad() {
        
        signIn()
        
        var query = PFUser.query()
        query?.whereKey("isContact", equalTo: true)
        do {
            contacts = try query?.findObjects() as! [PFUser]
        } catch {
            print("caught")
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc: ContactProfileViewController = segue.destinationViewController as! ContactProfileViewController

        let index: Int = self.tableView.indexPathForSelectedRow!.row
        vc.contact = contacts[index]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("userCellIdentifier", forIndexPath: indexPath)
        
        cell.textLabel!.text = contacts[indexPath.row].email
        return cell
    }
    
    func signIn() {
        do {
            try PFUser.logInWithUsername("myUsername", password: "myPassword")
        } catch {
            print (" wioll i hverr ")
        }
        print("in sign in")
        print(PFUser.currentUser())
    }
}
