//
//  ViewController.swift
//  ValidationTextField
//
//  Created by User on 10/07/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var phoneError: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetForm()
        
    }
    
    func resetForm() {
        submitButton.isEnabled = false
        
        emailError.text = "Required"
        passwordError.text = "Required"
        phoneError.text = "Required"
        
        emailError.isHidden = false
        passwordError.isHidden = false
        phoneError.isHidden = false
        
        tfEmail.text = ""
        tfPassword.text = ""
        tfPhoneNumber.text = ""
        
    }
    
    @IBAction func emailChanged(_ sender: Any) {
        if let email = tfEmail.text {
            if let errorMessage = invalidEmail(email){
                emailError.text = errorMessage
                emailError.isHidden = false
            }
            else{
                emailError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = tfPassword.text {
            if let errorMessage = invalidPassword(password){
                passwordError.text = errorMessage
                passwordError.isHidden = false
            }
            else{
                passwordError.isHidden = true
            }
        }

        
        checkForValidForm()
    }
    
    @IBAction func numberChanged(_ sender: Any) {
        if let phoneNumber = tfPhoneNumber.text {
            if let errorMessage = invalidPhoneNumber(phoneNumber){
                phoneError.text = errorMessage
                phoneError.isHidden = false
            }
            else{
                phoneError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    func invalidPhoneNumber(_ value: String) -> String? {
        
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set){
            return "Phone Number must contain only digit "
        }
        if value.count != 11{
            return "Phone Number must be 11 Digits in Length"
        }
        return nil
    }
    func invalidEmail(_ value: String) -> String?{
        
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value){
            return "Invalid Email Address"
        }
        return nil
    }
    func invalidPassword(_ value: String) -> String?{
        
        if value.count < 8{
            return "Password must be at least 8 characters"
        }
        if containsDigit(value){
            return "Password must contains at least 1 digit"
        }
        if containsUpperCase(value){
            return "Password must contains at least 1 UppeCcase character"
        }
        if containsLowerCase(value){
            return "Password must contains at least 1 LowerCase character"
        }

        return nil
    }
    func containsDigit(_ value: String) -> Bool {
        
        let regularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    func containsLowerCase(_ value: String) -> Bool {
        
        let regularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    func containsUpperCase(_ value: String) -> Bool {
        
        let regularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }

    func checkForValidForm() {
        if emailError.isHidden && passwordError.isHidden && phoneError.isHidden{
            submitButton.isEnabled = true
        } else{
                submitButton.isEnabled = false
            }
    }
        
    @IBAction func submitAction(_ sender: Any) {
        resetForm()
    }
}

