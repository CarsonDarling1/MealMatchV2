//
//  User.swift
//  MealMatchV2
//
//  Created by Carson Darling on 11/12/21.
//

import Foundation

class User{
    
    var userName: String
    var likedRecipes: [Recipe]
    var password: String
    
    init(newUserName: String, theRecipes: [Recipe], newPassword: String){
        self.userName = newUserName
        self.likedRecipes = theRecipes
        self.password = newPassword
    }
    
    func getRecipeName(loc: Int) -> String{
        return self.likedRecipes[loc].name
    }
    
    func getRecNumber() -> Int{
        return self.likedRecipes.count
    }
    
    func getUserName() -> String{
        return self.userName
    }
}
