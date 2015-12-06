//
//  BundleResources.swift
//  Family Selector
//
//  Created by Daniel Khasanov on 12/4/15.
//  Copyright © 2015 Daniel Khasanov. All rights reserved.
//

import UIKit
import Foundation

class BundleResources: NSObject {
    
    
  
    

        class func nib(name: String) -> UINib?
        {
            let nib: UINib? = UINib(nibName: name, bundle: NSBundle.mainBundle());
            return nib
        }
        
        //Obtain view controller by name from main storyboard
        class func vcWithName(name: String) -> UIViewController?
        {
            let storyboard = mainStoryboard()
            let viewController: AnyObject! = storyboard.instantiateViewControllerWithIdentifier(name)
            return viewController as? UIViewController
        }
        
        //Obtain view controller by idx from nib
        class func viewFromNib(nibName: String, atIdx idx:Int) -> UIView?
        {
            let view =  NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil)[idx] as! UIView
            return view
        }
        
        //Main storybord
        class func mainStoryboard() -> UIStoryboard
        {
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            return storyboard
        }
        
        //Obtain file from main bundle by name and fileType
        class func fileFromBundle(fileName: String?, fileType: String?) -> NSURL?
        {
            var url: NSURL?
            
            if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
            {
                url = NSURL.fileURLWithPath(path)
            }
            
            return url
            
        }
    

}
