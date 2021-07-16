

//
//  HomeViewController.swift
//  KSLocalization
//
//  Created by Raja Pitchai on 02/05/21.
//  Copyright © 2021 KOBIL Systems GmbH. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblThree: UILabel!
    @IBOutlet weak var langSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        langSwitch.setOn(false, animated: false)
        langSwitch.addTarget(self, action: #selector(doToggle(langSwitch:)), for: .valueChanged)
        KSLocalizationManager.sharedInstance.setCurrentBundle(forLanguage: UserDefaults.selectedLanguage)
        LanguageController.sharedInstance.enableLanguageSelection(isNavigationBarButton: true, forViewController: self)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(KSConstants.Notifications.LanguageChangeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateView), name: Notification.Name(KSConstants.Notifications.LanguageChangeNotification), object: nil)
        updateView()
    }
    @objc func doToggle(langSwitch: UISwitch) {
        if langSwitch.isOn && !langSwitch.isSelected {
            langSwitch.isSelected = true
            KSLanguageServiceManager.sharedInstance.getLanguagesFromServer(url: URL(string: "https://api.jsonbin.io/b/60f12c7ba917050205c88f6f")!, fromVC: self)
        } else {
            langSwitch.isSelected = false
        }
    }
    @objc func updateView() {
        lblOne.text = NSLocalizedString(KSConstants.Labels.key1, tableName: "", bundle: KSLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
        lblTwo.text = NSLocalizedString(KSConstants.Labels.key2, tableName: "", bundle: KSLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
        lblThree.text = NSLocalizedString(KSConstants.Labels.key3, tableName: "", bundle: KSLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
        changeBGColor()
    }
    func changeBGColor()  {
        let labels = contentView.subviews.compactMap { $0 as? UILabel }
        for label in labels {
            UIView.transition(with: label, duration: 0.2, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                label.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
            }) { (completed) in
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(self.scrollView.contentSize)
    }
    
}
