//
//  LoginViewController.swift
//  WeatherToWear
//
//  Created by Kodeeshwari Solanki on 2023-04-13.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    var user : UserModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    
    
    @IBAction func btnLoginTouchUpInside(_ sender: Any) {
        
        guard let email = txtEmail.text,
              let password = txtPassword.text else {
            // handle missing fields here
            Toast.ok(view: self, title: "Error", message: "No feild should be empty")
            return
        }
        
        UserAuthAPI.signIn(email: email, password: password,
                           successHandler: {(httpStatusCode,response) in
            DispatchQueue.main.async {
                if httpStatusCode==200{
                    let message = response["message"] as? String ?? "Unknown response"
                    print(Thread.isMainThread)
                    let data = response["data"]
                    self.user = UserModel.decode(json: response["data"]! as! [String : Any])!
                    //print(user.city)
                    self.performSegue(withIdentifier: Segue.toMainViewController, sender: nil)
                }
                else{
                    Toast.ok(view: self, title: "Response", message: "\(httpStatusCode)")
                }
            }
        }, failHandler: {(httpStatusCode,errorMessage)in
            print("HTTP Status Code: \(httpStatusCode)")
            print("Error Message: \(errorMessage)")
            DispatchQueue.main.async {
                Toast.ok(view: self, title: "Error: \(httpStatusCode)", message: "\(errorMessage)")
            }
            
        })
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.toMainViewController{
            if let mainViewController = segue.destination as? MainViewController{
                mainViewController.userModel = user
            }
        }
    }
    
    
    @IBAction func btnRegisterTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: Segue.toRegisterViewController, sender: nil)
    }
    
    
    
}
