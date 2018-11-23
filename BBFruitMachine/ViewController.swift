//
//  ViewController.swift
//  BBFruitMachine
//
//  Created by 120v on 2018/11/21.
//  Copyright © 2018 MQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    var fruitMachine:BBFruitMachine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fruitMachine = BBFruitMachine(frame: CGRect(x: 40, y: 520, width: self.view.frame.width - 40*2, height: 50))
        fruitMachine?.backgroundColor = UIColor.orange
        self.bgView.addSubview(fruitMachine!)
    }
    
    @IBAction func startAction(_ sender: Any) {
        self.fruitMachine?.prizeResult()
        self.fruitMachine?.start()
    }
}

