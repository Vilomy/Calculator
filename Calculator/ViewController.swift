//
//  ViewController.swift
//  Calculator
//
//  Created by Gleb Zadonskiy on 04.11.2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayResultLabel: UILabel!
    @IBOutlet var buttonSetting: [UIButton]!
    
    @IBOutlet weak var viewSetting: UIView!
    var dotIsPlased = false
    var stillTyping = false
    var firstOperand = 0.0
    var secondOperand = 0.0
    var operationSing = ""
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in buttonSetting {
            button.layer.cornerRadius = 10
            
        }
        displayResultLabel.layer.cornerRadius = 10
        displayResultLabel.layer.masksToBounds = true
        viewSetting.layer.cornerRadius = 15
    }
    
    func operateWithTwoOperands(operant: (Double, Double) -> Double) {
        currentInput = operant(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func numberPerssed(_ sender: UIButton) {
        let number = sender.currentTitle!
        
        if stillTyping {
            if displayResultLabel.text!.count < 20 {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        }else {
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    @IBAction func twoOperandsSingPressed(_ sender: UIButton) {
        operationSing = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlased = false
    }
    @IBAction func equalitySingPressed(_ sender: UIButton) {
        
        guard stillTyping else { return }
        guard displayResultLabel.text != "0" else { return }
        
        secondOperand = currentInput
        dotIsPlased = false
        switch operationSing {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "÷":
            operateWithTwoOperands{$0 / $1}
        case "×":
            operateWithTwoOperands{$0 * $1}
        default:
            break
        }
    }
    @IBAction func cleareButtonPressed(_ sender: UIButton) {
        secondOperand = 0
        firstOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        dotIsPlased = false
        operationSing = ""
    }
    @IBAction func plusMinusbuttonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    @IBAction func percentageButtonPerssed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
    }
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlased {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlased = true
        } else if !stillTyping && !dotIsPlased{
            displayResultLabel.text = "0."
            dotIsPlased = true
            stillTyping = true
        }
    }
}

