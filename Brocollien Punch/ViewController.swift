//
//  ViewController.swift
//  Brocollien Punch
//
//  Created by dactrtr z on 2/23/17.
//  Copyright © 2017 dactrtr z. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var hitcounterLabel: UILabel!
    @IBOutlet weak var thirdLife: UIImageView!
    @IBOutlet weak var secondLife: UIImageView!
    @IBOutlet weak var firstLife: UIImageView!
    @IBOutlet weak var awesomeText: UILabel!
    @IBOutlet weak var reactionImage: UIImageView!
    @IBOutlet weak var comboLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var startGameButton: UIButton!
    
    var hitCounter = 0
    var lifesCounter = 0
    var isPlaying = false
    var arrowDirection = "none"
    var switchTimer = Timer()
    var checkLife = Timer()
    var lastCombo = 0
    var hits = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        awesomeText.isHidden = true
        comboLabel.isHidden = true
        arrowImage.isHidden = true
        hitCounter = 0
        lifesCounter = 3
        hitcounterLabel.text = String("\(hitCounter)")
        
    }

    @IBAction func StartGame(_ sender: Any) {
        lifesCounter = 3
        firstLife.image = UIImage (named: "heart-fill.png")
        secondLife.image = UIImage (named: "heart-fill.png")
        thirdLife.image = UIImage (named: "heart-fill.png")
        reactionImage.image = UIImage (named:"captn.still.png")
        comboLabel.isHidden = true
        
        
        
        if lifesCounter == 3 {
            
            checkLife = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.LifeChecker), userInfo: nil, repeats: true)
            
            startGameButton.isHidden = true
            isPlaying = true
            arrowImage.isHidden = false
            
            
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeGestures))
            swipeRight.direction = UISwipeGestureRecognizerDirection.right
            self.view.addGestureRecognizer(swipeRight)
            
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeGestures))
            swipeLeft.direction = UISwipeGestureRecognizerDirection.left
            self.view.addGestureRecognizer(swipeLeft)
            
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeGestures))
            swipeUp.direction = UISwipeGestureRecognizerDirection.up
            self.view.addGestureRecognizer(swipeUp)
            
            
            self.Combo()
            
        }
    }
    func LifeChecker(){
        // comboLabel.text = String("Next dab:\(hits) LastCombo:\(lastCombo)" ) // show me those numbers
        if hitCounter > lastCombo{
            lastCombo = hitCounter
        }
        
        if lifesCounter == 2{
            thirdLife.image = UIImage(named: "heart-empty.png")
        }
        if lifesCounter == 1{
            secondLife.image = UIImage(named: "heart-empty.png")
        }
        if lifesCounter == 0{
            firstLife.image = UIImage(named: "heart-empty.png")
            
            switchTimer.invalidate()
            checkLife.invalidate()
            comboLabel.isHidden = false
            comboLabel.text = "GAME OVER"
            startGameButton.setTitle("RESTART", for: [])
            startGameButton.isHidden = false
            isPlaying = false
            arrowImage.isHidden = true
            reactionImage.image = UIImage(named:"gameoverdance.png")
            hits = 10
        }

        
        
    }
    func Combo(){
        awesomeText.isHidden = true
        
        let array = ["left","right","up"]
        let randomWord = Int(arc4random_uniform(UInt32(array.count)))
        
        if array[randomWord] == "left" {
            arrowImage.image = UIImage(named: "left-arrow.png")
            arrowDirection = "left"
        }
        if array[randomWord] == "right" {
            arrowImage.image = UIImage(named: "right-arrow.png")
            arrowDirection = "right"
        }
        if array[randomWord] == "up" {
            arrowImage.image = UIImage(named: "up-arrow.png")
            arrowDirection = "up"
        }
        
        hitcombo()
        
        switchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.Combo), userInfo: nil, repeats: false)
        
    }
    
    func hitcombo(){
        
        let preCombo = ["QUE RITMO!","BAILA BAILA","DALE A TU CUERPO ALEGRIA","DIRECTO A XFACTOR","WEAPON X DEL BAILE","CUMBIA NENA"]
        let whoot = Int(arc4random_uniform(UInt32(preCombo.count)))

        if hitCounter == hits && hitCounter > 0{
            
            awesomeText.isHidden = false
            awesomeText.text = "\(preCombo[whoot])"
            reactionImage.image = UIImage(named: "captn.dab.png")
            hits += 10
        }
        
    
    }
    
    func swipeGestures(sender: UISwipeGestureRecognizer){
        
        if isPlaying{
            
            if sender.direction == .right{
                
                switchTimer.invalidate()
                
                if arrowDirection == "right"{
                    
                    hitCounter += 1
                    hitcounterLabel.text = String("\(hitCounter)")
                    reactionImage.image = UIImage(named: "rightstep.png")
                    
                    self.Combo()
                    
                }else{
                    lifesCounter -= 1
                    hits = 10
                    hitCounter = 0
                    hitcounterLabel.text = String("\(hitCounter)")
                    self.Combo()
                }
                
            }
            
            if sender.direction == .left{
                
                switchTimer.invalidate()
                
                if arrowDirection == "left"{
                    
                    hitCounter += 1
                    hitcounterLabel.text = String("\(hitCounter)")
                    reactionImage.image = UIImage(named: "leftstep.png")
                    
                    self.Combo()
                    
                }else{
                    
                    lifesCounter -= 1
                    hits = 10
                    hitCounter = 0
                    hitcounterLabel.text = String("\(hitCounter)")
                    self.Combo()
                }
                
            }

            if sender.direction == .up{
                
                switchTimer.invalidate()
                
                if arrowDirection == "up"{
                    
                    hitCounter += 1
                    hitcounterLabel.text = String("\(hitCounter)")
                    reactionImage.image = UIImage(named: "upstep.png")
                    
                    self.Combo()
                    
                }else{
                    
                    lifesCounter -= 1
                    hits = 10
                    hitCounter = 0
                    hitcounterLabel.text = String("\(hitCounter)")
                    self.Combo()
                }
                
            }

            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

