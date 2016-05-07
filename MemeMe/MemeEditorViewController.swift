//
//  ViewController.swift
//  MemeMe
//
//  Created by Keisuke Kishida on 5/2/16.
//  Copyright © 2016 kishidak. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var pickButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    
    var imageLoaded: Bool = false  // for enabling the sharing button
    
    let memeTextAttributes = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -6.0,
    ]
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        imagePickerView.contentMode = .ScaleAspectFit
        
        topText.delegate = self
        topText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = NSTextAlignment.Center
        topText.placeholder = "TOP"
        
        bottomText.delegate = self
        bottomText.defaultTextAttributes = memeTextAttributes
        bottomText.textAlignment = NSTextAlignment.Center
        bottomText.placeholder = "BOTTOM"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        pickButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        shareButton.enabled = imageLoaded
    }
    

//    Managing an image
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {pickAnImage(.PhotoLibrary)}
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {pickAnImage(.Camera)}
    
    func pickAnImage(source: ImageSource) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .PhotoLibrary:
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        case .Camera:
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {imagePickerView.image = image}
        imageLoaded = true
        picker.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func generateMemedImage() -> Meme {
        
        let topText = self.topText.text!
        let bottomText = self.bottomText.text!
        let image = self.imagePickerView.image!
        
        //        Get a memed image
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let screenImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //        Crop the image for saving and sharing
        
        let cropRect = CGRect(x: self.imagePickerView.frame.minX, y: self.imagePickerView.frame.minY, width: self.imagePickerView.frame.width, height: self.imagePickerView.frame.height)
        let memedImage = UIImage(CGImage: CGImageCreateWithImageInRect(screenImage.CGImage, cropRect)!)
    
        let meme = Meme(topText: topText, bottomText: bottomText, image: image, memedImage: memedImage)
        return meme
        
    }
    
//    Share the memed image
    
    func save(meme: Meme) {
        
        let meme = Meme(topText: meme.topText, bottomText: meme.bottomText, image: meme.image, memedImage: meme.memedImage)
    }
    
    @IBAction func shareMemedImage(sender: AnyObject) {
        
        let meme = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        self.presentViewController(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = {(activityType, completed: Bool, returnedItems: [AnyObject]?, error: NSError?) in
            if completed {
                self.save(meme)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }

//    Alert for refreshing the memed image
    
    @IBAction func trash(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Refreshing the Meme", message: "For Sure?", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            action in self.refreshMeme()
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.Cancel) {
            action in self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func refreshMeme() {
        
        self.topText.text = nil
        self.bottomText.text = nil
        self.imagePickerView.image = nil
        self.imageLoaded = false
    
    }
    
    
//    Controlling keyboard and screen when editing the bottom textfield
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true

    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height

    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        self.view.frame.origin.y -= getKeyboardHeight(notification)
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        self.view.frame.origin.y += getKeyboardHeight(notification)
        
    }
    
    @IBAction func editingBegin(sender: AnyObject) {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    @IBAction func editingEnd(sender: AnyObject) {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
}


