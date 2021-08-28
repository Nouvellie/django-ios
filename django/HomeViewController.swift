import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var signInOutButton: UIButton!
    @IBOutlet weak var optionsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateView()
    }
    
    func updateView() {
        self.optionsButton.setTitle("Options", for: .normal)
        self.signInOutButton.setTitle("Sign In", for: .normal)
        
        if nouveUserDefaults?.bool(forKey: "nouveConnected") == true {
            self.signInOutButton.setTitle("Sign Out", for: .normal)
        }
        else {
            self.signInOutButton.setTitle("Sign In", for: .normal)
        }
    } // updateView func close.
    
    @IBAction func signInOutButtonPressed(_ sender: Any) {
        nouveUserDefaults?.set(false, forKey: "nouveConnected")
    }
    
}
