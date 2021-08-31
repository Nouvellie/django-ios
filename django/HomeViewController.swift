import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var buttonSignInOut: UIButton!
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var labelLogo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateView()
    }
    
    func updateView() {
        self.buttonMenu.setTitle("Menu", for: .normal)
        self.buttonSignInOut.setTitle("Sign In", for: .normal)
        
        if nouveUserDefaults?.bool(forKey: "nouveUDConnected") == true {
            self.buttonSignInOut.setTitle("Sign Out", for: .normal)
        }
        else {
            self.buttonSignInOut.setTitle("Sign In", for: .normal)
        }
    } // updateView func close.
    
    @IBAction func buttonSignInOutPressed(_ sender: Any) {
        nouveUserDefaults?.set(false, forKey: "nouveUDConnected")
    } // buttonSignInOutPressed func close.
}
