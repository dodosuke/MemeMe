//
//  FontSelectViewController.swift
//  MemeMe
//
//  Created by Keisuke Kishida on 5/16/16.
//  Copyright © 2016 kishidak. All rights reserved.
//

import Foundation
import UIKit

class FontSelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //    Font selection
    
    let fonts: NSArray = ["White","Yellow","Red"]
    
    @IBOutlet weak var fontViewer: UITextField!
    
    var memeTextAttributes: [String: NSObject]!
    
    
//    FontViewer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fontViewer.text = "Choose Your Style!"
        fontViewer.defaultTextAttributes = memeTextAttributes
        fontViewer.textAlignment = NSTextAlignment.Center
        
    }
 
//    Font Selector
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fonts.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fonts[row] as? String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 1: memeTextAttributes = yellow
        case 2: memeTextAttributes = red
        default: memeTextAttributes = white
        }
        fontViewer.defaultTextAttributes = memeTextAttributes
        fontViewer.textAlignment = NSTextAlignment.Center
    }
    
//    Back to MemeEditor
    
    @IBAction func doneFontSelection(sender: AnyObject) {
        
        let editController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        editController.memeTextAttributesForEdit = memeTextAttributes
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
