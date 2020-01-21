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
    @IBOutlet var lbAnswer : UILabel!
    var theNumber : String = "0"
    var trailingNumber : String = "0"
    var num1 : Double = 0
    var num2 : Double = 0
    var operand = 0
    var PLUS = 0
    var MINUS = 1
    var MULTIPLY = 2
    var DIVIDE = 3
    var answer : Double = 0
    var operandSet = false
  
    
    @IBAction func pressNum(sender : UIButton) {
        if sender.tag >= 0 && sender.tag <= 9 {
            if theNumber == "0" && trailingNumber == "0"{
                theNumber = String(sender.tag)
            } else {
                theNumber += String(sender.tag)
                trailingNumber = "0"
            }
            if operandSet {
                lbAnswer.text = ""
            }
            operandSet = false;
            printNumber()
        }
    }
    
    func printNumber() {
        lbText.text = trailingNumber != "0" ? theNumber + trailingNumber : theNumber
        theNumber = lbText.text!
    }
    
    func getAnswer() -> String {
        
        return ""
    }
    
    @IBAction func setOperand(sender : UIButton) {
        if  sender.tag >= PLUS && sender.tag <= DIVIDE && !operandSet{
            operand = sender.tag
           
            num1 = Double(theNumber)!
            operandSet = true
            if operand == PLUS {
                trailingNumber = " + "
            } else if operand == MINUS {
                trailingNumber = " - "
            } else if operand == MULTIPLY {
                trailingNumber = " * "
            } else {
                trailingNumber = " \\ "
            }
            printNumber()
        }
    }
    //Test
    @IBAction func calculate(sender : UIButton) {
        let aa = theNumber.components(separatedBy: " ").last!
        num2 = Double(aa)!
        
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
        reset()
    }
    
    func reset() {
        num1 = 0
        num2 = 0
        answer = 0.0
        operand = 0
    }
    
    @IBAction func clear(sender : UIButton) {
        reset()
        theNumber = "0"
        trailingNumber = "0"
        printNumber()
    }
}

