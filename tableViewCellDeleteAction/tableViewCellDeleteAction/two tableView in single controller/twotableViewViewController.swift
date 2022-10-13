//
//  twotableViewViewController.swift
//  tableViewCellDeleteAction
//
//  Created by Piyush Naranje on 15/04/22.
//

import UIKit

class twotableViewViewController: UIViewController {
    

    @IBOutlet var tableView1: UITableView!
    @IBOutlet var tableView2: UITableView!
    let arrData1 = ["1","2","3","4","5","6","7"]
    let arrData2 = ["1","2","3","4","5","6","7","8"]
    let refreshControl = UIRefreshControl()
    let refreshControl2 = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView1.endUpdates()
            refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)

            // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
            tableView2.refreshControl = refreshControl
    }
    @objc func doSomething(refreshControl: UIRefreshControl) {
        
        tableView2.reloadData()

        refreshControl.endRefreshing()
    }
}
extension twotableViewViewController: UITableViewDelegate,UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
//    MARK:  table view 1 sections
        if tableView == self.tableView1{
            return 2
        }else{
            return 1
        }
        
    }
//    MARK: number Of Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView1{
            if section == 0{
                return arrData1.count
            }else{
                return 20
            }
        }
        return arrData2.count
    }
//    MARK: cell For RowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView1{
//            MARK:  table 1 section 1
            if indexPath.section == 0{
                            let cell = tableView1.dequeueReusableCell(withIdentifier: "FIrstTableViewCell", for: indexPath)as! FIrstTableViewCell
                cell.firstCelllbl.text = self.arrData1[indexPath.row]
                            return cell
            }
           else{
               let cell1 = tableView1.dequeueReusableCell(withIdentifier: "FirstRowSecondprototypeCell", for: indexPath) as! FirstRowSecondprototypeCell
// here
                if indexPath.row % 2 == 0{
                    cell1.cellCharacter.text = "indexPath Even"
                    
                    
                }else{
                    cell1.cellCharacter.text = "indexPath Odd"
//                    cell1.cellImg.image = UIImage(named: "nature")
                }
                return cell1 ?? UITableViewCell()
            }
        }
        else{
//            MARK:  table 2
            let cell1 =  tableView2.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
            cell1.seconfCellLbl.text = self.arrData2[indexPath.row]
            return cell1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
