//
//  CalcViewController.swift
//  Cal
//
//  Created by czy on 28/09/2021.
//  Copyright © 2021 czy. All rights reserved.
//

import UIKit



class CalcViewController: UIViewController {
    var tempNumber:Double=0
    var recordNumber:Double=0
    var chosenOperator:String=""
    var operatorHightlightened:Bool=false
    
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var RadModeLabel: UILabel!
    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var subButton: UIButton!
    @IBOutlet weak var mulButton: UIButton!
    @IBOutlet weak var divButton: UIButton!
    
    @IBOutlet weak var extensionButton_2_1: UIButton!
    @IBOutlet weak var extensionButton_2_3: UIButton!
    @IBOutlet weak var extensionButton_2_4: UIButton!
    @IBOutlet weak var extensionButton_2_5: UIButton!
    @IBOutlet weak var extensionButton_2_6: UIButton!
    @IBOutlet weak var extensionButton_3_4: UIButton!
    @IBOutlet weak var extensionButton_3_5: UIButton!
    @IBOutlet weak var extensionButton_3_6: UIButton!
    @IBOutlet weak var extensionButton_4_2: UIButton!
    @IBOutlet weak var extensionButton_4_3: UIButton!
    @IBOutlet weak var extensionButton_4_4: UIButton!
    @IBOutlet weak var extensionButton_4_6: UIButton!
    @IBOutlet weak var extensionButton_5_1: UIButton!
    @IBOutlet weak var extensionButton_5_2: UIButton!
    @IBOutlet weak var extensionButton_5_3: UIButton!
    @IBOutlet weak var extensionButton_5_4: UIButton!
   
    
    
    let calculator=Calculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func double2string(_ inNumber:Double) -> String{
        var numberString=String(format: "%.10lf" , inNumber)
        var outNumber = numberString
        var i = 1
        
        if numberString.contains("."){
            while i < numberString.characters.count{
                if outNumber.hasSuffix("0") {
                    outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
                    i = i + 1
                } else {
                    break
                }
            }
            if outNumber.hasSuffix("."){
                outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
            }
            return outNumber
        } else {
            return numberString
        }
    }
    
    @IBAction func dotPressed(_ sender: UIButton) {
        if (display.text?.contains("."))!{
            return
        }
        calculator.writeFromStart=false
        display.text = display.text! + String(".")
    }
    
    
    @IBAction func clear(_ sender: UIButton) {
        calculator.clear()
        refreshAll()
    }
    
    func refreshAll(){
        if(calculator._error){
            display.text="ERROR"
        }
        else if(display.text=="ERROR" && calculator._error==false){
            display.text="0"
        }
        
        var hightlightedButton:UIButton?=nil
        switch calculator.hightlightedOp {
        case "+":
            hightlightedButton=addButton
            break
        case "-":
            hightlightedButton=subButton
            break
        case "x":
            hightlightedButton=mulButton
            break
        case "÷":
            hightlightedButton=divButton
            break
            
        case "x^y":
            hightlightedButton=extensionButton_2_4
        case "y√x":
            hightlightedButton=extensionButton_3_4
        case "y^x":
            hightlightedButton=extensionButton_2_5
        case "logy":
            hightlightedButton=extensionButton_3_5
        case "EE":
            hightlightedButton=extensionButton_4_6
 
        default:
            break
        }
        let defaultColor1:UIColor=UIColor(colorLiteralRed: 255/255, green: 145/255, blue: 41/255, alpha: 1)
        let defaultColor2:UIColor=UIColor(colorLiteralRed: 65/255, green: 65/255, blue: 65/255, alpha: 1)
        let hightedColor=UIColor(colorLiteralRed: 251/255, green: 228/255, blue: 197/255, alpha: 1)
        addButton.backgroundColor=defaultColor1
        subButton.backgroundColor=defaultColor1
        mulButton.backgroundColor=defaultColor1
        divButton.backgroundColor=defaultColor1
        
        extensionButton_2_3.backgroundColor=defaultColor2
        extensionButton_2_4.backgroundColor=defaultColor2
        extensionButton_2_5.backgroundColor=defaultColor2
        extensionButton_2_6.backgroundColor=defaultColor2
        extensionButton_3_4.backgroundColor=defaultColor2
        extensionButton_3_5.backgroundColor=defaultColor2
        extensionButton_3_6.backgroundColor=defaultColor2
        extensionButton_4_2.backgroundColor=defaultColor2
        extensionButton_4_3.backgroundColor=defaultColor2
        extensionButton_4_4.backgroundColor=defaultColor2
        extensionButton_4_6.backgroundColor=defaultColor2
        extensionButton_5_2.backgroundColor=defaultColor2
        extensionButton_5_3.backgroundColor=defaultColor2
        extensionButton_5_4.backgroundColor=defaultColor2
 
        if(hightlightedButton != nil){
            hightlightedButton?.backgroundColor=hightedColor
        }
        
        if(calculator._2ndPressed){
            extensionButton_2_1.backgroundColor=hightedColor
            extensionButton_2_5.setTitle("y^x", for: [])
            extensionButton_2_6.setTitle("2^x", for: [])
            extensionButton_3_5.setTitle("logy", for: [])
            extensionButton_3_6.setTitle("log2", for: [])
            extensionButton_4_2.setTitle("sin^-1", for: [])
            extensionButton_4_3.setTitle("cos^-1", for: [])
            extensionButton_4_4.setTitle("tan^-1", for: [])
            extensionButton_5_2.setTitle("sinh^-1", for: [])
            extensionButton_5_3.setTitle("cosh^-1", for: [])
            extensionButton_5_4.setTitle("tanh^-1", for: [])

        }
        else{
            extensionButton_2_1.backgroundColor=defaultColor2
            extensionButton_2_5.setTitle("e^x", for: [])
            extensionButton_2_6.setTitle("10^x", for: [])
            extensionButton_3_5.setTitle("In", for: [])
            extensionButton_3_6.setTitle("log10", for: [])
            extensionButton_4_2.setTitle("sin", for: [])
            extensionButton_4_3.setTitle("cos", for: [])
            extensionButton_4_4.setTitle("tan", for: [])
            extensionButton_5_2.setTitle("sinh", for: [])
            extensionButton_5_3.setTitle("cosh", for: [])
            extensionButton_5_4.setTitle("tanh", for: [])
        }

        if(calculator.clearAll){
            clearButton.setTitle("AC", for: [])
        }
        else{
            clearButton.setTitle("C", for: [])
        }
        
        if(calculator.Rad){
            extensionButton_5_1.setTitle("Deg", for: [])
            RadModeLabel.text? = "Rad"
        }
        else{
            extensionButton_5_1.setTitle("Rad", for: [])
            RadModeLabel.text? = ""
        }
        
        if((display.text! as NSString).doubleValue != calculator.getDisplayNumber()){
            display.text=double2string(calculator.getDisplayNumber())
        }
        
        if(display.text=="inf"){
            calculator.errorFunction()
            refreshAll()
            return
        }
        
    }
    
    @IBAction func _2ndTouched(_ sender: UIButton) {
        calculator._2ndPressed = !calculator._2ndPressed
        refreshAll()
    }
    
    @IBAction func bracketTouched(_ sender: UIButton) {
        if(sender.titleLabel?.text == "("){
            calculator.write_brakets(braket: "(")
        }
        else if(sender.titleLabel?.text == ")"){
            calculator.write_brakets(braket: ")")
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if(calculator.writeFromStart){
            display.text = (sender.titleLabel?.text)!
            calculator.writeNewNumber(num: (display.text! as NSString).doubleValue)
        }
        else{
            display.text = (display.text)! + (sender.titleLabel?.text)!
            calculator.writeNewNumber(num: (display.text! as NSString).doubleValue)
        }
        refreshAll()
    }
    
    
    @IBAction func BinaryOpTouched(_ sender: UIButton) {
        if(sender.titleLabel?.text == "In" || sender.titleLabel?.text == "e^x"){
            calculator.unaryOpTouched(_operation: (sender.titleLabel?.text)!)
        }
        else{
            calculator.binaryOpTouched(operation: (sender.titleLabel?.text)!)
        }
        refreshAll()
    }
    
    @IBAction func UnaryOpTouched(_ sender: UIButton) {
        if(sender.titleLabel?.text == "y^x" || sender.titleLabel?.text == "logy"){
            calculator.binaryOpTouched(operation: (sender.titleLabel?.text)!)
        }
        else{
            calculator.unaryOpTouched(_operation: (sender.titleLabel?.text)!)
        }
        refreshAll()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if(fromInterfaceOrientation.isPortrait){
            
        }
    }
    
    @IBAction func changeRadOrDeg(_ sender: UIButton) {
        calculator.Rad = !calculator.Rad
        refreshAll()
    }
    
    @IBAction func memoryButtonTouched(_ sender: UIButton) {
        switch sender.titleLabel?.text! as! String{
        case "mc":
            calculator.recordFunction(type: "clear")
            break
        case "m+":
            calculator.recordFunction(type: "add")
            break
        case "m-":
            calculator.recordFunction(type: "sub")
            break
        case "mr":
            calculator.recordFunction(type: "read")
            break
        default:
            return
        }
        refreshAll()
    }
    
    
    @IBAction func getResult(_ sender: UIButton) {
        calculator.getResult()
        refreshAll()
    }
}
