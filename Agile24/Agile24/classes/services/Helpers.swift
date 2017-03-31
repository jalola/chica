//
//  Helpers.swift
//  Agile24
//
//  Created by Hung Nguyen on 11/23/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import Foundation
import UIKit


open class Helpers{
    
    open class func writeFile(_ fileName: String, text: String) -> Void{
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            let path = URL(fileURLWithPath: dir).appendingPathComponent(fileName)
            
            print(path)
            
            //writing
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
        }
    }
    
    open class func wasChecked(_ id: String) -> Bool{
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            let path = URL(fileURLWithPath: dir).appendingPathComponent(id)
            
            print(path)
            
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: path.path) {
                print("FILE AVAILABLE")
                return true
            } else {
                print("FILE NOT AVAILABLE")
                return false
            }
            
        }
        
        return false
    }
    
    open class func readFile(_ fileName: String) -> String{
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            let path = URL(fileURLWithPath: dir).appendingPathComponent(fileName)
            
            print(path)
            
            //reading
            do {
                let text = try NSString(contentsOf: path, encoding: String.Encoding.utf8.rawValue)
                return text as String
            }
            catch {/* error handling here */
                return ""
            }
        }
        
        return ""
    }
    
    open class func copyFile(_ fileName: String)
    {
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            let desPath = URL(fileURLWithPath: dir).appendingPathComponent(fileName)
            
            print(desPath)
            
            let fileMgr = FileManager.default
            
            let path = URL(fileURLWithPath: Bundle.main.path(forResource: fileName, ofType:"")!)
            print(path)
            
            
            do {
                try fileMgr.copyItem(at: path, to: desPath)

            }
            catch{
                print("failed, it's already there")
            }
        }
        
    }
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
