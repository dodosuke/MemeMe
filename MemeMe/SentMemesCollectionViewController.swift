//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Keisuke Kishida on 5/7/16.
//  Copyright © 2016 kishidak. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    var memes: [Meme]!{
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension: CGFloat = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.reloadData()
        
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemesCollectionViewCell", forIndexPath: indexPath) as! MemesCollectionViewCell
        
        let meme = memes[indexPath.item]
        
        cell.backgroundView = UIImageView(image: meme.memedImage)
        
        return cell
    }
    
//    Call the memeviewer
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        detailController.index = indexPath.row
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
//    Call the memeeditor
    
    @IBAction func addMeme(sender: AnyObject) {
        
        let editController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.navigationController!.pushViewController(editController, animated: true)
        
    }
    
}