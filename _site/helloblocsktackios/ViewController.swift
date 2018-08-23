//
//  ViewController.swift
//  helloblocsktackios
//
//  Created by mmanthony on 8/17/18.
//  Copyright © 2018 moxiegirl. All rights reserved.
//

import UIKit
// 2. Import Blockstack
import Blockstack
import SafariServices


class ViewController: UIViewController {

    // 1. Add the interface
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var nameLabel: UILabel!
    
    // 4. Reference the private function
    override func viewDidLoad() {
        self.updateUI()
        // Do any additional setup after loading the view, typically from a nib.
    }


    // 7. Add in the signIn
    
    // @IBAction func signIn() {
    @IBAction func signIn(_ sender: UIButton) {
        // Address of deployed example web app
        Blockstack.shared.signIn(redirectURI: "https://heuristic-brown-7a88f8.netlify.com/redirect.html",
                                 appDomain: URL(string: "https://heuristic-brown-7a88f8.netlify.com")!) { authResult in
                                    switch authResult {
                                    case .success(let userData):
                                        print("sign in success")
                                        self.handleSignInSuccess(userData: userData)
                                    case .cancelled:
                                        print("sign in cancelled")
                                    case .failed(let error):
                                        print("sign in failed, error: ", error ?? "n/a")
                                    }
        }
    }
    
    // 5. Successful signin
    
    func handleSignInSuccess(userData: UserData) {
        print(userData.profile?.name as Any)
        
        self.updateUI()
        
        // Check if signed in
        // checkIfSignedIn()
    }
    
    // 6. SignOut
    
    @IBAction func signOut(_ sender: Any) {
    // @IBAction func signOut(sender:UIButton!) {
        // Sign user out
        Blockstack.shared.signOut(redirectURI: "myBlockstackApp") { error in
            if let error = error {
                print("sign out failed, error: \(error)")
            } else {
                self.updateUI()
                print("sign out success")
            }
        }
    }
    
    // 3.  Add the private function first
    
    private func updateUI() {
        DispatchQueue.main.async {
            if Blockstack.shared.isSignedIn() {
                // Read user profile data
                let retrievedUserData = Blockstack.shared.loadUserData()
                print(retrievedUserData?.profile?.name as Any)
                let name = retrievedUserData?.profile?.name ?? "Nameless Person"
                self.nameLabel?.text = "Hello, \(name)"
                self.nameLabel?.isHidden = false
                self.signInButton?.setTitle("Sign Out", for: .normal)
            } else {
                self.signInButton?.setTitle("Sign into Blockstack", for: .normal)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

