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
    
    let MAX_BALLOONS = 99
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.createBalloonArray()
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
        currentAnimationIndex = self.getRandomAnimationIndex()
        
        // display next element in the myBalloons array
        self.incrCurrentBalloonIndex()
        
        let myBalloon = self.myBaloons[currentBalloonIndex]

        UIView.transitionWithView(self.view, duration: 2, options: animationsList[currentAnimationIndex], animations: {
            
            self.myImageView.image = UIImage(named: myBalloon.balloonImage)
            self.balloonLabelText.text = "\(myBalloon.balloonCount) Ballon(s)"
            
            }, completion: {
                (finished: Bool) -> () in
        })
    }
    
    private func createBalloonArray() {
        let balloonImageNames = ["RedBalloon1.jpg", "RedBalloon2.jpg", "RedBalloon3.jpg", "RedBalloon4.jpg"]
        var randomIndex:Int

        for var balloonIndex = 1; balloonIndex <= MAX_BALLOONS; balloonIndex++ {
            
            // generate index to create random non-sequential image attachment to Balloon struct element
            do {
                randomIndex = Int(arc4random_uniform(UInt32(balloonImageNames.count)))
            } while self.currentBalloonIndex == randomIndex
            self.currentBalloonIndex = randomIndex
            
            // create Balloon instance and add it to myBaloons array
            let myBalloon = Balloon(balloonCount: balloonIndex, balloonImage: balloonImageNames[randomIndex])
            self.myBaloons.append(myBalloon)
        }
        
        // prep for display of first image
        self.currentBalloonIndex = 0
        self.myImageView.image = UIImage(named: self.myBaloons[self.currentBalloonIndex].balloonImage)
        self.balloonLabelText.text = "\(self.myBaloons[self.currentBalloonIndex].balloonCount) Ballon(s)"

        println("Allocated \(myBaloons.count) balloons")
    }
    
    private func incrCurrentBalloonIndex() {
        currentBalloonIndex++ // Increment to the next ballon array element
        if currentBalloonIndex == self.myBaloons.count {
            currentBalloonIndex = 0
        }
    }
    
    private func getRandomAnimationIndex() ->Int {
        var randomAnimationIndex:Int
        do {
            randomAnimationIndex = Int(arc4random_uniform(UInt32(3)))
        } while self.currentAnimationIndex == randomAnimationIndex
        self.currentAnimationIndex = randomAnimationIndex
        return randomAnimationIndex
    }
}

