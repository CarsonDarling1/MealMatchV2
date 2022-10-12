//
//  LoginViewController.swift
//  MealMatchV2
//
//  Created by Carson Darling on 11/12/21.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    var theUser1 = User(newUserName: "", theRecipes: [], newPassword: "")
    override func viewDidLoad() {
        userText.text = "testUser@t.com"
        passwordText.text = "testPass11#"
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: (userText.text ?? ""), password: (passwordText.text ?? "")) { (result, error) in
                if let _eror = error{
                    print(_eror.localizedDescription)
                }else{
                    if let _res = result{
                    print(_res)
                        self.transitionToHome()
                }
            }
        }
    }
    
    @IBAction func createButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: (userText.text!), password: (passwordText.text!)) { (result, error) in
                if let _eror = error {
                        //something bad happning
                        print(_eror.localizedDescription )
                }else{
                        //user registered successfully
                    let db = Firestore.firestore()
                    db.collection("Users").addDocument(data: ["name": self.userText.text, "likedRecipes": [Recipe]()])
                let message = UIAlertController(title: "Account Created", message: nil, preferredStyle: .alert)
                    message.addAction( UIAlertAction(title: "OK", style: .cancel))
                    self.present(message, animated: true)
                print(result as Any)
            }
        }
    }
    
    func transitionToHome(){
        let hvc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        hvc?.currentUser = theUser1
        hvc?.currentUser.userName = userText.text!
        
        view.window?.rootViewController = hvc
        view.window?.makeKeyAndVisible()
    }
    
}
