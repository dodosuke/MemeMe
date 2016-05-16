//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Keisuke Kishida on 5/7/16.
//  Copyright © 2016 kishidak. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController : UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var index: Int!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.hidden = true
        imageView!.image = appDelegate.memes[index].memedImage
        imageView.contentMode = .ScaleAspectFit
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.hidden = false
        
    }
    
    @IBAction func editMeme(sender: AnyObject) {
        
        let editController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        editController.topTextForEdit = appDelegate.memes[index].topText
        editController.bottomTextForEdit = appDelegate.memes[index].bottomText
        editController.imageForEdit = appDelegate.memes[index].image
        editController.index = index
        
        presentViewController(editController, animated: true, completion: nil)
        
    }
    
}
