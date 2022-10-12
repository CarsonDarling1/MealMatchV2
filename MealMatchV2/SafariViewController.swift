//
//  SafariViewController.swift
//  Pods
//
//  Created by Carson Darling on 11/14/21.
//

import UIKit
import SafariServices

class SafariViewController: UIViewController {

    var link = URL(string: "google.com")
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.open(link!)

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

}
