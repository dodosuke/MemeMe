//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Keisuke Kishida on 5/7/16.
//  Copyright © 2016 kishidak. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        print("viewwillapear", memes.count)
        
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemesCollectionViewCell", forIndexPath: indexPath) as! MemesCollectionViewCell
        let meme = memes[indexPath.item]
        let imageView = UIImageView(image: meme.image)
        cell.backgroundView = imageView
        
        print("2/", memes.count)
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)

        
    }
    
    @IBAction func addMeme(sender: AnyObject) {
        
        let editController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.navigationController!.pushViewController(editController, animated: true)
        
    }
    
}