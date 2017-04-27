//
//  MCalculatorTests.swift
//  MCalculatorTests
//
//  Created by Maahi on 26/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import XCTest


@testable import MCalculator

class MCalculatorTests: XCTestCase {
    
    
    var vc: ViewController!
    
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        //vc = storyboard.instantiateInitialViewController() as! ViewController
     // vc =  storyboard.instantiateViewController(withIdentifier :"ViewController") as UIViewController
        vc =  storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testCalculate()  {
        
        vc.lastValue = 5
        vc.secondval = 5
        var p = vc.doCalculation(value: 1)//Test ADD
        XCTAssert( p == 10 )
        
        
         p = vc.doCalculation(value: 2)//Test Sub
        XCTAssert( p == 0 )
        
        
         p = vc.doCalculation(value: 3)//Test Mult
        XCTAssert( p == 25 )
        
        
         p = vc.doCalculation(value: 4)//Test Divide
        XCTAssert( p == 1 )
        
        
        
        
       // XCTAssert(true)
    }
    
    
    func testPercent()  {
        vc.lastValue = 200
    }
    
    
    
    
    
}
