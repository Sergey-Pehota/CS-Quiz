import UIKit

struct SettingsModel {
    let soundTitle: String
    let soundEnabled: Bool
}

class SettingsViewController: UIViewController {
    @IBOutlet weak var soundLabel: UILabel!
    @IBOutlet weak var soundSwitch: UISwitch!
    
    let model = SettingsModel(soundTitle: "Звук в игре", soundEnabled: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soundLabel.text = model.soundTitle
        soundSwitch.isOn = model.soundEnabled
    }
}
