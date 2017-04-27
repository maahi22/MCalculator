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
    
    var lastValue = 0
    var secondval = 0
    var clickbuttonTag = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickButton(_ sender: AnyObject) {
       
        secondval = secondval + sender.tag
        
        txtField.text = String(secondval)
        
        
    }
    
    
    
    @IBAction func calculatePercentage(_ sender: AnyObject) {
        
        lastValue =   secondval
        secondval = 0
        txtField.text = String(secondval)
    }
    
    
    @IBAction func clickCancel(_ sender: AnyObject) {
        
        
        lastValue = 0
        secondval = 0
        txtField.text = String(secondval)
    }
    
    
    @IBAction func clickEqual(_ sender: AnyObject) {
    
    
        
        
    }
    
    
    
    @IBAction func clickPluse(_ sender: AnyObject) {
        lastValue =   secondval
        secondval = 0
        txtField.text = String(secondval)
    clickbuttonTag = 1
    }
    
    
    
    @IBAction func clickminuse(_ sender: AnyObject) {
        lastValue =   secondval
        secondval = 0
        txtField.text = String(secondval)
    clickbuttonTag = 2
    }
    
    
    
    
    @IBAction func clickMultiply(_ sender: AnyObject) {
        lastValue =   secondval
        secondval = 0
        txtField.text = String(secondval)
        clickbuttonTag = 3
        
        
    }
    
    @IBAction func clickDivide(_ sender: AnyObject) {
        
        lastValue =   secondval
        secondval = 0
        txtField.text = String(secondval)
        clickbuttonTag = 4
        
    }
    
    

}

