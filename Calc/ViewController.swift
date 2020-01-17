//
//  ViewController.swift
//  Calc
//
//  Created by Xcode User on 2020-01-16.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var lbText : UILabel!
    var theNumber : String = "0"
    var num1 = 0
    var num2 = 0
    var operand = 0
    var PLUS = 0
    var MINUS = 1
    var MULTIPLY = 2
    var DIVIDE = 3
    var answer : Double = 0
  
    
    @IBAction func pressNum(sender : UIButton) {
        if sender.tag >= 0 && sender.tag <= 9 {
            theNumber += String(sender.tag)
            printNumber()
        }
    }
    
    func printNumber() {
        lbText.text = theNumber
    }
    
    
    @IBAction func setOperand(sender : UIButton) {
        if  sender.tag >= PLUS && sender.tag <= DIVIDE {
            operand = sender.tag
            num1 = Int(theNumber)!
            theNumber = "0"
            printNumber()
        }
    }
    //Test
    @IBAction func calculate(sender : UIButton) {
        num2 = Int(theNumber)!
        
        if operand == PLUS {
            answer = Double(num1 + num2)
        } else if operand == MINUS {
            answer = Double(num1 - num2)
        } else if operand == MULTIPLY {
            answer = Double(num1 * num2)
        } else {
            if num2 == 0 {
                let alert = UIAlertController(title: "Error", message: "Cannot divide by 0", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                present(alert, animated: true)
            } else {
                answer = Double(num1) / Double(num2)
            }
        }
        theNumber = String(answer)
        printNumber()
        
        num1 = 0
        num2 = 0
        answer = 0.0
        operand = 0
    }
}

