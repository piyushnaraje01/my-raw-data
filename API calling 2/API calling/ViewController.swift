//
//  ViewController.swift
//  API calling
//
//  Created by Piyush Naranje on 18/04/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var arrData = NSArray()
    var allInfoDta = [apidata]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        jsonSerialization()
        
        hitUserApi {
            self.tableView.reloadData()
        }
        
    }
    
//    MARK: jsonDecoder
    
        func hitUserApi(completed:@escaping () -> ()) {
            let url = URL(string: "https://jsonplaceholder.typicode.com/users")
            URLSession.shared.dataTask(with: url!) { data, response, error in
                if data != nil{
                    do {
                        self.allInfoDta = try JSONDecoder().decode([apidata].self, from: data!)
                        DispatchQueue.main.async {
                            completed()
                        }
                    }
                    catch{
                        print("no data to show")
                    }
                }
            } .resume()
        }
//    MARK:  JSONSerialization
    func jsonSerialization() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? NSArray
                
                self.arrData = json!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        JSON Serialization
//        return arrData.count
//          JSON decoder
        return allInfoDta.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maintableViewCell", for: indexPath) as! maintableViewCell
//        MARK: json serialization
//        let obj = arrData[indexPath.row] as! NSObject
//        cell.idNumberLbl.text = "\(obj.value(forKey: "id") as? Int ?? 0)"
//        cell.nameLbl.text = obj.value(forKey: "name") as? String ?? ""
//
//        let email = obj.value(forKey: "email")
//        cell.emailLbl.text = email as? String
//
//        let phoneNumber = obj.value(forKey: "phone")
//        cell.phoneNumberLbl.text = phoneNumber as? String
        
//        MARK: jason decoder
        let dataToShow = allInfoDta[indexPath.row]
        cell.idNumberLbl.text = "\(dataToShow.id!)"
        cell.nameLbl.text = dataToShow.name ?? ""
        cell.emailLbl.text = dataToShow.email ?? ""
        cell.phoneNumberLbl.text = dataToShow.phone
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "showDetails", sender: self)
        }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? subDataViewController{
                destination.subdata = allInfoDta[(tableView.indexPathForSelectedRow?.row)!]
            }
        }
}
