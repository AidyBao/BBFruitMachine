//
//  BBFruitMachine.swift
//  BBFruitMachine
//
//  Created by 120v on 2018/11/21.
//  Copyright © 2018 MQ. All rights reserved.
//

import UIKit

let FSPACE: CGFloat     = 0
let FWIDTH: CGFloat     = (UIScreen.main.bounds.size.width - 80)/3
let FMinTurn: Int       = 6
let FSLIDERTIME: Double = 0.15

class BBFruitMachine: UIView {
    
    var prizeResultList: Array<Int>     = [] //要求获奖结果
    var currentSlideResult: Array<Int>  = [] //目前停留位置
    
    var isSliding:Bool  = false //正在转动
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    func prizeResult() {
        self.prizeResultList.removeAll()
        self.currentSlideResult.removeAll()
        
        self.prizeResultList.append(Int(arc4random()%10))
        self.prizeResultList.append(Int(arc4random()%10))
        self.prizeResultList.append(Int(arc4random()%10))
        
        self.currentSlideResult.append(0)
        self.currentSlideResult.append(0)
        self.currentSlideResult.append(0)
        
    }
    
    
    //MARK: - reloadData
    func reloadData() {
        for i in 0..<3 {
            let containerLayer = CALayer()
            containerLayer.frame = CGRect(x: CGFloat(i)*(FWIDTH + FSPACE), y: 0, width: FWIDTH, height: self.frame.size.height)
            containerLayer.masksToBounds = true
            self.layer.addSublayer(containerLayer)
            
            let fScrollLayer = CALayer()
            fScrollLayer.frame = CGRect(x: 0, y: 0, width: FWIDTH, height: self.frame.size.height)
            containerLayer.addSublayer(fScrollLayer)
            
            self.fScrollLayerList.append(fScrollLayer)
            
            let prizeImgVHeight = self.frame.size.height/1
            let prizeCount = self.prizeList.count
            let scrollLayerTopIndex = -(i + FMinTurn + 3) * prizeCount
            for j in scrollLayerTopIndex..<0 {
                let prizeImg = self.prizeList[abs(j)%prizeCount]
                let prizeImgLayer = CALayer()
                prizeImgLayer.backgroundColor = UIColor(red: CGFloat(arc4random() % 255) / 255.0, green: CGFloat(arc4random() % 255) / 255.0, blue: CGFloat(arc4random() % 255) / 255.0, alpha: 1.0).cgColor
                let offsetYUnit = j + 1 + prizeCount;
                prizeImgLayer.frame = CGRect(x:0, y:CGFloat(offsetYUnit) * prizeImgVHeight, width:fScrollLayer.frame.size.width, height:prizeImgVHeight);
                
                prizeImgLayer.contents = prizeImg.cgImage;
                prizeImgLayer.contentsScale = prizeImg.scale;
                prizeImgLayer.contentsGravity = CALayerContentsGravity.center;
                
                fScrollLayer.addSublayer(prizeImgLayer)
            }
        }
    }
    
    //MARK: - Start
    func start() {
        
        if isSliding {
            return
        }else{
            isSliding = true
            if self.prizeResultList.count > 0 , self.currentSlideResult.count > 0 {
                
                CATransaction.begin()
                CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut))
                CATransaction.disableActions()
                CATransaction.setCompletionBlock {
                    self.isSliding = false
                    
                    for pLayer in self.fScrollLayerList {
                        pLayer.removeAllAnimations()
                    }
//                    self.currentSlideResult = self.prizeResultList
                }
                for (index, fScrollLayer)  in self.fScrollLayerList.enumerated() {
                    let resultIndex = self.prizeResultList[index]
                    let currentIndex = self.currentSlideResult[index]
                    
                    let howManyIndex = (index + FMinTurn) * self.prizeList.count + resultIndex - currentIndex
                    
                    let sliderAnimation = CABasicAnimation(keyPath: "position.y")
                    sliderAnimation.fillMode = .forwards
                    sliderAnimation.duration = Double(howManyIndex) * FSLIDERTIME
                    let slideY = CGFloat(howManyIndex) * self.frame.size.height / 1
                    sliderAnimation.toValue = fScrollLayer.position.y + slideY
                    sliderAnimation.isRemovedOnCompletion = false
                    fScrollLayer.add(sliderAnimation, forKey: nil)
                }
                CATransaction.commit()
            }else{
                
            }
        }
    }
    
    
    //MARK: - Lazy
    lazy var prizeList: Array<UIImage> = {
        var list = Array<UIImage>()
        list.append(UIImage(named: "Bell-icon")!)
        list.append(UIImage(named: "Cherry-icon")!)
        list.append(UIImage(named: "Chip-icon")!)
        list.append(UIImage(named: "Coin-icon")!)
        list.append(UIImage(named: "Dice-icon")!)
        list.append(UIImage(named: "Gem-icon")!)
        list.append(UIImage(named: "Lemon-icon")!)
        list.append(UIImage(named: "Lucky-7-icon")!)
        list.append(UIImage(named: "Melon-icon")!)
        list.append(UIImage(named: "Orange-icon")!)
        return list
    }()
    
    lazy var fScrollLayerList: Array<CALayer> = {
        let list = Array<CALayer>()
        return list
    }()
}
