//
//  ViewController.swift
//  MCalculator
//
//  Created by Maahi on 26/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit
import Speech

//https://github.com/jen2/Speech-Recognition-Demo

class ViewController: UIViewController ,UITextFieldDelegate,SFSpeechRecognizerDelegate{

    
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var isRecording = false
    
    
    @IBOutlet weak var startButton: UIButton!
    
    
    
    @IBOutlet weak var txtField: UITextField!
    
    var lastValue = 0.0
    var secondval = 0.0
    var clickbuttonTag = 0
    var operationSts = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.requestSpeechAuthorization()
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
    
    

    
    
    
    
//    @IBAction func speek(_ sender: AnyObject) {
//        
//        
//        let recognizer = SFSpeechRecognizer()
//        let request = SFSpeechURLRecognitionRequest(url: audioFileURL)
//        recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
//            print (result?.bestTranscription.formattedString)
//        })
//        
//        
//    }
    
    
    
    
    
    //MARK: IBActions and Cancel
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isRecording == true {
            audioEngine.stop()
            recognitionTask?.cancel()
            isRecording = false
            startButton.backgroundColor = UIColor.gray
        } else {
            self.recordAndRecognizeSpeech()
            isRecording = true
            startButton.backgroundColor = UIColor.red
        }
    }
    
    func cancelRecording() {
        audioEngine.stop()
        if let node = audioEngine.inputNode {
            node.removeTap(onBus: 0)
        }
        recognitionTask?.cancel()
    }
    
    //MARK: - Recognize Speech
    
    
    
    func recordAndRecognizeSpeech() {
        guard let node = audioEngine.inputNode else { return }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            self.sendAlert(message: "There has been an audio engine error.")
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            self.sendAlert(message: "Speech recognition is not supported for your current locale.")
            return
        }
        if !myRecognizer.isAvailable {
            self.sendAlert(message: "Speech recognition is not currently available. Check back at a later time.")
            // Recognizer is not available right now
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                
                let bestString = result.bestTranscription.formattedString
                self.txtField.text = bestString
                
                var lastString: String = ""
                for segment in result.bestTranscription.segments {
                    let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
                    lastString = bestString.substring(from: indexTo)
                }
               // self.checkForColorsSaid(resultString: lastString)
            } else if let error = error {
                self.sendAlert(message: "There has been a speech recognition error.")
                print(error)
            }
        })
    }
    
    //MARK: - Check Authorization Status
    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.startButton.isEnabled = true
                case .denied:
                    self.startButton.isEnabled = false
                    self.txtField.text = "User denied access to speech recognition"
                case .restricted:
                    self.startButton.isEnabled = false
                    self.txtField.text = "Speech recognition restricted on this device"
                case .notDetermined:
                    self.startButton.isEnabled = false
                    self.txtField.text = "Speech recognition not yet authorized"
                }
            }
        }
    }
    
    //MARK: - UI / Set view color.
    
    /*func checkForColorsSaid(resultString: String) {
        switch resultString {
        case "red":
            colorView.backgroundColor = UIColor.red
        case "orange":
            colorView.backgroundColor = UIColor.orange
        case "yellow":
            colorView.backgroundColor = UIColor.yellow
        case "green":
            colorView.backgroundColor = UIColor.green
        case "blue":
            colorView.backgroundColor = UIColor.blue
        case "purple":
            colorView.backgroundColor = UIColor.purple
        case "black":
            colorView.backgroundColor = UIColor.black
        case "white":
            colorView.backgroundColor = UIColor.white
        case "gray":
            colorView.backgroundColor = UIColor.gray
        default: break
        }
    }*/
    
    //MARK: - Alert
    
    func sendAlert(message: String) {
        let alert = UIAlertController(title: "Speech Recognizer Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

