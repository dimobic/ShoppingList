//
//  File.swift
//  TABLE
//
//  Created by Dima Chirukhin on 21.05.2020.
//  Copyright © 2020 Dima Chirukhin. All rights reserved.
//

import Foundation
var username : [[String:Any]] {
        set {
            UserDefaults.standard.set(newValue, forKey: "Key")
           // UserDefaults.standard.synchronize()
        } get{
            if let array = UserDefaults.standard.array(forKey: "Key") as? [[String:Any]] {
                return array
            }else{
                return []
            }
        }
    }
func addItem(	nameItem : String, compl :Bool = false, sum :String = "00,00"){
    username.append(["name" : nameItem, "com" : compl,"sum" : sum])
}

func chanItem(nameItem : String, compl :Bool = false, sum :String,at index : Int){
    username.insert(["name" : nameItem, "com" : compl, "sum" :sum], at: index)
}

func removeItem (at index: Int) {
    username.remove(at: index)
}

func change (at index: Int){
    username[index]["com"] = !((username[index]["com"] as! Bool) )
}
