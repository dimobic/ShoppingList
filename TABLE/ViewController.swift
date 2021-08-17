//
//  ViewController.swift
//  TABLE
//
//  Created by Dima Chirukhin on 27/04/2020.
//  Copyright © 2020 Dima Chirukhin. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var Lable1: UILabel!
    func num() {
        let text = UITextField()
        text.keyboardType = .numberPad
    }
    func qwerty() {
           let text = UITextField()
        text.keyboardType = .default
       }
    
    @IBOutlet weak var CELL: UITableView!
    @IBAction func ADDNEW(_ sender: Any) {
        let alert = UIAlertController(title: "Новый элемент", message: "", preferredStyle: .alert)
        self.qwerty()
        alert.addTextField { (textfield) in
            textfield.placeholder = "Вводи давай!" }
        let alertaction = UIAlertAction(title: "Добавить", style: .default) { (alertaction) in
            if alert.textFields![0].text! != ""{
                //self.arr.append(alert.textFields![0].text!)
                addItem(nameItem: alert.textFields![0].text!)
                self.summ()
                self.CELL.reloadData()
            }
        }
        let aletactoin2 = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(alertaction)
        alert.addAction(aletactoin2)
        present(alert,animated: true,completion: nil) }
    @IBOutlet weak var rep: UIButton!
    @IBAction func repair(_ sender: Any) {
        let bb = self.CELL.isEditing
        if bb == false{
            self.CELL.isEditing = true
              rep.setTitle("Oк.", for: .normal)
        }
        else{
            self.CELL.isEditing = false
            rep.setTitle("Ред.", for: .normal)
        }
        }
    var su :Double = 0
    func summ()
    {
        su = 0
        for i in 0...username.count-1 {
            let y: Double = Double(NSString(string: username[i]["sum"] as! String).doubleValue)
            su = su + y
        }
        Lable1.text = String(su)
        
    }
    @IBOutlet weak var check: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CELL.tableFooterView = UIView()
        CELL.backgroundColor = UIColor.systemGray6
        CELL.dataSource = self
        CELL.delegate = self
    }

}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        if tableView.isEditing {
        return.none
        } else{
            return .delete
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    {
        return "Удалить"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        change(at: indexPath.row)
        /////////////////////////////////////
        if username[indexPath.row]["com"]as! Bool
        {

            let alert1 = UIAlertController(title: "Сколько стоило?", message: "", preferredStyle: .alert)
            alert1.addTextField
            {
                (textfield) in textfield.placeholder = "Вводи давай!"
            }
            if let textField = alert1.textFields?.first as UITextField?
            {
                textField.keyboardType = UIKeyboardType.decimalPad
            }
            let alertaction = UIAlertAction(title: "Готово", style: .default)
            {
                (alertaction) in
                if alert1.textFields![0].text! != ""
                {

                    username[indexPath.row]["sum"] = alert1.textFields![0].text!
                    self.summ()
                    self.CELL.reloadData()
                }
            }
            /*let aletactoin2 = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)*/
            let aletactoin2 = UIAlertAction(title: "Отмена", style: .default, handler: { (UIAlertAction) in
                change(at: indexPath.row)
                tableView.reloadData()                //username[indexPath.row]["com"] = false
            })
            
            alert1.addAction(alertaction)
            alert1.addAction(aletactoin2)
            present(alert1,animated: true,completion: nil)
        } else {
            username[indexPath.row]["sum"] = "00.00"
        }
        /////////////////////////////////////
        summ()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, shouldIdentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

extension ViewController :UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return username.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableView.dequeueReusableCell(withIdentifier: "mycel", for: indexPath)
        let user = username[indexPath.row]
        cel.textLabel?.text = user["name"] as? String
        cel.detailTextLabel?.text = user["sum"] as? String
        if user["com"] as! Bool {
            //cel.accessoryType = .checkmark
            cel.imageView?.image = .checkmark
        } else{
            cel.imageView?.image = .none
        }
        return cel
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        //arr.remove(at: indexPath.row)
        removeItem(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
   
    ///
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        /*let movedObject = self.arr[sourceIndexPath.row]
        arr.remove(at: sourceIndexPath.row)
        arr.insert(movedObject, at: destinationIndexPath.row)*/
        
        let movedObject = username[sourceIndexPath.row]
        removeItem(at: sourceIndexPath.row)
        chanItem(nameItem: movedObject["name"] as! String, compl : movedObject["com"] as! Bool,sum : movedObject["sum"] as! String ,at: destinationIndexPath.row)
        
        
    }
    ///
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
