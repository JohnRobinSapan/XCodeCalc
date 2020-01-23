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
        lbText.adjustsFontSizeToFitWidth = true;
        lbAnswer.adjustsFontSizeToFitWidth = true;
    }
    
    @IBOutlet var lbText : UILabel!
    @IBOutlet var lbAnswer : UILabel!
    
    var operand = 0
    var PLUS = 0
    var MINUS = 1
    var MULTIPLY = 2
    var DIVIDE = 3

    var answer : Double? = 0
    var postfix : [String] = []
    var infix : String = "0"
    
    
    @IBAction func numPress(sender : UIButton) {
        if sender.tag >= 0 && sender.tag <= 9 {
            if infix == "0"{
                infix = String(sender.tag)
            } else {
                infix += String(sender.tag)
            }
        }
        if sender.tag == 10 {
            infix += "."
        }
        updateField()
    }
    
   
    
    func updateField() {
        postfix.removeAll()
        var stack : [String] = []
        for field in infix.split(separator: " ") {
            //print(field)
            if let _ = Double(field) {
                postfix.append(String(field))
            } else {
                if field == "+" || field == "-"{
                    while let pop = stack.popLast(){
                        postfix.append(pop)
                    }
                }
                stack.append(String(field))
            }
        }
        while let pop = stack.popLast(){
            postfix.append(pop)
        }
        print("Infix: \(infix)\nPostfix: \(postfix)")
        if postfix.count >= 3 {
            evaluatePostfix()
            var result = ""
            if let finalAnswer = answer?.clean {
                result = "\(finalAnswer)"
            } else {
                result = "Error"
            }
            lbAnswer.text = result
        }
        lbText.text = infix
    }
    
//    @IBAction func setNegative(sender : UIButton) {
//        if sender.tag =
//    }
    
    @IBAction func setOperand(sender : UIButton) {
        if  sender.tag >= PLUS && sender.tag <= DIVIDE{
            operand = sender.tag
            
            var tempField = infix.split(separator: " ");
            
            if tempField.last! == "+" || tempField.last! == "-" || tempField.last! == "*" || tempField.last! == "/" {
                tempField.removeLast()
            }
            infix = ""
            for test in tempField {
                infix += test + " "
            }
            
            if operand == PLUS {
                infix += "+ "
            } else if operand == MINUS {
                infix += "- "
            } else if operand == MULTIPLY {
                infix += "* "
            } else {
                infix += "/ "
            }
            
            updateField()
        }
    }
    
    func evaluatePostfix(){
        var stack : [Double] = []
        var operandCount = 0
        var numCount = 0
        for token in postfix {
            switch token {
            case "+","-","*","/":
                operandCount += 1
            default:
                numCount += 1
            }
        }
        if numCount > operandCount {
            for token in postfix {
//                print("Stack: \(stack)")
                switch token {
                case "+":
                    stack[1] += stack[0]
                    stack.remove(at: 0)
                case "-":
                    stack[1] -= stack[0]
                    stack.remove(at: 0)
                case "*":
                    stack[1] *= stack[0]
                    stack.remove(at: 0)
                case "/":
                    if stack[0] == 0 {
                        let alert = UIAlertController(title: "Error", message: "Cannot divide by 0", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                        present(alert, animated: true)
                        alert.addAction(cancelAction)
                        answer = nil
                        return
                    } else {
                         stack[1] /= stack[0]
                    }
                    stack.remove(at: 0)
                default:
                   stack.insert(Double(token)!, at: 0)
                }
            }
        }
        
        if stack.count == 1 {
            answer = stack[0]
        }
    }
    
    
    @IBAction func calculate(sender : UIButton) {
        infix = lbAnswer.text != "" ? lbAnswer.text! : infix
        reset()
        updateField()
    }
    
    func reset() {
        print("Cleared")
        postfix = []
        operand = 0
        answer = 0
        lbAnswer.text = ""
    }
    
    @IBAction func clear(sender : UIButton) {
        infix = "0"
        reset()
        updateField()
    }
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
