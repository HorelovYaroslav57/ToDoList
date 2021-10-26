//
//  Model.swift
//  To Do List 2021
//
//  Created by Yaroslav Horelov on 29.08.2021.
//

import Foundation
import UserNotifications
import UIKit


var ToDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
}

    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String: Any]] {
            return  array
        } else {
            return []
        }
        
    }
}

func addItem(nameItem: String, isComplited: Bool = false) {
    ToDoItems.append(["Name": nameItem, "IsComplited": isComplited])
    setBadge()
    
}

func removeItem(at Index: Int) {
    ToDoItems.remove(at: Index)
    setBadge()
    
}

func moveItem (fromIndex: Int, toIndex: Int) {
    let from = ToDoItems[fromIndex]
    ToDoItems.remove(at: fromIndex)
    ToDoItems.insert(from, at: toIndex)
}



func changeState (at item: Int) -> Bool {
    ToDoItems[item]["isComplited"] = !(ToDoItems[item]["isComplited"] as! Bool)

    setBadge()
    
    return (ToDoItems[item]["isComplited"] as! Bool)
}

func requestForNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: .badge) { isEnabled, error in
        if isEnabled {
            print("Согласие получено!")
        } else {
            print("Пришел отказ!")
        }
    }
}

func setBadge() {
    var totalBadgeNumber = 0
    for item in ToDoItems {
        if (item["isComplited"] as? Bool) == false {
            totalBadgeNumber = totalBadgeNumber + 1
        }
    }
    
    UIApplication.shared.applicationIconBadgeNumber = totalBadgeNumber
    
}
