import Alamofire
import SwiftyJSON
import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signInErrorLabel: UILabel!
    var signInInputsValidation: Bool!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateView()
    }
    
    func updateView() {
        // Inputs.
        self.usernameTextField.autocorrectionType = .no
        self.usernameTextField.autocapitalizationType = .none
        self.passwordTextField.autocorrectionType = .no
        self.passwordTextField.autocapitalizationType = .none
        self.passwordTextField.isSecureTextEntry = true
        
        // Other.
        self.signInButton.layer.cornerRadius = 5
        self.forgotPasswordButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.homeButton.setTitle("Home", for: .normal)
        
        // Hide keyboard.
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        // Colors.
        self.view.backgroundColor = nouveBackgroundColor
        self.signInErrorLabel.textColor = nouveErrorTextColor
        
        // Hidden.
        self.signInErrorLabel.isHidden = true
    }
    
    func checkInputs() {
        if (self.usernameTextField.text!.isEmpty || self.passwordTextField.text!.isEmpty) {
            self.signInInputsValidation = false
        }
    } // checkInputs func close.
    
    func signInRequest() {
        let apiInputs = [
            "username": self.usernameTextField.text!,
            "password": self.passwordTextField.text!
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in apiInputs {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: nouveSignInUrl
        ).responseJSON { response in
            switch response.result {
            case .success(let value):
                let apiResult = JSON(value)
                if response.response?.statusCode == 200 {
                    print("TODO Home redirect.")
                    nouveUserDefaults?.set(apiResult["token"].string, forKey: "nouveToken")
                    self.signInHomeViewRedirect()
                }
                else if response.response?.statusCode == 401 {
                    self.signInErrorLabel.text = apiResult["error"].string
                }
                else {
                    self.signInErrorLabel.text = "A problem has occurred while trying to sign in."
                }
            case .failure(_):
                self.signInErrorLabel.text = "An error has occurred, please try again later."
            }
        }
        self.signInErrorLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.signInErrorLabel.isHidden = true
            self.signInErrorLabel.text = ""
        }
    } // singInRequest func close.
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        self.signInInputsValidation = true
        self.checkInputs()
        
        if self.signInInputsValidation {
            self.signInRequest()
        }
        else {
            self.signInErrorLabel.text = "Both fields are required."
            self.signInErrorLabel.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.signInErrorLabel.isHidden = true
                self.signInErrorLabel.text = ""
            }
        }
    } // signInButtonPressed func close.
    
    func signInHomeViewRedirect() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyBoard.instantiateViewController(identifier: "HomeViewID")
        homeVC.modalTransitionStyle = .crossDissolve
        homeVC.modalPresentationStyle = .fullScreen
        self.present(homeVC, animated: false, completion: nil)
    } // signInHomeViewRedirect func close.
    
} // SignInViewController class close.
