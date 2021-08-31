import Alamofire
import SwiftyJSON
import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var buttonHome: UIButton!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var labelLogo: UILabel!
    @IBOutlet weak var imageUsername: UIImageView!
    @IBOutlet weak var imagePassword: UIImageView!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonSignIn: UIButton!
    @IBOutlet weak var buttonForgotPassword: UIButton!
    @IBOutlet weak var labelError: UILabel!
    
    var signInInputsValidation: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateView()
    }
    
    func updateView() {
        // Inputs.
        self.textFieldUsername.autocorrectionType = .no
        self.textFieldUsername.autocapitalizationType = .none
        self.textFieldPassword.autocorrectionType = .no
        self.textFieldPassword.autocapitalizationType = .none
        self.textFieldPassword.isSecureTextEntry = true
        
        // Other.
        self.buttonSignIn.layer.cornerRadius = 5
        self.buttonForgotPassword.titleLabel?.adjustsFontSizeToFitWidth = true
        self.buttonHome.setTitle("Home", for: .normal)
        
        // Hide keyboard.
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        // Colors.
        self.view.backgroundColor = nouveColorBlackBackground
        self.labelError.textColor = nouveColorErrorText
        
        // Hidden.
        self.labelError.isHidden = true
    }
    
    func checkInputs() {
        if (self.textFieldUsername.text!.isEmpty || self.textFieldPassword.text!.isEmpty) {
            self.signInInputsValidation = false
        }
    } // checkInputs func close.
    
    func signInRequest() {
        let apiInputs = [
            "username": self.textFieldUsername.text!,
            "password": self.textFieldPassword.text!
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in apiInputs {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: nouveUrlSignIn
        ).responseJSON { response in
            switch response.result {
            case .success(let value):
                let apiResult = JSON(value)
                if response.response?.statusCode == 200 {
                    print("TODO Home redirect.")
                    nouveUserDefaults?.set(apiResult["token"].string, forKey: "nouveUDToken")
                    nouveUserDefaults?.set(true, forKey: "nouveUDConnected")
                    self.signInHomeViewRedirect()
                }
                else if response.response?.statusCode == 401 {
                    self.labelError.text = apiResult["error"].string
                }
                else {
                    self.labelError.text = "A problem has occurred while trying to sign in."
                }
            case .failure(_):
                self.labelError.text = "An error has occurred, please try again later."
            }
        }
        self.labelError.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.labelError.isHidden = true
            self.labelError.text = ""
        }
    } // singInRequest func close.
        
    @IBAction func buttonSignInPressed(_ sender: Any) {
        self.signInInputsValidation = true
        self.checkInputs()
        
        if self.signInInputsValidation {
            self.signInRequest()
        }
        else {
            self.labelError.text = "Both fields are required."
            self.labelError.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.labelError.isHidden = true
                self.labelError.text = ""
            }
        }
    } // buttonSignInPressed func close.
    
    func signInHomeViewRedirect() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VCHome = storyBoard.instantiateViewController(identifier: "HomeViewID")
        VCHome.modalTransitionStyle = .crossDissolve
        VCHome.modalPresentationStyle = .fullScreen
        self.present(VCHome, animated: false, completion: nil)
    } // signInHomeViewRedirect func close.
    
} // SignInViewController class close.
