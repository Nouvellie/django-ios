import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signInErrorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.updateView()
    }
    
    func updateView() {
        self.signInButton.layer.cornerRadius = 5
        
        // Inputs.
        self.usernameTextField.autocorrectionType = .no
        self.usernameTextField.autocapitalizationType = .none
        self.passwordTextField.autocorrectionType = .no
        self.passwordTextField.autocapitalizationType = .none
        self.passwordTextField.isSecureTextEntry = true
        self.forgotPasswordButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // Hide keyboard.
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        // Colors.
        self.view.backgroundColor = nouveBackgroundColor
        self.signInErrorLabel.textColor = nouveErrorTextColor
        
        // Hidden.
        self.signInErrorLabel.isHidden = true
    }
}
