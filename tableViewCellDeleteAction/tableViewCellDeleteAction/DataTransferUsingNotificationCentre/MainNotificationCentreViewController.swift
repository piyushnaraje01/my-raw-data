//
//  MainNotificationCentreViewController.swift
//  tableViewCellDeleteAction
//
//  Created by Piyush Naranje on 11/04/22.
//

import UIKit

class MainNotificationCentreViewController: UIViewController {
    @IBOutlet weak var signInWithlbl: UILabel!
    @IBOutlet weak var choosePlatfornbtn: UIButton!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(facebook(notification:)), name: .facebook, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(google(notification:)), name: .google, object: nil)
        choosePlatfornbtn.layer.cornerRadius = 25
        img.layer.cornerRadius = 15
    }
    
    @objc func facebook(notification: Notification){
        signInWithlbl.text = "Signing with : Facebook"
        img.image = UIImage(named: "facebookBanner")
        choosePlatfornbtn.backgroundColor = .link
    }
    
    @objc func google(notification: Notification){
        signInWithlbl.text = "Signing with : Google"
        img.image = UIImage(named: "GoogleBanner")
        choosePlatfornbtn.backgroundColor = .systemYellow
    }
    @IBAction func choosePlatforbuttnclickAction(_ sender: UIButton) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewNotificationViewController")as! SecondViewNotificationViewController
        secondVC.passTheData = self
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}
extension Notification.Name{
    static let facebook = Notification.Name("Facebook")
    static let google = Notification.Name("Google")
}
extension MainNotificationCentreViewController: PassThedataBackToMainScreendelegate{
    func didtapchoice(image: UIImage, text: String, color: UIColor) {
        signInWithlbl.text = text
        img.image = image
        choosePlatfornbtn.backgroundColor = color
    }
}
