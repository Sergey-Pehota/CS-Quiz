import UIKit

protocol SettingsViewControllerDelegate {
    func didTapCorrectAnswersSwitch()
}

struct Settings {
    let soundTitle: String
    let soundEnabled: Bool
}

final class SettingsViewController: UIViewController {
    @IBOutlet weak var soundLabel: UILabel!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var correctAnswers: UISwitch!
    
    var delegate: SettingsViewControllerDelegate?
    
    var settings = Settings(soundTitle: "Звук в игре", soundEnabled: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soundLabel.text = settings.soundTitle
        soundSwitch.isOn = settings.soundEnabled
        
    }
    
    @IBAction func showCorrectAnswers(_ sender: UISwitch) {
        delegate?.didTapCorrectAnswersSwitch()
    }
}
