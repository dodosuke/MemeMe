//
//  Meme.swift
//  MemeMe
//
//  Created by Keisuke Kishida on 5/4/16.
//  Copyright © 2016 kishidak. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
        
    var topText: String
    var bottomText: String
    var memeTextAttributes: [String: NSObject]
    var image: UIImage
    var memedImage: UIImage
            
}

var white: [String: NSObject] = [
    NSForegroundColorAttributeName: UIColor.whiteColor(),
    NSStrokeColorAttributeName: UIColor.blackColor(),
    NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName : -6.0
]

var yellow: [String: NSObject] = [
    NSForegroundColorAttributeName: UIColor.yellowColor(),
    NSStrokeColorAttributeName: UIColor.blackColor(),
    NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName : -6.0
]

var red: [String: NSObject] = [
    NSForegroundColorAttributeName: UIColor.redColor(),
    NSStrokeColorAttributeName: UIColor.blackColor(),
    NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName : -6.0
]


