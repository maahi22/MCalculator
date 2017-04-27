//
//  ViewController.swift
//  MCalculator
//
//  Created by Maahi on 26/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit




class ViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var txtField: UITextField!
    
    var lastValue = 0.0
    var secondval = 0.0
    var clickbuttonTag = 0
    var operationSts = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickButton(_ sender: AnyObject) {
        if txtField.text == "0" {
          //  secondval = secondval + sender.tag
            let str = NSString(format: "%ld",sender.tag)
            txtField.text = str as String//String(secondval)
        }else{
       // secondval = secondval + sender.tag
        let str = NSString(format: "%@%ld", txtField.text!,sender.tag)
        txtField.text = str as String//String(secondval)
        }
        
        secondval = Double(txtField.text!)!
    }
    
    
    @IBAction func dotClicked(_ sender: AnyObject) {
        
        let str = NSString(format: "%@.", txtField.text!)
        txtField.text = str as String
        secondval = Double(txtField.text!)!
    }
    
    
    
    @IBAction func calculatePercentage(_ sender: AnyObject) {
        
       // lastValue =   secondval
       // secondval = 0
        txtField.text = String(secondval/100)
       // clickbuttonTag = 5
    }
    
    
    @IBAction func clickCancel(_ sender: AnyObject) {
        
        
        lastValue = 0
        secondval = 0
        txtField.text = "0"//String(int(secondval))
    }
    
    
    @IBAction func clickEqual(_ sender: AnyObject) {
    
        /*switch clickbuttonTag {
        case 1:
            txtField.text = String(lastValue + secondval)
        case 2:
            txtField.text = String(lastValue - secondval)
        case 3:
            txtField.text = String(lastValue * secondval)
        case 4:
            txtField.text = String(lastValue / secondval)
        case 5:
            txtField.text = String((lastValue / secondval)*100)
        //case 4:
        //    txtField.text = String(lastValue / secondval)
            
        default:
            txtField.text = "Muuah"
        }*/
        txtField.text = String(self.doCalculation(value: clickbuttonTag))
        
        operationSts = 0
    }
    
   
    
    func doCalculation(value:CLong) -> (Double) {
        
        var calculate = 0.0
        
        switch value {
        case 1:
            calculate = (lastValue + secondval)
        case 2:
            calculate = (lastValue - secondval)
        case 3:
            calculate = (lastValue * secondval)
        case 4:
            calculate = (lastValue / secondval)
        case 5:
            calculate = ((lastValue / secondval)*100)
        default:
            calculate = 0.0
        }

        return calculate;
    }
    
    
    
    
    
    @IBAction func clickPluse(_ sender: AnyObject) {
        lastValue =   secondval
        secondval = 0
        txtField.text = "0"
    clickbuttonTag = 1
        operationSts += 1
    }
    
    
    
    @IBAction func clickminuse(_ sender: AnyObject) {
        lastValue =   secondval
        secondval = 0
        txtField.text = "0"
    clickbuttonTag = 2
        operationSts += 1
    }
    
    
    
    
    @IBAction func clickMultiply(_ sender: AnyObject) {
        
        if operationSts != 0 {
            self.clickEqual(self);
            lastValue = Double(txtField.text!)!
        }else{
            lastValue =   secondval
        }
        secondval = 0
        txtField.text = "0"
        clickbuttonTag = 3
        operationSts += 1
        
    }
    
    @IBAction func clickDivide(_ sender: AnyObject) {
        
        lastValue =   secondval
        secondval = 0
        txtField.text = "0"
        clickbuttonTag = 4
        operationSts += 1
    }
    
    

}

