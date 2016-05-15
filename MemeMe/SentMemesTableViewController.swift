//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Keisuke Kishida on 5/7/16.
//  Copyright © 2016 kishidak. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme]!{
        get{return (UIApplication.sharedApplication().delegate as! AppDelegate).memes}
        set{}
    }
  
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView?.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.memes.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell", forIndexPath: indexPath)
        let meme = memes[indexPath.row]
        
        // Set the name and image
        cell.imageView?.image = meme.image
        cell.textLabel?.text = meme.topText + " " + meme.bottomText
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }


    
//  call the meme viewer and editor
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let object: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")
        let detailController = object as! MemeDetailViewController
        
        detailController.index = indexPath.row
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    @IBAction func addMeme(sender: AnyObject) {
        
        let editController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.navigationController!.pushViewController(editController, animated: true)
        
    }
    
    
}
