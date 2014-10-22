//
//  ViewController.swift
//  99RedBalloons
//
//  Created by Doug Gosciak on 2014/10/21.
//  Copyright (c) 2014 Doug Gosciak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var balloonLabelText: UILabel!

    var myBaloons:[Balloon] = []
    
    var currentBalloonIndex = 0
    var currentAnimationIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let balloonImageNames = ["RedBalloon1.jpg", "RedBalloon2.jpg", "RedBalloon3.jpg", "RedBalloon4.jpg"]
        var randomIndex:Int

        for var ballonIndex = 1; ballonIndex <= 99; ballonIndex++ {
            
            do {
                randomIndex = Int(arc4random_uniform(UInt32(balloonImageNames.count)))
            } while self.currentBalloonIndex == randomIndex
            self.currentBalloonIndex = randomIndex
            
            var myBalloon = Balloon()
            myBalloon.balloonCount = ballonIndex
            myBalloon.balloonImage = balloonImageNames[randomIndex]
            self.myBaloons.append(myBalloon)
        }
        
        self.currentBalloonIndex = 0
        self.myImageView.image = UIImage(named: self.myBaloons[self.currentBalloonIndex].balloonImage)
        self.balloonLabelText.text = "\(self.myBaloons[self.currentBalloonIndex].balloonCount) Ballon(s)"

        println("Allocated \(myBaloons.count) balloons")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func balloonNextButtonPressed(sender: UIBarButtonItem) {

        // add animations to the pot
        var animationsList:[UIViewAnimationOptions] = []
        animationsList.append(UIViewAnimationOptions.TransitionCrossDissolve)
        animationsList.append(UIViewAnimationOptions.TransitionCurlDown)
        animationsList.append(UIViewAnimationOptions.TransitionFlipFromLeft)
        animationsList.append(UIViewAnimationOptions.TransitionFlipFromTop)
        
        // get a unique random index into the animations list
        var randomAnimationIndex:Int
        do {
            randomAnimationIndex = Int(arc4random_uniform(UInt32(3)))
        } while self.currentAnimationIndex == randomAnimationIndex
        self.currentAnimationIndex = randomAnimationIndex
        
        currentBalloonIndex++ // Increment to the next ballon array element
        if currentBalloonIndex > myBaloons.count - 1 {
            currentBalloonIndex = 0
        }
        
        let myBalloon = self.myBaloons[currentBalloonIndex]

        UIView.transitionWithView(self.view, duration: 2, options: animationsList[currentAnimationIndex], animations: {
            
            self.myImageView.image = UIImage(named: myBalloon.balloonImage)
            self.balloonLabelText.text = "\(myBalloon.balloonCount) Ballon(s)"
            
            }, completion: {
                (finished: Bool) -> () in
        })
    }
}

