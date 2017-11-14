//
//  PopCard.swift
//  PopCard
//
//  Created by 和田　継嗣 on 2017/11/13.
//  Copyright © 2017年 和田　継嗣. All rights reserved.
//

import Foundation
import UIKit

import Foundation
import UIKit

public protocol popCardProtcol{
    func wordPreserve(_ word:String,text:String)
}

public class PopCard:UIView{
    
    var word:String!
    var text:String!
    var lang:String!
    
    var wordLabel:UILabel!
    var textView:UITextView!
    var buttonL:UIButton!
    var pronounceButton:UIButton!
    var sayClass:SayClass!
    
    var delegate:popCardProtcol?
    
    let screenSize:CGSize = UIScreen.main.bounds.size
    
    public init (frame:CGRect,word:String,text:String,lang:String){
        super.init(frame: frame)
        self.backgroundColor = UIColorFromRGB(0x000000)
        self.word = word
        self.text = text
        self.lang = lang
        setView()
    }
    
    public init(word:String!,text:String,lang:String){
        super.init(frame:CGRect(x:0,y:screenSize.height,width:screenSize.width,height:200))
        self.word = word
        self.text = text
        self.lang = lang
        setView()
    }
    
    func setView(){
        self.backgroundColor = UIColorFromRGB(0x000000)
        self.backgroundColor?.withAlphaComponent(0.4)
        //単語ラベル
        wordLabel = UILabel(frame:CGRect(x: 10,y: 10,width: self.frame.size.width/2,height: 40))
        wordLabel.textColor = UIColor.white
        var attributeText = NSMutableAttributedString(string: text)
        attributeText.addAttributes([ NSAttributedStringKey.underlineStyle: NSUnderlineStyle.patternDot.rawValue|NSUnderlineStyle.styleSingle.rawValue], range: NSMakeRange(0, attributeText.length))
        wordLabel.attributedText = attributeText
        self.addSubview(wordLabel)
        //発音ラベル
        pronounceButton = UIButton(frame:CGRect(x: self.frame.size.width-70,y: 5,width: 20,height: 20))
        pronounceButton.addTarget(self, action: #selector(PopCard.pronounceWord), for: .touchUpInside)
        pronounceButton.setImage(UIImage(named:"megaPh.png"), for: UIControlState())
        self.addSubview(pronounceButton)
        //発音クラス
        self.sayClass = SayClass(lang: lang)
        textView = UITextView(frame:CGRect(x: 10,y: 60,width: self.frame.size.width-20,height: 90))
        textView.backgroundColor=UIColor(red:0.0,green:0.0,blue:0.0,alpha:0.0);
        textView.textColor = UIColor.white
        textView.font =  UIFont.systemFont(ofSize: CGFloat(14))//UIFont(name: UIFont., size: 14)
        textView.isEditable = false;
        textView.isScrollEnabled=true
        self.addSubview(textView)
        
        let buttonL = UIButton()
        buttonL.setTitle("Tap Me!", for: UIControlState())
        buttonL.addTarget(self, action: #selector(PopCard.dawnView), for: .touchUpInside)
        buttonL.frame = CGRect(x: self.frame.size.width-30, y: 5, width: 20, height: 20)
        let image2 = UIImage(named: "closing.png")!
        buttonL.setImage(image2, for: UIControlState())
        self.addSubview(buttonL)
        
        let wordPreButton = UIButton(frame:CGRect(x: 30,y: 155,width: self.frame.size.width-60,height: 40))
        wordPreButton.addTarget(self, action: #selector(PopCard.wordPreserve), for:.touchUpInside)
        wordPreButton.backgroundColor = UIColorFromRGB(0xFF5F5C)
        wordPreButton.layer.borderWidth = 1.0
        wordPreButton.layer.cornerRadius = 10.0
        wordPreButton.setTitle("単語カードに追加", for: UIControlState())
        
        self.addSubview(wordPreButton)
        
    }
    
    func setProperty(_ word:String,text:String){
        self.word = word
        self.text = text
        self.wordLabel.text = word
        self.textView.text = text
    }
    
    @objc public func dawnView(){
        //self.layer.position = CGPoint(x:0,y:screenSize.height+100)
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       // バネの弾性力. 小さいほど弾性力は大きくなる.
            usingSpringWithDamping: 0.7,
            // 初速度.
            initialSpringVelocity: 0.5,
            // 一定の速度.
            options: UIViewAnimationOptions.curveLinear,
            animations: { () -> Void in
                self.layer.position = CGPoint(x: self.screenSize.width/2, y: self.screenSize.height+self.frame.size.height/2)
                // アニメーション完了時の処理
        }) { (Bool) -> Void in
            
        }
        
    }
    
    @objc public func showView(){
        //self.layer.position = CGPoint(x:screenSize.width/2,y:screenSize.height-100)
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       // バネの弾性力. 小さいほど弾性力は大きくなる.
            usingSpringWithDamping: 0.7,
            // 初速度.
            initialSpringVelocity: 0.5,
            // 一定の速度.
            options: UIViewAnimationOptions.curveLinear,
            animations: { () -> Void in
                self.layer.position = CGPoint(x: self.screenSize.width/2, y: self.screenSize.height-self.frame.size.height/2)
                // アニメーション完了時の処理
        }) { (Bool) -> Void in
            
        }
    }
    
    @objc func pronounceWord(){
        self.sayClass.Wsay(self.word)
    }
    
    @objc public func wordPreserve(){
        print("保存")
        delegate?.wordPreserve(self.word,text: self.text)
    }
    
    func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(0.8)
        )
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

