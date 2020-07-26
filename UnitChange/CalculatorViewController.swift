

import UIKit

class CalculatorViewController: UIViewController {
    
    var weightUnit : String!
    //     var value : Double?
    var contorl = 0
    
    //MARK:- Label
    @IBOutlet weak var resultOne: UILabel!
    @IBOutlet weak var resultTwo: UILabel!
    @IBOutlet weak var resultThree: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    //MARK:- 數字鍵盤1~9button
    @IBAction func numbers(_ sender: UIButton) {
        if contorl == 1 {
            self.weight.text = ""
            contorl = 0
        }
        guard self.weight.text!.count < 8 else {
            return
        }
        guard self.weight.text != "0" else{
            self.weight.text = "\(sender.tag)"
            return
        }
        
        self.weight.text="\(self.weight.text!)\(sender.tag)"
    }
    
    //MARK:- 數字鍵盤0button
    @IBAction func number0(_ sender: UIButton) {
        if contorl == 1 {
            self.weight.text = ""
            contorl = 0
        }
        guard self.weight.text!.count < 8,
            !self.weight.text!.contains("/") else {
                return
        }
        guard self.weight.text != "0" else {
            self.weight.text = "\(sender.tag)"
            return
        }
        self.weight.text="\(self.weight.text!)\(sender.tag)"
    }
    
    //MARK:- 分數符號button
    @IBAction func fractions(_ sender: Any) {
        guard !self.weight.text!.contains("/") else {
            return
        }
        guard !self.weight.text!.contains(".") else {
            return
        }
        guard self.weight.text!.count < 8 else {
            return
        }
        guard self.weight.text!.count > 0 else{
            return
        }
        guard self.weight.text != "0" else{
            return
        }
        self.weight.text="\(self.weight.text!)/"
    }
    
    //MARK:- 小數點符號button
    @IBAction func decimalPoint(_ sender: Any) {
        guard !self.weight.text!.contains(".") else {
            return
        }
        guard self.weight.text!.count < 8 else {
            return
        }
        guard self.weight.text!.count > 0 else{
            return
        }
        self.weight.text="\(self.weight.text!)."
    }
    
    //MARK:- 倒退鍵button
    @IBAction func back(_ sender: UIButton) {
        if weight.text!.count > 0{
            self.weight.text?.removeLast()
        }
    }
    
    //MARK:- 清除button
    @IBAction func deleteValue(_ sender: UIButton) {
        self.weight.text?.removeAll()
        self.resultOne.text = "換算結果："
        self.resultTwo.text = ""
        self.resultThree.text = ""
        
    }
    
    //MARK:- 執行轉換button
    @IBAction func changeUnit(_ sender: Any) {
        //        if let weightTextCount = weight.text?.count{
        //            print(weightTextCount)
        //        }
        guard self.weight.text != "" else {
            return
        }
        
        let seperators = CharacterSet(charactersIn: "/")
        guard self.weight.text!.components(separatedBy: seperators).count == 1 else{
            let value = self.fractionStringtoDouble(fractionString: self.weight.text!)
            weightConvert(weightUnit: weightUnit, value: value)
            contorl = 1
            return
        }
        
        guard let value = Double(self.weight.text!) else{
            return
        }
        weightConvert(weightUnit: weightUnit, value: value)
        contorl = 1
    }
    
    //MARK:- 單位選擇segment
    
    @IBAction func weightUnitSelect(_ sender: UISegmentedControl) {
        let weightUnitSelect = sender.selectedSegmentIndex
        switch weightUnitSelect {
        case 1:
            weightUnit = "g"
        case 2:
            weightUnit = "lb"
        case 3:
            weightUnit = "kg"
        default:
            weightUnit = "oz"
        }
    }
    
    //MARK:- 單位換算
    func weightConvert(weightUnit: String, value: Double)  {
        let oz : Double
        let lb : Double
        let g : Double
        let kg : Double
        switch weightUnit {
        case "lb":
            lb = value
            oz = lb * 16
            g = lb * 453.59237
            kg = lb * 0.45359237
            self.resultOne.text = "oz = \(round(oz * 1000)/1000)"
            self.resultTwo.text = "g = \(round(g * 1000)/1000)"
            self.resultThree.text = "kg = \(round(kg * 1000)/1000)"
        case "g":
            g = value
            oz = g * 0.0352739619
            lb = g * 0.00220462262
            kg = g * 0.001
            self.resultOne.text = "oz = \(round(oz * 1000)/1000)"
            self.resultTwo.text = "lb = \(round(lb * 1000)/1000)"
            self.resultThree.text = "kg = \(round(kg * 1000)/1000)"
        case "kg":
            kg = value
            oz = kg * 35.2739619
            lb = kg * 2.20462262
            g = kg * 1000
            self.resultOne.text = "oz = \(round(oz * 1000)/1000)"
            self.resultTwo.text = "lb = \(round(lb * 1000)/1000)"
            self.resultThree.text = "g = \(round(g * 1000)/1000)"
        default:
            oz = value
            lb = oz * 0.0625
            g = oz * 28.3495231
            kg = oz * 0.0283495231
            self.resultOne.text = "lb = \(round(lb * 1000)/1000)"
            self.resultTwo.text = "g = \(round(g * 1000)/1000)"
            self.resultThree.text = "kg = \(round(kg * 1000)/1000)"
        }
    }
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weightUnit = "oz"
        self.resultOne.text = "換算結果："
    }
    
    //MARK:- 分數字串轉換成Double的方法
    func fractionStringtoDouble(fractionString:String)->Double{
        let seperators = CharacterSet(charactersIn: "/")
        let components = fractionString.components(separatedBy: seperators)
        guard let numerator = Double(components[0]) else{
            return 0
        }
        guard let denominator = Double(components[1]) else{
            return 0
        }
        let result = numerator/denominator
        return result
    }
    
}
