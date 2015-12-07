//
//  ViewController.swift
//  Family Selector
//
//  Created by Daniel Khasanov on 12/3/15.
//  Copyright © 2015 Daniel Khasanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var familyMapScroller = [String : UIScrollView]() //Maps family name to their scrollview
    var familyMapScrollerContent = [String : UIView]() // Maps family name to their scroll contentView
    var familyMapScrollerContainer = [String : UIView]() //Maps family name to their scroller container view
    var familyMapTags = [Int : String]() //Maps family name to button tag
    var familyMapCount = [String : Int]() //Maps family name to number of members
    var familyMapCountDisplay = [String : UILabel]() //Maps family name to label view displaying number of members
    
    
    @IBOutlet weak var AddFamilyButton: UIBarButtonItem!
    
   
    //@IBOutlet var _scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //_scrollview = UIScrollView(frame: CGRectMake(0, 0, 416, 600 ))
        // Do any additional setup after loading the view, typically from a nib.
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBOutlet var familyScroller: UIScrollView!
    
    @IBOutlet var ContentView: UIView!
    
    @IBOutlet weak var AddFamilyDimlight: UIView!
   
    @IBOutlet weak var AddFamilyQueryBox: UIView!
    
    @IBOutlet weak var FamilyQueryBox: UIView!
    
    @IBOutlet weak var FamilyAddConfirm: UIButton!
    
    @IBOutlet weak var FamilyNameText: UITextField!
    
    @IBOutlet weak var FamilyAddCancel: UIButton!
    
    @IBAction func AddFamilyCancel(sender: AnyObject) {
        AddFamilyCancel()
    }
    
    func AddFamilyCancel() {
        AddFamilyQueryBox.hidden = true
        AddFamilyDimlight.hidden = true
        FamilyMemberQueryBox.hidden = true
        currentQueryEmail.text = ""
        FamilyNameText.text = ""
    }
    
   
    @IBAction func queryAddFamily(sender: UIButton) {
        familyScroller.setContentOffset(CGPoint(x: 0,y: -40), animated: true)
        AddFamilyQueryBox.hidden = false
        AddFamilyDimlight.hidden = false
        
    }
    
    var nextFamilyDisplacementHeight = 60
    var famDY = 20
    var famY = 125
    var buffer = 550
    
    
    func initializeNewFamily(name : String) -> UIView {
        //TODO: programatically resize the width!
        let newFamilyFrame = UIView(frame: CGRect(x: 20, y: nextFamilyDisplacementHeight, width: 364, height: famY))
            newFamilyFrame.backgroundColor = UIColor.whiteColor()
        
            let newFamilyInset = UIView(frame: CGRect(x: 0, y: 0, width: 364, height: (famY / 5)))
        
                newFamilyInset.backgroundColor = UIColor(red: CGFloat(0.95), green: CGFloat(0.33), blue: CGFloat(0.18), alpha: CGFloat(1))
                let newFamilyNameLabel = UILabel(frame: CGRect(x: 22, y: 0 , width: 364, height: (famY / 4)))
                    newFamilyNameLabel.text = name
                    newFamilyNameLabel.textColor = UIColor.whiteColor()
                    newFamilyNameLabel.textAlignment = NSTextAlignment.Center
                newFamilyInset.addSubview(newFamilyNameLabel)
        
        newFamilyFrame.addSubview(newFamilyInset)
        
        //width for 5/6 buttons
        let newFamilyScroller = UIScrollView(frame: CGRect(x:0, y: (famY/4), width: 0, height: (famY*3/4)))
            let newFamilyScrollerContent = UIView(frame: CGRect(x: 0, y: 0, width: 0 , height: (famY*3/4)))
                newFamilyScroller.contentSize = newFamilyScrollerContent.bounds.size
                //newFamilyScroller.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
                newFamilyScroller.autoresizingMask = UIViewAutoresizing.FlexibleWidth
                //newFamilyScroller.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        
        
            newFamilyScroller.addSubview(newFamilyScrollerContent)
        
            familyMapScrollerContent[name] = newFamilyScrollerContent
            familyMapScrollerContainer[name] = newFamilyFrame
            familyMapScroller[name] = newFamilyScroller
        
        newFamilyFrame.addSubview(newFamilyScroller)
        
        let newFamilyAddButton = UIButton(frame:  CGRect(x: 0, y: famY/5, width: 364*1/8, height: famY*3/5) )
        newFamilyAddButton.setImage(UIImage(named: "Circle_Add_Dark"), forState: UIControlState.Normal)
        newFamilyAddButton.tag = familyMapTags.count
        familyMapTags[newFamilyAddButton.tag] = name
        newFamilyAddButton.addTarget(self, action: "queryAddFamilyMember:", forControlEvents: UIControlEvents.TouchUpInside)
        newFamilyFrame.addSubview(newFamilyAddButton)
        
        
        familyMapCount[name] = 0
        let newFamilyMemberCount = UILabel(frame: CGRect(x:5, y: famY*4/5, width: 364, height: famY*1/5))
            newFamilyMemberCount.text = String(familyMapCount[name]!) + " members"
            newFamilyMemberCount.font = UIFont(name:"Helvetica-Bold", size:CGFloat(14))
            familyMapCountDisplay[name] = newFamilyMemberCount
        newFamilyFrame.addSubview(newFamilyMemberCount)
        
        
        nextFamilyDisplacementHeight += (famY + famDY)
        
        
        return newFamilyFrame
    }
    
    @IBOutlet var FamilyMemberQueryBox: UIView!
    var currentQueryFamilyTag : Int = 0
    
    @IBOutlet weak var currentQueryEmail: UITextField!
    var currentButtonToMove : UIButton!
    
    func queryAddFamilyMember(sender:UIButton)
    {
        currentQueryFamilyTag = sender.tag
        FamilyMemberQueryBox.hidden = false
        AddFamilyDimlight.hidden = false
        currentButtonToMove = sender
    }
    
    @IBAction func addFamilyMember(sender: AnyObject) {
        if currentQueryEmail.text != "" {
            let targetFamilyName = familyMapTags[currentQueryFamilyTag]
            let targetFamilyScrollviewContainer = familyMapScrollerContainer[targetFamilyName!]
            let targetFamilyScrollview = familyMapScroller[targetFamilyName!]
            let targetFamilyScrollviewContent = familyMapScrollerContent[targetFamilyName!]
            let targetFamilyCurrentCount = familyMapCount[targetFamilyName!]
            let targetFamilyCurrentCountDisplay = familyMapCountDisplay[targetFamilyName!]
            
            familyMapCount[targetFamilyName!] = targetFamilyCurrentCount! + 1
            targetFamilyCurrentCountDisplay?.text = String(targetFamilyCurrentCount! + 1) + " members"
            
            if (targetFamilyScrollview?.frame.size.width >= (targetFamilyScrollviewContainer?.frame.size.width)! * 6/8) {
                targetFamilyScrollview?.scrollEnabled = true
            } else {
                targetFamilyScrollview?.frame.size.width += 45
                currentButtonToMove.frame.origin.x += 45
            }
            
            let newMemberIcon = UIImage(named: "Member_Icon")
            let newMemberIconHolder = UIImageView(frame: CGRect(x: Int(targetFamilyScrollviewContent!.frame.size.width), y: 9, width: 45, height: 45))
            newMemberIconHolder.image = newMemberIcon
            targetFamilyScrollviewContent!.addSubview(newMemberIconHolder)
            
            targetFamilyScrollviewContent!.frame.size.width += 45
            
            
            
            currentQueryEmail.text = ""
            AddFamilyCancel()
        }
    }
    
    

  
    @IBOutlet var ContentViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var FamilyContentView: UIView!
    
    @IBAction func addFamily(sender: AnyObject) {
        if (FamilyNameText.text == "") {
            return
        } else {
            //allocates more visual space for families
            if ContentViewHeight.constant < CGFloat(nextFamilyDisplacementHeight + famY + famDY + buffer) {
                ContentViewHeight.constant = (ContentViewHeight.constant + CGFloat(famDY+famY))
            }
            
            let newFamily = initializeNewFamily(FamilyNameText.text!)
            
            FamilyContentView.addSubview(newFamily)
           //newFamily.widthAnchor.constraintEqualToAnchor(newFamily.superview?.widthAnchor)
        
            AddFamilyCancel()
            
            
        }
    }

}


