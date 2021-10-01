//
//  Calculator.swift
//  Cal
//
//  Created by czy on 29/09/2021.
//  Copyright © 2021 czy. All rights reserved.
//

import UIKit

class Calculator: NSObject {
    var recordNumber:Double=0
    var tempNumber:Double=0
    var displayNumber:Double=0
    var prevOp:String=""
    var hightlightedOp=""
    var currentBuffer:Array<Any>=[]
    var writeFromStart=true
    var _2ndPressed:Bool=false
    var Rad:Bool=false
    var _error:Bool=false
    var clearAll=true
    
    var v1=[
        "(":0,
        "+":2,"-":2,
        "x":3,"÷":3,
        "logy":4,
        "y√x":5,
        "x^y":6,"y^x":6,
        "EE":7,
        ")":8
    ]
    
    var v2=[
        "(":9,
        "+":2,"-":2,
        "x":3,"÷":3,
        "logy":4,
        "y√x":5,
        "x^y":6,"y^x":6,
        "EE":7,
        ")":1
    ]
    
    
    override init() {
        srand48(Int(time(nil)))
        
    }
    
    func getDisplayNumber()->Double{
        return displayNumber
    }
    
    func changeDisplayNumber(newNumber:Double){
        displayNumber=newNumber
    }
    
    func errorFunction(){
        recordNumber=0
        tempNumber=0
        displayNumber=0
        _error=true
        prevOp=""
        hightlightedOp=""
        currentBuffer=[]
        writeFromStart=true
    }
    
    func BinaryOp(op1:Double,op2:Double,operation:String)->Double?{
        switch(operation){
        case "+":
            return op1+op2
        case "-":
            return op1-op2
        case "x":
            return op1*op2
        case "÷":
            if(op2 != 0){
                return op1/op2
            }
            else{
                return nil
            }
        case "x^y":
            if(op1==0 && op2==0){
                return nil
            }
            else{
                return pow(op1,op2)
            }
        case "y^x":
            if(op1==0 && op2==0){
                return nil
            }
            else{
                return pow(op2,op1)
            }
        case "y√x":
            if(op2==0){
                return nil
            }
            return pow(op1,1/op2)
        case "logy":
            if(op1<=0 || op2<=0){
                return nil
            }
            return log(op1)/log(op2)
        case "EE":
            return op1*pow(10,op2)
        default:
            return 0
        }
    }
    
    func UnaryOp(op:Double,operation:String) -> Double?{
        let opMul:Double = (Rad) ? 1/180*Double.pi:1
        switch(operation){
        case "%":
            return op/100
        case "+/-":
            return -op
        case "x^2":
            return pow(op,2)
        case "x^3":
            return pow(op,3)
        case "e^x":
            return pow(exp(1),op)
        case "10^x":
            return pow(10,op)
        case "2^x":
            return pow(2,op)
        case "1/x":
            if(op==0){
                return nil
            }
            return 1/op
        case "2√x":
            if(op<=0){
                return nil
            }
            return pow(op,1/2)
        case "3√x":
            return pow(op,1/3)
        case "In":
            if(op<=0){
                return nil
            }
            return log(op)
        case "log10":
            if(op<=0){
                return nil
            }
            return log10(op)
        case "log2":
            return log2(op)
        case "x!":
            if(Double(Int(op)) != op){
                return nil
            }
            var temp:Double=Double(op)
            var res:Double=temp
            if(res==0){
                res=1
            }
            while(temp>2){
                temp-=1
                res*=temp
            }
            return Double(res)
        case "sin":
            return sin(opMul*op)
        case "cos":
            return cos(opMul*op)
        case "tan":
            if(cos(op)==0){
                return nil
            }
            return tan(opMul*op)
        case "sinh":
            return sinh(op)
        case "cosh":
            return cosh(op)
        case "tanh":
            return tanh(op)
        case "sin^-1":
            if(abs(op)>1){
                return nil
            }
            return asin(op)*opMul
        case "cos^-1":
            if(abs(op)>1){
                return nil
            }
            return acos(op)*opMul
        case "tan^-1":
            return atan(op)*opMul
        case "sinh^-1":
            return asinh(op)
        case "cosh^-1":
            if(op<1){
                return nil
            }
            return acosh(op)
        case "tanh^-1":
            if(op>=1 || op<0){
                return nil
            }
            return atanh(op)
        case "π":
            return Double.pi
        case "e":
            return exp(1)
        case "Rand":
            return drand48()
        default:
            return nil
        }
    }

    
    func pushNumber(num:Double){
        currentBuffer.append(num)
    }
    
    func pushOperation(op:String){
        currentBuffer.append(op)
    }
    
    func calcCurrentBuffer()->Double{
        do{
            
        var tempBuffer:Array<Any>=[]
        var opBuffer:Array<Any>=[]
        for i in 0...currentBuffer.count-1{
            if(currentBuffer[i] is Double){
                tempBuffer.append(currentBuffer[i])
            }
            else if(currentBuffer[i] is String){
                let _op:String=currentBuffer[i] as! String
                while(true){
                    if(opBuffer.isEmpty){
                        break
                    }
                    if(v1[opBuffer.last as! String]!<v2[_op]!){
                        break
                    }
                    let tempOp:String=opBuffer.popLast() as! String
                    if(tempOp != "(" && tempOp != ")"){
                        tempBuffer.append(tempOp)
                    }
                }
                if(_op != ")"){
                    opBuffer.append(_op)
                }
                else if(!opBuffer.isEmpty){
                    if(opBuffer.last as! String! == "("){
                        opBuffer.popLast()
                    }
                }
            }
        }
        while(!opBuffer.isEmpty){
            let tempOp:String=opBuffer.popLast() as! String
            if(tempOp != "(" && tempOp != ")"){
                tempBuffer.append(tempOp)
            }
        }
        var numberBuffer:Array<Any>=[]
        for i in 0...tempBuffer.count-1{
            if(tempBuffer[i] is Double){
                numberBuffer.append(tempBuffer[i])
            }
            else if(tempBuffer[i] is String){
                if(numberBuffer.count<2){
                    print("Calculate Error!")
                    _error=true
                    return 0
                }
                let op2:Double=numberBuffer.popLast() as! Double
                let op1:Double=numberBuffer.popLast() as! Double
                let newNumber=try BinaryOp(op1: op1,op2: op2,operation: tempBuffer[i] as! String)
                if(newNumber == nil){
                    print("MATH Error!")
                    _error=true
                    return 0
                }
                numberBuffer.append(newNumber!)
            }
        }
        if(numberBuffer.isEmpty){
            return 0
        }
        return numberBuffer[0] as! Double
        }
        catch{
            _error = true
            return 0
        }
    }
    
    func unaryOpTouched(operation:String){
        if(_error){
            clearAll=true
            clear()
        }
        let res=UnaryOp(op: displayNumber, operation: operation)
        if(res==nil){
            errorFunction()
            return
        }
        tempNumber=res as! Double
        displayNumber=res as! Double
        writeFromStart=true
        clearAll=false
    }
    
    func binaryOpTouched(operation:String){
        if(_error){
            clearAll=true
            clear()
        }
        hightlightedOp=operation
        if(currentBuffer.isEmpty){
            currentBuffer.append(tempNumber)
        }
        else if(currentBuffer.last is String &&  currentBuffer.last as! String! != ")"){
            currentBuffer.append(tempNumber)
        }

        let result:Double?=calcCurrentBuffer()
        if(result == nil){
            errorFunction()
            return
        }
        tempNumber=displayNumber
        writeFromStart=true
        clearAll=false
    }
    
    func write_brakets(braket:String){
        if(braket=="("){
            if(currentBuffer.isEmpty){
                currentBuffer.append("(")
            }
            else if(currentBuffer.last is String && currentBuffer.last as! String! != ")"){
                currentBuffer.append("(")
            }
            else if(hightlightedOp != ""){
                prevOp=hightlightedOp
                hightlightedOp=""
                currentBuffer.append(prevOp)
                currentBuffer.append("(")
            }
        }
        else if(braket==")"){
            if(currentBuffer.isEmpty){
                return
            }
            else if(currentBuffer.last is Double){
                currentBuffer.append(")")
            }
            else if(currentBuffer.last as! String! == ")"){
                currentBuffer.append(")")
            }
            else if(!writeFromStart || clearAll){
                writeFromStart=true
                currentBuffer.append(displayNumber)
                tempNumber=displayNumber
                currentBuffer.append(")")
            }
        }
    }
    
    func writeNewNumber(num:Double){
        if(_error){
            clearAll=true
            clear()
        }
        if(hightlightedOp != "" && writeFromStart){
            prevOp=hightlightedOp
            hightlightedOp=""
            currentBuffer.append(prevOp)
        }
        tempNumber=num
        displayNumber=num
        writeFromStart=false
        clearAll=false
    }
    
    func clear(){
        if(clearAll){
            tempNumber=0
            displayNumber=0
            _error=false
            prevOp=""
            hightlightedOp=""
            currentBuffer=[]
            writeFromStart=true
        }
        else{
            tempNumber=0
            displayNumber=0
            _error=false
            hightlightedOp=""
            writeFromStart=true
            clearAll=true
        }
    }
    
    func recordFunction(type:String){
        switch type {
        case "clear":
            recordNumber=0
            return
        case "read":
            tempNumber=recordNumber
            displayNumber=recordNumber
            writeFromStart=true
            clearAll=false
            return
        case "add":
            if(!clearAll){
                getResult()
            }
            recordNumber+=displayNumber
            return
        case "sub":
            if(!clearAll){
                getResult()
            }
            recordNumber-=displayNumber
            return
        default:
            return
        }
    }
    
    func getResult(){
        if(_error){
            clearAll=true
            clear()
            return
        }
        if(hightlightedOp != ""){
            tempNumber=displayNumber
            prevOp=hightlightedOp
            hightlightedOp=""
            if(currentBuffer.isEmpty){
                currentBuffer.append(tempNumber)
            }
            else if(currentBuffer.last is String &&  currentBuffer.last as! String! != ")"){
                currentBuffer.append(tempNumber)
            }
            currentBuffer.append(prevOp)
        }
        else if(prevOp != "" && clearAll){
            currentBuffer.append(prevOp)
        }
        if(currentBuffer.isEmpty){
            currentBuffer.append(tempNumber)
        }
        else if(currentBuffer.last is String && currentBuffer.last as! String! != ")"){
            currentBuffer.append(tempNumber)
        }
        writeFromStart=true
        displayNumber=calcCurrentBuffer()
        clearAll=true
    }
    
}
