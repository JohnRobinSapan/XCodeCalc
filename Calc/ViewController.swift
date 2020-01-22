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
        if nums.count >= 2{
            var result = nums[0]
            lbAnswer.text = "\(getAnswer(&result, i: 0).clean)"
        }
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
        if i == operations.count || nums.count - 1 == i{
            return result;
        }
        //print("\(i) \(nums) \(nums.count)")
        switch operations[i] {
        case "+":
            result += nums[i + 1]
           // print("\(i) \(result) \(nums[i+1])")
        case "-":
            result -= nums[i + 1]
        case "*":
            result *= nums[i + 1]
        case "/":
            if nums[i + 1] == 0 {
                let alert = UIAlertController(title: "Error", message: "Cannot divide by 0", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                present(alert, animated: true)
                alert.addAction(cancelAction)
            } else {
                result /= nums[i + 1]
            }
        default:
            result = 0.0
        }
        return getAnswer(&result, i: i + 1)
    }
    
    @IBAction func calculate(sender : UIButton) {
        numField = lbAnswer.text != "" ? lbAnswer.text! : numField
        print(nums)
        print(operations)
        reset()
        updateField()
    }
    
    func reset() {
        print("Cleared")
        operations = []
        nums = []
        operand = 0
        lbAnswer.text = ""
    }
    
    @IBAction func clear(sender : UIButton) {
        numField = "0"
        reset()
        updateField()
    }
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
