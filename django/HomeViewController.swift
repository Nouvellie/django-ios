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
    } // updateView func close.
}
