//
//  ViewController.swift
//  tableViewCellDeleteAction
//
//  Created by Piyush Naranje on 08/04/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addrowButton: UIButton!
    var arrData: [String] = ["1","2","3","4"]
    {
        willSet{
            self.arrData = newValue
            tableView.reloadData()
        }
    }
    var index = 0
    var deletedStr = ""
    var deletedData : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        addrowButton.layer.cornerRadius = 40
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit"), style: .done, target: self, action: #selector(edittableViewCell))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "undo"), style: .done, target: self, action: #selector(undoToPrevous))
    }
    @objc func edittableViewCell(){
        if tableView.isEditing {
            tableView.isEditing = false
        }
        else{
            tableView.isEditing = true
        }
    }
    @IBAction func addRowtotableViewAction(_ sender: UIButton) {
        let alert = UIAlertController(
        title: "Add row",
        message: "Write somethings in textfield and press save",
        preferredStyle: .alert
        )
// textFields
        alert.addTextField { field in
            field.placeholder = "write here"
            field.returnKeyType = .next
            field.keyboardType = .emailAddress
}
        alert.addAction(UIAlertAction(title: "cancle", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            
//   read text Field values
            guard let fields = alert.textFields else{
                return
            }
            let userNameField = fields[0]
            let textToAppend = userNameField.text
            self.arrData.append(textToAppend ?? "nil")
        }))
        present(alert, animated: true)
    }
    @objc func undoToPrevous(){
        if deletedStr == ""{
            self.tableView.reloadData()
        }else{
            if self.arrData.contains(deletedStr) {
                self.tableView.reloadData()
                let alrt = UIAlertController(title: "No data to Undo", message: "Action is already done", preferredStyle: .alert)
                       let firstAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                       alrt.addAction(firstAction)
                       present(alrt, animated: true, completion: nil)
                
            }else{
                self.arrData.insert(deletedStr, at: index)
            }
        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewTableViewCell", for: indexPath) as! AddNewTableViewCell
        cell.textLblName.text = arrData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            tableView.performBatchUpdates {
          tableView.beginUpdates()
                
                deletedStr = arrData[indexPath.row]
                self.deletedData.append(deletedStr)
                deletedData.append(arrData[indexPath.row])
                arrData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                index = indexPath.row
               
            }
        }
        if editingStyle == .insert{
            print("efefefef")
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        arrData.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    
    
}
