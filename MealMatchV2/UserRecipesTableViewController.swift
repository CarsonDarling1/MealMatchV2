//
//  UserRecipesTableViewController.swift
//  MealMatch
//
//  Created by Carson Darling on 11/8/21.
//

import UIKit

class UserRecipesTableViewController: UIViewController,
                                      UITableViewDelegate,
                                      UITableViewDataSource{
    var theTableUser: User = User(newUserName: "", theRecipes: [], newPassword: "")
    
    @IBOutlet var theTable: UITableView!
    override func viewDidLoad() {
        theTable.delegate = self
        theTable.dataSource = self
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = theTable.dequeueReusableCell(withIdentifier: "recipeCells", for: indexPath)
        cell.textLabel!.text = theTableUser.getRecipeName(loc: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theTableUser.getRecNumber()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "fromTabletoMacro"){
            if let index = theTable.indexPathForSelectedRow{
                if let vc = segue.destination as? MacroViewController{
                    vc.theRecipe = theTableUser.likedRecipes[index.row]
                }
            }
        }
    }
}
