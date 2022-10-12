//
//  AccountViewController.swift
//  MealMatch
//
//  Created by Carson Darling on 11/2/21.
//

import UIKit
import Photos

class AccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var theUser: User = User(newUserName: "", theRecipes: [], newPassword: "")
    var imagePicker = UIImagePickerController()
    var pickedImage = UIImage(imageLiteralResourceName: "Alfredo")


    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        var name = theUser.getUserName()
        label.text = "Hello \(name)"
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toTable"){
            if let dest = (segue.destination as? TableViewController) {
                dest.theTableUser = theUser
            }
        }
    }
    @IBAction func unWindAction(unwindSegue: UIStoryboardSegue){
    }
    
    @IBAction func submitButton(_ sender: Any) {
        let message = UIAlertController(title: "Enter Recipe Info", message: nil, preferredStyle: .alert)
        var newImage = UIImage(imageLiteralResourceName: "Alfredo")
        message.addTextField{(textField)
            in
                textField.placeholder = "Recipe Name"
        }
        message.addTextField{ (textField2)
            in
                textField2.placeholder = "Calories"
        }
        message.addTextField{ (textField3)
            in
                textField3.placeholder = "Protein"
        }
        message.addTextField{ (textField4)
            in
                textField4.placeholder = "Carbs"
        }
        message.addTextField{ (textField5)
            in
                textField5.placeholder = "Fat"
        }
        message.addAction( UIAlertAction(title: "Cancel", style: .cancel))
        message.addAction(UIAlertAction (title: "Upload From Photos", style: .default, handler: {
            (action) -> Void in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.imagePicker.modalPresentationStyle = .popover
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true)
        }))
        message.addAction(UIAlertAction (title: "Upload From Camera", style: .default, handler: {
            (action) -> Void in
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.imagePicker.cameraCaptureMode = .photo
            self.imagePicker.modalPresentationStyle = .fullScreen
            self.present(self.imagePicker, animated: true)
        }))
        message.addAction( UIAlertAction(title: "Submit", style: .default, handler: { [self]
            (action) -> Void in
            if(message.textFields![0].text == "" || message.textFields![1].text == "" || message.textFields![2].text == "" || message.textFields![3].text == "" || message.textFields![4].text == ""){
                var message2 = UIAlertController(title: "Please Enter All Fields", message: nil, preferredStyle: .alert)
                message2.addAction( UIAlertAction(title: "OK", style: .default))
                self.present(message2, animated: true)
            }else{
                let newRec = Recipe(newCals: Int(message.textFields![1].text!)!, newProtein: Int(message.textFields![2].text!)!, newCarbs: Int(message.textFields![3].text!)!, newFat: Int(message.textFields![4].text!)!, newPic: UIImage(imageLiteralResourceName: "Alfredo"), theName: message.textFields![0].text!)
                newRec.recPicture = self.pickedImage
                self.theUser.likedRecipes.append(newRec)
            }

        }))
        self.present(message, animated: true)
    }
    
   /* func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        pickedImage = image
        dismiss(animated: true)
    }*/
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
            
            imagePicker.dismiss(animated: true, completion: nil)
        pickedImage = (info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage)!
        }
}
