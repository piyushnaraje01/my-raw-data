//
//  SecondViewNotificationViewController.swift
//  tableViewCellDeleteAction
//
//  Created by Piyush Naranje on 11/04/22.
//

import UIKit

protocol PassThedataBackToMainScreendelegate : AnyObject{
    func didtapchoice(image: UIImage,text: String, color: UIColor)
}
class SecondViewNotificationViewController: UIViewController {

    @IBOutlet weak var facebookSignInButn: UIButton!
    @IBOutlet weak var googleSignInbuttn: UIButton!
    weak var passTheData : PassThedataBackToMainScreendelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        facebookSignInButn.layer.cornerRadius = 25
        googleSignInbuttn.layer.cornerRadius = 25
    }

    @IBAction func facebookbutnActionClick(_ sender: UIButton) {
//        NotificationCentre
        NotificationCenter.default.post(name: .facebook, object: nil)
//        Protocol
        self.passTheData.didtapchoice(image: UIImage(named: "facebookBanner")!, text: "Signing in with: Facebook", color: .link)
        navigationController?.popViewController(animated: true) //pop
    }
    
    @IBAction func googlebuttnActionClick(_ sender: UIButton) {
//        NotifivcationCentre
        NotificationCenter.default.post(name: .google, object: nil)
//        Protocol
        self.passTheData.didtapchoice(image: UIImage(named: "GoogleBanner")!, text: "Signing in with: Google", color: .systemYellow)
        navigationController?.popViewController(animated: true) // pop back

    }
}
