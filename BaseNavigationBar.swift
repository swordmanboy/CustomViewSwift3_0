//
//  BaseNavigationBar.swift
//  Kubota
//
//  Created by Wewillapp03 on 10/15/2559 BE.
//  Copyright © 2559 Wewillapp. All rights reserved.
//

import UIKit
//import SnapKit

extension UIViewController{

    func setNavigationCustomTextMiddle(title:String!, titleRight:String?, titleLeft:String?, imgRight:UIImage?, imgLeft:UIImage?,isTransparent:Bool,isRightThisPoint:Bool){
        var buttonRight : NSMutableAttributedString!
        var buttonLeft : NSMutableAttributedString!
        let language : LANGUAGE! = AppDataValue.shared.language
        var attributes : [String : Any]! = [String : Any]()

        
        let centerGesture = UITapGestureRecognizer(target: self, action: #selector(self.centerMenuAction(sender:)))
        let labelTitleView : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        labelTitleView.textColor = UIColor.white
        labelTitleView.font = UIFont(name: CustomFontName.sukumvit_medium, size: UIScreen.main.bounds.height * FONT_SEMI_BIG)
        labelTitleView.text = title
        labelTitleView.adjustsFontSizeToFitWidth = true
        labelTitleView.minimumScaleFactor = 0.5
        labelTitleView.isUserInteractionEnabled = true
        labelTitleView.addGestureRecognizer(centerGesture)
        labelTitleView.textAlignment = NSTextAlignment.center
        labelTitleView.sizeToFit()
        
        if titleLeft != nil || imgLeft != nil{
            let leftBtn : UIButton = UIButton(type: UIButtonType.custom)
            leftBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
            leftBtn.addTarget(self, action: #selector(self.leftMenuActon(btnView:)), for: UIControlEvents.touchUpInside)
            if (titleLeft != nil && imgLeft == nil) || (titleLeft != nil && imgLeft != nil){
                if let fontLeft = UIFont(name: CustomFontName.sukumvit_medium, size: UIScreen.main.bounds.height * FONT_MEDIUM) {
                    attributes = [NSFontAttributeName: fontLeft,
                                  NSForegroundColorAttributeName : UIColor.white,
                                  NSUnderlineStyleAttributeName : 0] as [String : Any]
                    buttonLeft = NSMutableAttributedString(string:titleLeft! ,attributes:attributes)
                }
                
                leftBtn.setTitle(titleLeft, for: UIControlState.normal)
                leftBtn.titleLabel?.adjustsFontSizeToFitWidth = true
                leftBtn.titleLabel?.numberOfLines = 1
                leftBtn.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
                leftBtn.setAttributedTitle(buttonLeft, for: .normal)
                
                let leftBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: leftBtn)
                self.navigationItem.setLeftBarButton(leftBarButtonItemEdit, animated: false)
            }
            
            if imgLeft != nil && titleLeft == nil{
                if imgLeft == UIImage.init(named: "back"){
                    print("back")
                    //Back buttion
                    let viewLeft = UIView(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
                    let btnLeftMenu: UIButton = UIButton()
                    btnLeftMenu.setTitle("btn_back".localized(lang: language.rawValue), for: UIControlState.normal)
                    btnLeftMenu.setTitleColor(UIColor.clear, for: UIControlState.normal)
//                    btnLeftMenu.setTitle("".localized(lang: language.rawValue), for: UIControlState.normal)
                    btnLeftMenu.titleLabel?.font = UIFont(name: CustomFontName.sukumvit_medium, size: UIScreen.main.bounds.height * FONT_SEMI_MEDIUM)
                    btnLeftMenu.frame = CGRect(x: SIZE_IMAGE_BACK + 2, y: 0, width: 33/2, height: 27/2)
                    btnLeftMenu.sizeToFit()
                    btnLeftMenu.frame = CGRect(x:  SIZE_IMAGE_BACK + 2 , y: 0, width: btnLeftMenu.frame.width + 10, height: btnLeftMenu.frame.height)
                    viewLeft.frame = CGRect(x: 0, y: 0, width: btnLeftMenu.frame.width + SIZE_IMAGE_BACK , height: btnLeftMenu.frame.height)
                    btnLeftMenu.contentHorizontalAlignment = .left
                    let imgBack = UIImageView(frame: CGRect.init(x: 0, y: (btnLeftMenu.frame.height - SIZE_IMAGE_BACK)/2.0, width: SIZE_IMAGE_BACK, height: SIZE_IMAGE_BACK))
                    imgBack.image = imgLeft
                    viewLeft.addSubview(btnLeftMenu)
                    viewLeft.addSubview(imgBack)
                    let gestureBack = UITapGestureRecognizer(target: self, action: #selector(self.leftMenuActon(btnView:)))
                    imgBack.isUserInteractionEnabled = true
                    imgBack.addGestureRecognizer(gestureBack)
                    btnLeftMenu.addTarget(self, action: #selector(self.leftMenuActon(btnView:)), for: UIControlEvents.touchUpInside)
                    let barButton = UIBarButtonItem(customView: viewLeft)
                    self.navigationItem.leftBarButtonItem = barButton
                }else{
                    let leftMenu: UIButton = UIButton(type: UIButtonType.custom)
                    leftMenu.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
                    leftMenu.setImage(imgLeft, for: UIControlState.normal)
                    leftMenu.imageView?.contentMode = .scaleAspectFit
                    leftMenu.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0.0, 20);
                    leftMenu.addTarget(self, action: #selector(self.leftMenuActon(btnView:)), for: UIControlEvents.touchUpInside)
                    let leftBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: leftMenu)
                    self.navigationItem.setLeftBarButton(leftBarButtonItemEdit, animated: false)
                }

            }
        }else{
            //set nil to left
        }
        
        if titleRight != nil || imgRight != nil{
            if (titleRight != nil && imgRight == nil) || (titleRight != nil && imgRight != nil){
                if let font67Med = UIFont(name: CustomFontName.sukumvit_medium, size: UIScreen.main.bounds.height * FONT_MEDIUM){
                    attributes = [NSFontAttributeName: font67Med,
                                  NSForegroundColorAttributeName : UIColor.white,
                                  NSUnderlineStyleAttributeName : 0] as [String : Any]
                    buttonRight = NSMutableAttributedString(string:titleRight!, attributes:attributes)
                }
                
                let rightMenu: UIButtonCustom = UIButtonCustom(type: UIButtonType.custom)
                rightMenu.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
                rightMenu.setAttributedTitle(buttonRight, for: UIControlState.normal)
                rightMenu.titleLabel?.adjustsFontSizeToFitWidth = true
                rightMenu.titleLabel?.textAlignment = .center
                rightMenu.titleLabel?.numberOfLines = 1
                rightMenu.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
                
                if isRightThisPoint == true{
                    rightMenu.setBtnForScaleSizeMin(isScale: true)
                    rightMenu.titleEdgeInsets = UIEdgeInsets.init(top: 4, left: 5, bottom: 4, right: 5)
                    rightMenu.backgroundColor = "#48dac8".hexStringToUIColor()
                    rightMenu.frame = CGRect(x: rightMenu.bounds.origin.x, y: rightMenu.bounds.origin.y, width: rightMenu.bounds.width * 1.30, height: rightMenu.bounds.height * 0.95)
                    rightMenu.layer.cornerRadius = rightMenu.frame.height / 2.0
                    rightMenu.titleLabel?.font = UIFont.init(name: rightMenu.titleLabel!.font.fontName, size: UIScreen.main.bounds.height * FONT_SEMI_MEDIUM)
                }
                
                rightMenu.addTarget(self, action: #selector(self.rightMenuActon(btnView:)), for: UIControlEvents.touchUpInside)
                let rightBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: rightMenu)
                self.navigationItem.setRightBarButton(rightBarButtonItemEdit, animated: false)
            }
            
            if imgRight != nil && titleRight == nil{
                let rightMenu: UIButton = UIButton(type: UIButtonType.custom)
                rightMenu.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
                rightMenu.setImage(imgRight, for: UIControlState.normal)
                rightMenu.imageView?.contentMode = .scaleAspectFit
                rightMenu.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0.0, -20);
                rightMenu.addTarget(self, action: #selector(self.rightMenuActon(btnView:)), for: UIControlEvents.touchUpInside)
                let rightBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: rightMenu)
                self.navigationItem.setRightBarButton(rightBarButtonItemEdit, animated: false)
            }
        }else{
            //set nil to Right
        }
        
        

        
        let heightImageLoc : CGFloat! = 13
        let widthImageLoc : CGFloat! = 13
        let imageCenter : UIImageView! = UIImageView(frame: CGRect(x: (labelTitleView.frame.width), y: (labelTitleView.frame.height / 2 - (heightImageLoc/2)), width:heightImageLoc, height: widthImageLoc))
        imageCenter.image = UIImage(named: "select-location")
        labelTitleView.addSubview(imageCenter)
        self.navigationItem.titleView = labelTitleView
        
        //medthod 1
        //set color navigation bar
        if isTransparent == false{
            self.navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: ColorData.colorTabbarActive)
            self.navigationController?.navigationBar.isTranslucent = false
        }else{
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.edgesForExtendedLayout = [.top]
            self.extendedLayoutIncludesOpaqueBars = true
            self.automaticallyAdjustsScrollViewInsets = true
        }
    }
    
    func onCloseSearch(sender:UIGestureRecognizer){
        print("onCloseSearch    ")
    }
    
    func onDidChangeText(textfield :UITextField){
        print("onDidChangeText")
    }
    
    
    func setNavigationCustomBackTextRightImageForResult(title:String!, isRight:Bool!, isLeft:Bool, imgRight:UIImage, titleLeft:String!){
        let buttonTitleStr : NSMutableAttributedString!
        let buttonTitleStr2 : NSMutableAttributedString!
        var buttonRight : NSMutableAttributedString!
        var buttonLeft : NSMutableAttributedString!
        if let cFont = UIFont(name: CustomFontName.sukumvit_bold, size: 16) {
            let attributes = [NSFontAttributeName: cFont,
                              NSForegroundColorAttributeName : UIColor.white,
                              NSUnderlineStyleAttributeName : 1] as [String : Any]
            buttonTitleStr = NSMutableAttributedString(string:"SKIP INTRO", attributes:attributes)
        }
        var attributes : [String : Any]! = [String : Any]()
        if let font67Med = UIFont(name: CustomFontName.sukumvit_medium, size: 15) {
            attributes = [NSFontAttributeName: font67Med,
                          NSForegroundColorAttributeName : UIColor.white,
                          NSUnderlineStyleAttributeName : 0] as [String : Any]
            buttonLeft = NSMutableAttributedString(string:titleLeft ,attributes:attributes)
            buttonRight = NSMutableAttributedString(string:"", attributes:attributes)
        }
        
        
        let centerGesture = UITapGestureRecognizer(target: self, action: #selector(self.centerMenuAction(sender:)))
        let labelTitleView : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        labelTitleView.textColor = UIColor.white
        labelTitleView.font = UIFont(name: CustomFontName.sukumvit_medium, size: 16)
        labelTitleView.text = title
        labelTitleView.isUserInteractionEnabled = true
        labelTitleView.addGestureRecognizer(centerGesture)
        labelTitleView.textAlignment = NSTextAlignment.center
        labelTitleView.sizeToFit()
        let heightImageLoc : CGFloat! = 13
        let widthImageLoc : CGFloat! = 13
        let imageCenter : UIImageView! = UIImageView(frame: CGRect(x: (labelTitleView.frame.width), y: (labelTitleView.frame.height / 2 - (heightImageLoc/2)), width:heightImageLoc, height: widthImageLoc))
        imageCenter.image = UIImage(named: "select-location")
        labelTitleView.addSubview(imageCenter)
        self.navigationItem.titleView = labelTitleView
        
        if isLeft == true{
            let leftBtn : UIButton = UIButton(type: UIButtonType.custom)
            leftBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
            leftBtn.isHidden = false
            
            if isLeft == true{
                leftBtn.setTitle(titleLeft, for: UIControlState.normal)
            }else{
                leftBtn.setTitle("", for: UIControlState.normal)
            }
            leftBtn.setAttributedTitle(buttonLeft, for: .normal)
            leftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -40, bottom: 0, right: 40)
            leftBtn.addTarget(self, action: #selector(self.leftMenuActon(btnView:)), for: UIControlEvents.touchUpInside)
            let imgView : UIImageView! = UIImageView(frame: CGRect(x: -10, y: 12.5 - 5, width: 10, height: 10))
            imgView.image = UIImage(named: "back2")
            leftBtn.addSubview(imgView)
            
            let leftBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: leftBtn)
            self.navigationItem.setLeftBarButton(leftBarButtonItemEdit, animated: false)
        }
        
        
        let rightMenu: UIButton = UIButton(type: UIButtonType.custom)
        rightMenu.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
        rightMenu.isHidden = !isRight
        if isRight == true{
            rightMenu.setImage(imgRight, for: UIControlState.normal)
            rightMenu.imageView?.contentMode = .scaleAspectFit
            rightMenu.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0.0, -20);
            
        }
        rightMenu.addTarget(self, action: #selector(self.rightMenuActon(btnView:)), for: UIControlEvents.touchUpInside)
        rightMenu.isHidden = !isRight
        let rightBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: rightMenu)
        self.navigationItem.setRightBarButton(rightBarButtonItemEdit, animated: false)
        
        
        
        
        //medthod 1
        //set color navigation bar
        self.navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: ColorData.colorTabbarActive)
        
        self.navigationController?.navigationBar.isTranslucent = false
        
    }
    
    func centerMenuAction(sender:UITapGestureRecognizer){
        print("centerMenuAction")
    }
    
    func rightMenuActon(btnView:UIBarButtonItem){
        dismissKeyboard()
        print("rightActon")
    }
    
    func leftMenuActon(btnView:UIBarButtonItem){
        dismissKeyboard()
        print("leftActon")
    }
    
    
    
    func onTouchDownTextField(textFiled:UITextField){
        textFiled.resignFirstResponder()
        print("onTouchDownTextField")
    }
    
    func setNavigationCustomTextMiddle(title:String!,subTitle:String!, titleRight:String?, titleLeft:String?, imgRight:UIImage?, imgLeft:UIImage?){
        var buttonRight : NSMutableAttributedString!
        var buttonLeft : NSMutableAttributedString!
        
        var attributes : [String : Any]! = [String : Any]()
        
        
        let centerGesture = UITapGestureRecognizer(target: self, action: #selector(self.centerMenuAction(sender:)))
        let viewCenter : UIView! = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 50))
//        viewCenter.backgroundColor = UIColor.red
        let labelTitleView : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 25 ))
        labelTitleView.textColor = UIColor.white
        labelTitleView.font = UIFont(name: CustomFontName.sukumvit_medium, size: UIScreen.main.bounds.height * FONT_SEMI_BIG)   
        labelTitleView.text = title
        labelTitleView.isUserInteractionEnabled = true
        labelTitleView.addGestureRecognizer(centerGesture)
        labelTitleView.textAlignment = NSTextAlignment.center
        labelTitleView.sizeToFit()
        
        let labelsubTitleView : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 15))
        labelsubTitleView.textColor = UIColor.black
        labelsubTitleView.font = UIFont(name: CustomFontName.sukumvit_bold, size: 12)
        labelsubTitleView.text = title
        labelsubTitleView.isUserInteractionEnabled = true
        labelsubTitleView.addGestureRecognizer(centerGesture)
        labelsubTitleView.textAlignment = NSTextAlignment.center
        labelsubTitleView.sizeToFit()
        
        viewCenter.addSubview(labelTitleView)
        viewCenter.addSubview(labelsubTitleView)
        
        if titleLeft != nil || imgLeft != nil{
            let leftBtn : UIButton = UIButton(type: UIButtonType.custom)
            leftBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
            leftBtn.addTarget(self, action: #selector(self.leftMenuActon(btnView:)), for: UIControlEvents.touchUpInside)
            if (titleLeft != nil && imgLeft == nil) || (titleLeft != nil && imgLeft != nil){
                if let fontLeft = UIFont(name: CustomFontName.sukumvit_medium, size: 20) {
                    attributes = [NSFontAttributeName: fontLeft,
                                  NSForegroundColorAttributeName : UIColor.white,
                                  NSUnderlineStyleAttributeName : 0] as [String : Any]
                    buttonLeft = NSMutableAttributedString(string:titleLeft! ,attributes:attributes)
                }
                
                leftBtn.setTitle(titleLeft, for: UIControlState.normal)
                leftBtn.setAttributedTitle(buttonLeft, for: .normal)
                
                let leftBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: leftBtn)
                self.navigationItem.setLeftBarButton(leftBarButtonItemEdit, animated: false)
            }
            
            if imgLeft != nil && titleLeft == nil{
                let leftMenu: UIButton = UIButton(type: UIButtonType.custom)
                leftMenu.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
                leftMenu.setImage(imgLeft, for: UIControlState.normal)
                leftMenu.imageView?.contentMode = .scaleAspectFit
                leftMenu.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0.0, 20);
                leftMenu.addTarget(self, action: #selector(self.leftMenuActon(btnView:)), for: UIControlEvents.touchUpInside)
                let leftBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: leftMenu)
                self.navigationItem.setLeftBarButton(leftBarButtonItemEdit, animated: false)
            }
        }else{
            //set nil to left
        }
        
        if titleRight != nil || imgRight != nil{
            if (titleRight != nil && imgRight == nil) || (titleRight != nil && imgRight != nil){
                if let font67Med = UIFont(name: CustomFontName.sukumvit_medium, size: 15) {
                    attributes = [NSFontAttributeName: font67Med,
                                  NSForegroundColorAttributeName : UIColor.white,
                                  NSUnderlineStyleAttributeName : 0] as [String : Any]
                    buttonRight = NSMutableAttributedString(string:titleRight!, attributes:attributes)
                }
                
                let rightMenu: UIButton = UIButton(type: UIButtonType.custom)
                rightMenu.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
                rightMenu.setAttributedTitle(buttonRight, for: UIControlState.normal)
                rightMenu.addTarget(self, action: #selector(self.rightMenuActon(btnView:)), for: UIControlEvents.touchUpInside)
                let rightBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: rightMenu)
                self.navigationItem.setRightBarButton(rightBarButtonItemEdit, animated: false)
            }
            
            if imgRight != nil && titleRight == nil{
                let rightMenu: UIButton = UIButton(type: UIButtonType.custom)
                rightMenu.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
                rightMenu.setImage(imgRight, for: UIControlState.normal)
                rightMenu.imageView?.contentMode = .scaleAspectFit
                rightMenu.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0.0, -20);
                rightMenu.addTarget(self, action: #selector(self.rightMenuActon(btnView:)), for: UIControlEvents.touchUpInside)
                let rightBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: rightMenu)
                self.navigationItem.setRightBarButton(rightBarButtonItemEdit, animated: false)
            }
        }else{
            //set nil to Right
        }
        
        
        
        
//        let heightImageLoc : CGFloat! = 13
//        let widthImageLoc : CGFloat! = 13
//        let imageCenter : UIImageView! = UIImageView(frame: CGRect(x: (labelTitleView.frame.width), y: (labelTitleView.frame.height / 2 - (heightImageLoc/2)), width:heightImageLoc, height: widthImageLoc))
//        imageCenter.image = UIImage(named: "select-location")
//        labelTitleView.addSubview(imageCenter)
//        
//        labelTitleView.snp.makeConstraints { (make) in
//            make.left.right.equalTo(viewCenter).inset(0)
//            make.top.equalTo(viewCenter).inset(4)
//            make.bottom.equalTo(labelsubTitleView.snp.top).inset(0)
//        }
//        
//        labelsubTitleView.snp.makeConstraints { (make) in
//            make.top.equalTo(labelTitleView.snp.bottom).inset(0)
//            make.right.left.equalTo(viewCenter).inset(0)
//            make.bottom.equalTo(viewCenter).inset(5)
//        }
//        self.navigationItem.titleView = viewCenter
        
        //medthod 1
        //set color navigation bar
        self.navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: ColorData.colorTabbarActive)
        
        self.navigationController?.navigationBar.isTranslucent = false
        
    }

}
