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
        
        self.tabBarController?.tabBar.hidden = true
        self.imageView!.image = appDelegate.memes[index].memedImage
        self.imageView.contentMode = .ScaleAspectFit
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
        
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let memeEditorVC: MemeEditorViewController = segue.destinationViewController as! MemeEditorViewController
        memeEditorVC.topTextForEdit = appDelegate.memes[index].topText
        memeEditorVC.bottomTextForEdit = appDelegate.memes[index].bottomText
        memeEditorVC.imageForEdit = appDelegate.memes[index].image
        memeEditorVC.index = index
    }
    
    
}
