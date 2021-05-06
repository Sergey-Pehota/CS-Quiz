import UIKit

class FinishViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func finishButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
