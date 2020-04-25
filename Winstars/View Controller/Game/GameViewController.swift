//
//  GameViewController.swift
//  Winstars
//
//  Created by CHAN CHI YU on 20/4/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var redLightView: UIView!
    @IBOutlet weak var redLightLabel: UILabel!
    @IBOutlet weak var greenLightLabel: UILabel!
    @IBOutlet weak var greenLightView: UIView!
    @IBOutlet weak var runButton: UIButton!
    
    @IBOutlet weak var redPauseLabel: UILabel!
    @IBOutlet weak var greenPauseLabel: UILabel!
    @IBOutlet weak var redLightStepper: UIStepper!
    @IBOutlet weak var greenLightStepper: UIStepper!
    
    var timer = Timer.init()
    
    var redLightCount = 5 {
        didSet {
            if redLightCount == 0 && greenLightCount > 0{
                self.redLightView.backgroundColor = .systemGray
                self.greenLightView.backgroundColor = .systemGreen
            }
        }
    }
    
    var greenLightCount = 5 {
        didSet {
            if redLightCount == 0 && greenLightCount == 0 {
                self.redLightView.backgroundColor = .systemRed
                self.greenLightView.backgroundColor = .systemGray
                self.reset()
            }
        }
    }
    
    var totalCount: Int{
        get {
            return redLightCount + greenLightCount
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateInfo()
        self.redLightStepper.value = 5000.0
        self.greenLightStepper.value = 5000.0
        self.redPauseLabel.text = String(self.redLightStepper.maximumValue)
        self.greenPauseLabel.text = String(self.greenLightStepper.maximumValue)
        
    }
    
    
    @objc func onStepperChange(){
        print("test")
    }
    @IBAction func runPressed(_ sender: Any) {
        
        self.redLightStepper.isHidden = true
        self.greenLightStepper.isHidden =  true
        
        switch self.runButton.currentTitle! {
        case "Run":
            self.runButton.setTitle("Reset", for: .normal)
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                print("Timer fired!")
                print([self.redLightCount,self.greenLightCount])
                
                if (self.redLightCount > 0) {self.redLightCount -= 1}
                else if (self.greenLightCount > 0) {self.greenLightCount -= 1}
                self.updateInfo()
            }
        case "Reset":
            print("Reset")
            self.redLightStepper.isHidden = false
            self.greenLightStepper.isHidden =  false
            
            reset()
            self.timer.invalidate()
            self.runButton.setTitle("Run", for: .normal)
            self.updateInfo()
            
        default:
            print("default")
            self.updateInfo()
        }
    }
    
    func updateInfo(){
        self.redLightLabel.text = String(self.redLightCount)
        self.greenLightLabel.text = String(self.greenLightCount)
    }
    func reset(){
        self.redLightCount = Int(self.redLightStepper.value / 1000)
        self.greenLightCount = Int(self.greenLightStepper.value / 1000)
        self.updateInfo()
    }
    @IBAction func onChangeRedLightValue(_ sender: UIStepper) {
        self.redPauseLabel.text = String((sender as UIStepper).value)
        self.redLightCount = Int ( (sender as UIStepper).value / 1000)
        self.redLightLabel.text = String(self.redLightCount)
        
    }
    @IBAction func onChangeGreenLightValue(_ sender: UIStepper) {
        self.greenPauseLabel.text = String((sender as UIStepper).value)
        self.greenLightCount = Int ( (sender as UIStepper).value / 1000)
        self.greenLightLabel.text = String(self.greenLightCount)
    }
}
