//
//  MacroViewController.swift
//  MealMatch
//
//  Created by Carson Darling on 11/2/21.
//

import UIKit

class MacroViewController: UIViewController {
    
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var theImage: UIImageView!
    var theRecipe: Recipe = Recipe(newCals: 0, newProtein: 0, newCarbs: 0, newFat: 0, newPic: UIImage(named: "Alfredo")!, theName: "Alfredo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caloriesLabel.text = String(theRecipe.calories)
        proteinLabel.text = String(theRecipe.protein)
        carbsLabel.text = String(theRecipe.carbs)
        fatLabel.text = String(theRecipe.fat)
        theImage.image = theRecipe.recPicture

        // Do any additional setup after loading the view.
    }
    

}
