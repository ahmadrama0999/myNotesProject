//
//  Model.swift
//  toDoList
//
//  Created by Ramin Akhmad on 20.05.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import Foundation

var myNotes: [[String : Any]] {
    get {
        if let  array = UserDefaults.standard.array(forKey: "KeyForNotes") as?  [[String : Any]] {
            return array
        } else {
            return []
        }
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "KeyForNotes")
        UserDefaults.standard.synchronize()
    }
}
func addItem(nameItem: String, isCompleted: Bool = false ) {
    myNotes.append(["Name": nameItem, "isCompleted": isCompleted])
    countBadge()
}

func removeItem(at index: Int) {
    myNotes.remove(at: index)
    countBadge()
}

func moveNotes(from: Int, to:Int) {
    let previousNote = myNotes[from]
    myNotes.remove(at: from)
    myNotes.insert(previousNote, at: to)
}

func changeState(at note: Int) -> Bool {
    myNotes[note]["isCompleted"] = !(myNotes[note]["isCompleted"] as! Bool)
    countBadge()
    return myNotes[note]["isCompleted"] as! Bool
}

