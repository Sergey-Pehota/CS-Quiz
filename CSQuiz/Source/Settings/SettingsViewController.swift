import UIKit

struct Settings {
    let soundTitle: String
    let soundEnabled: Bool
}

final class SettingsViewController: UIViewController {
    @IBOutlet weak var soundLabel: UILabel!
    @IBOutlet weak var soundSwitch: UISwitch!
    
    let settings = Settings(soundTitle: "Звук в игре", soundEnabled: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soundLabel.text = settings.soundTitle
        soundSwitch.isOn = settings.soundEnabled
    }
}
