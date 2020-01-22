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
    }
    
    @IBOutlet var lbText : UILabel!
    @IBOutlet var lbAnswer : UILabel!
    
    var operand = 0
    var PLUS = 0
    var MINUS = 1
    var MULTIPLY = 2
    var DIVIDE = 3
    var answer : Double = 0
    var operandSet = false
    
    var operations : [String] = []
    var nums : [Double] = []
    var numField : String = "0"
    
    
    @IBAction func numPress(sender : UIButton) {
        if sender.tag >= 0 && sender.tag <= 9 {
            if numField == "0"{
                numField = String(sender.tag)
            } else {
                numField += String(sender.tag)
            }
            updateField()
        }
    }
    
    func updateField() {
        nums.removeAll()
        operations.removeAll()
        for field in numField.split(separator: " ") {
            //print(field)
            if let num = Double(field) {
                nums.append(num)
            } else {
                operations.append(String(field))
            }
        }
        lbText.text = numField
        var result = nums[0];
        print(nums)
        print(operations)
        lbAnswer.text = "\(getAnswer(&result, i: 0).clean)"
    }
    
    @IBAction func setOperand(sender : UIButton) {
        if  sender.tag >= PLUS && sender.tag <= DIVIDE{
            operand = sender.tag
            
     
            
            
            var tempField = numField.split(separator: " ");
            
            if tempField.last! == "+" || tempField.last! == "-" || tempField.last! == "*" || tempField.last! == "/" {
                tempField.removeLast()
            }
            
            //print(tempField)
            numField = ""
            for test in tempField {
                numField += test + " "
            }
            
            if operand == PLUS {
                numField += " + "
            } else if operand == MINUS {
                numField += " - "
            } else if operand == MULTIPLY {
                numField += " * "
            } else {
                numField += " / "
            }
            
           
            
            updateField()
            
            
        }
    }
    
    func getAnswer(_ result : inout Double, i : Int) -> Double {
        //        if let num12 = Double(theNumber.components(separatedBy: " ").last!) {
        //            print(num2)
        //            if operand == PLUS {
        //                answer = Double(num1 + num12)
        //            } else if operand == MINUS {
        //                answer = Double(num1 - num12)
        //            } else if operand == MULTIPLY {
        //                answer = Double(num1 * num12)
        //            } else {
        //                if num12 == 0 {
        //                    let alert = UIAlertController(title: "Error", message: "Cannot divide by 0", preferredStyle: .alert)
        //                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //                    present(alert, animated: true)
        //                } else {
        //                    answer = Double(num1) / Double(num12)
        //                }
        //            }
        //
        //
        //
        //        }
        //print("\(result)  \(i)  \(operations.count)")
        if i == operations.count || (operations.count >= nums.count){
            return result;
        }
        switch operations[i] {
        case "+":
            result += nums[i + 1]
            print("\(i) \(result) \(nums[i]) \(nums[i+1])")
        case "-":
            result -= nums[i + 1]
        case "*":
            result *= nums[i + 1]
        case "/":
            result /= nums[i + 1]
        default:
            result = 0.0
        }
        return getAnswer(&result, i: i + 1)
    }

    
    //Test
    @IBAction func calculate(sender : UIButton) {
        //        let aa = theNumber.components(separatedBy: " ").last!
        //        num2 = Double(aa)!
        //
        //        if operand == PLUS {
        //            answer = Double(num1 + num2)
        //        } else if operand == MINUS {
        //            answer = Double(num1 - num2)
        //        } else if operand == MULTIPLY {
        //            answer = Double(num1 * num2)
        //        } else {
        //            if num2 == 0 {
        //                let alert = UIAlertController(title: "Error", message: "Cannot divide by 0", preferredStyle: .alert)
        //                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //                present(alert, animated: true)
        //            } else {
        //                answer = Double(num1) / Double(num2)
        //            }
        //        }
        //        theNumber = String(answer)
       
        updateField()
        //reset()
    }
    
    func reset() {
        print("Cleared")
        operations = []
        numField = "0"
        nums = []
        operand = 0
        lbAnswer.text = ""
    }
    
    @IBAction func clear(sender : UIButton) {
        reset()
        updateField()
    }
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
