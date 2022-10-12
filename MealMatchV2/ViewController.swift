//
//  ViewController.swift
//  MealMatchV2
//
//  Created by Carson Darling on 11/12/21.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    var recipeArray: [Recipe] = []
    var index: Int = 0
    var currentUser: User = User(newUserName: "Carson", theRecipes: [], newPassword: "")

    @IBOutlet weak var activeImage: UIImageView!
    var divisor: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        divisor = (view.frame.width/2) / 0.61
        let recipe1 = Recipe(newCals: 800, newProtein: 50, newCarbs: 100, newFat: 30, newPic: UIImage(named: "Alfredo")!, theName: "Alfredo")
        recipeArray.append(recipe1)
        let recipe2 = Recipe(newCals: 1000, newProtein: 70, newCarbs: 50, newFat: 50, newPic: UIImage(named: "Steak")!, theName: "Steak")
        recipeArray.append(recipe2)
        let recipe3 = Recipe(newCals: 600, newProtein: 33, newCarbs: 50, newFat: 20, newPic: UIImage(named: "Omelette")!, theName: "Omelette")
        recipeArray.append(recipe3)
        let recipe4 = Recipe(newCals: 650, newProtein: 40, newCarbs: 75, newFat: 15, newPic: UIImage(named: "Salmon")!, theName: "Salmon")
        recipeArray.append(recipe4)
        let recipe5 = Recipe(newCals: 750, newProtein: 35, newCarbs: 150, newFat: 15, newPic: UIImage(named: "Chili")!, theName: "Chili")
        recipeArray.append(recipe5)
        let recipe6 = Recipe(newCals: 400, newProtein: 20, newCarbs: 130, newFat: 25, newPic: UIImage(named: "Pancakes")!, theName: "Pancakes")
        recipeArray.append(recipe6)
        activeImage.image = recipeArray[index].recPicture
        
        // Do any additional setup after loading the view.
    }

    @IBAction func Pan(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        let xFromCenter = card.center.x - view.center.x
        
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
        
        if sender.state == UIGestureRecognizer.State.ended {
            
            if card.center.x < 75 {
                //MOVE TO THE LEFT
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y)
                    card.alpha = 0
                    self.dislikeRecipe()
                    
                })
                card.center = self.view.center
                card.alpha = 1
                card.transform = CGAffineTransform.identity
                return
            }
            else if card.center.y > (view.frame.width - 75){
                //MOVE RIGHT
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y)
                    card.alpha = 0
                    self.likeRecipe()
                    
                })
                card.center = self.view.center
                card.alpha = 1
                card.transform = CGAffineTransform.identity
                return
            }

            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.view.center
                card.alpha = 1
                card.transform = CGAffineTransform.identity
            })
        }
    }
    
    @IBAction func dislikeButton(_ sender: Any) {
        dislikeRecipe()
        reloadInputViews()
    }
    
    @IBAction func likeButton(_ sender: Any) {
        likeRecipe()
        reloadInputViews()
    }
    
    @IBAction func accountButton(_ sender: Any) {
    }
    
    @IBAction func likeRecipe(){
        currentUser.likedRecipes.append(recipeArray[index])
        print(currentUser.likedRecipes.count)
        index += 1
        if(index < recipeArray.count){
            activeImage.image = recipeArray[index].recPicture
        }
        else{
            activeImage.image = nil
        }
    }
    
    @IBAction func dislikeRecipe(){
        index += 1
        if(index < recipeArray.count){
            activeImage.image = recipeArray[index].recPicture
        }
        else{
            activeImage.image = nil
        }
    }
    
    @IBAction func macrosButton(_ sender: Any) {
    }
    
    @IBAction func unWindAction(unwindSegue: UIStoryboardSegue){
        if let sourceViewController = unwindSegue.source as? AccountViewController {
            currentUser = sourceViewController.theUser
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toMacros"){
            if let dest = (segue.destination as? MacroViewController) {
                dest.theRecipe = recipeArray[index]
            }
        }
        else if(segue.identifier == "toAccount"){
            if let dest = (segue.destination as? AccountViewController)
            {
                dest.theUser = currentUser
            }
        }
    }
    
    
}

