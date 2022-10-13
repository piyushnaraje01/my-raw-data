//
//  twocellsViewController.swift
//  tableViewCellDeleteAction
//
//  Created by Piyush Naranje on 15/04/22.
//

import UIKit

class twocellsViewController: UIViewController {
 
    @IBOutlet var tableview: UITableView!
    let arrdata = ["nature","nature","nature","nature","nature","nature","nature","nature","nature","nature","nature","nature","nature"]
    var oddValue = 1
    var evenvalue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
extension twocellsViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return arrdata.count
        }else{
            return arrdata.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0{
            let cellFirst = tableview.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as! FirstCell
            cellFirst.firstcellLbl.text = self.arrdata[indexPath.row]
            return cellFirst
        }
        else{
            let cellsecond = tableview.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondCell
            let imgData = self.arrdata[indexPath.row]
            cellsecond.secondviewImg.image = UIImage(named: imgData)
            return cellsecond
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
