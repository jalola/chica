//
//  PlaceInfoViewController.swift
//  Agile24
//
//  Created by Hung Nguyen on 11/24/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit
import Foundation

class PlaceInfoViewController : UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelShortDesc: UILabel!
    @IBOutlet weak var textDesc: UITextView!
    @IBOutlet weak var labelContact: UILabel!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var buttonCollectBadge: UIButton!
    
    
    @IBAction func collect(_ sender: Any) {
        if wasCheck == "" {
//            self.buttonCollectBadge.setImage(UIImage(named: ("button_" + type + "_pressed" + ".png")), for: UIControlState.normal)
            self.buttonCollectBadge.setImage(UIImage(named: "button_disabled.png"), for: UIControlState.normal)
            self.buttonCollectBadge.isUserInteractionEnabled = false
            Helpers.writeFile("read_" + (item?.id)!, text: (item?.id)!)
        }
    }
    
    var item: Item?
//    var checked: Bool?
    var wasCheck: String = ""
    var type = ""
    var originalHei: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.textDesc.delegate = self
        
        var upperHex = ""
        var bottomHex = ""
        
        
        if Helpers.wasChecked("read_" + (item?.id)!){
            wasCheck = "_pressed"
        }
        
        if item?.type == "Event" {
            upperHex = Constants.EVENT_UPPER_COLLOR
            bottomHex = Constants.EVENT_LOWER_COLLOR
            type = "event"
        }
        else if item?.type == "Location" {
            upperHex = Constants.LOCATION_UPPER_COLLOR
            bottomHex = Constants.LOCATION_LOWER_COLLOR
            type = "location"
        }
        else if item?.type == "People" {
            upperHex = Constants.PEOPLE_UPPER_COLLOR
            bottomHex = Constants.PEOPLE_LOWER_COLLOR
            type = "people"
        }
        else if item?.type == "Teams" {
            upperHex = Constants.TEAM_UPPER_COLLOR
            bottomHex = Constants.TEAM_LOWER_COLLOR
            type = "team"
        }
        else{
            upperHex = Constants.JOKE_UPPER_COLLOR
            bottomHex = Constants.JOKE_LOWER_COLLOR
            type = "funfact"
        }
        
        self.upperView.backgroundColor = UIColor(hexString: upperHex)
        self.scrollView.backgroundColor = UIColor(hexString: bottomHex)
        
        if wasCheck == "" {
            self.buttonCollectBadge.setImage(UIImage(named: ("button_" + type + ".png")), for: UIControlState.normal)
            self.buttonCollectBadge.setImage(UIImage(named: ("button_" + type +  "_pressed.png")), for: UIControlState.highlighted)
            self.buttonCollectBadge.setImage(UIImage(named: ("button_" + type +  "_pressed.png")), for: UIControlState.selected)
        }
        else{
            self.buttonCollectBadge.setImage(UIImage(named: "button_disabled.png"), for: UIControlState.normal)
            self.buttonCollectBadge.isUserInteractionEnabled = false
        }
        
        self.labelTitle.text = item?.title
//        self.textDesc.text = item?.mainDesc
        self.labelShortDesc.text = item?.shortDesc
        self.labelContact.text = "Contact: " + (item?.contact)!
        
//        print(item?.mainDesc)
        
        print("size 1: ")
        print(self.textDesc.contentSize.height)
        originalHei = self.textDesc.contentSize.height
        
        
        let strOfDesc = "<p style='font-family:Helvetica Neue; font-size:20; text-align:justify'>" + (item?.mainDesc)! + "</p>"
        print(strOfDesc)
//        <p style='font-family:Courier New; font-size:3'>Hello <span style='color:blue'>html</span></p>
        let attrStr = try! NSMutableAttributedString(
            data: (strOfDesc.data(using: String.Encoding.unicode, allowLossyConversion: true)!),
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
//        attrStr.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue", size: 30.0)!, range: NSRange.init(location: 0, length: attrStr.length))
        self.textDesc.attributedText = attrStr
        print("size 2: ")
        print(self.textDesc.contentSize.height)
        
//        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 20.0
//        paragraphStyle.maximumLineHeight = 20.0
//        paragraphStyle.minimumLineHeight = 20.0
//        let ats = [NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 11.0)!, NSParagraphStyleAttributeName: paragraphStyle]
//        cell.textView.attributedText = NSAttributedString(string: "you string here", attributes: ats)
        
        self.image.image = UIImage(named: (item?.images)!)
        self.image.layer.cornerRadius = 8.0
        self.image.clipsToBounds = true
        self.image.layer.borderColor = UIColor.white.cgColor
        self.image.layer.borderWidth = 4
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("size 3: ")
        print(self.textDesc.contentSize.height)
        
        let differentHei = self.textDesc.contentSize.height - originalHei!
        print("size 3: ")
        print(differentHei)
        
        if differentHei > 0{
            self.scrollView.contentSize = CGSize(width:self.scrollView.contentSize.width, height: self.scrollView.contentSize.height + differentHei)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
