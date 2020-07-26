

import UIKit

class LineCapacityChangeViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var officialLineWidth: UITextField!
    @IBOutlet weak var officialLineLong: UITextField!
    @IBOutlet weak var newLineWidth: UITextField!
    @IBOutlet weak var newLineLong: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //設定各textField的delegate為自己
        self.officialLineLong.delegate = self
        self.officialLineLong.keyboardType = .decimalPad
        self.officialLineWidth.delegate = self
        self.officialLineWidth.keyboardType = .decimalPad
        self.newLineWidth.delegate = self
        self.newLineWidth.keyboardType = .decimalPad
    }
    
    //MARK:- 開始運算
    @IBAction func change() {
        //檢查官方最大線徑是否有值
        guard let officialLineLong = Double(self.officialLineLong.text!) else {
            return
        }
        //檢查官方建議線長是否有值
        guard let officialLineWidth = Double(self.officialLineWidth.text!) else {
            return
        }
        //檢查新線徑是否有值
        guard let newLineWidth = Double(self.newLineWidth.text!) else {
            return
        }
        //公式 : 官方線面積*官方線長/新線面積
        let newLineLong = (pow(officialLineWidth/2,2) * Double.pi * officialLineLong) / ((pow(newLineWidth/2, 2)) * Double.pi)
        self.newLineLong.text = "\(round(newLineLong/10)*10)m"
        self.view.endEditing(true)
        //        print(round(newLineLong/10)*10)
    }
    //MARK:- 點點textfield以外的地方關閉鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK:-控制textField的內容
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let Digits = 4 //整數的位數
        if textField.text?.contains(".") == false,
            string != "",
            string != "."{
            if (textField.text?.count)! >= Digits{
                return false
            }
        }
        let scanner = Scanner(string: string)
        let numbers = NSCharacterSet(charactersIn: "0123456789.")
        let pointRange = (textField.text! as NSString).range(of: ".")
        if textField.text == "",
            string == "."{
            return false
        }
        let remain = 3  // 小數點後的位數
        let tempStr = textField.text!.appending(string)
        let strlen = tempStr.count
        //判斷textField是否有"."
        if pointRange.length > 0,
            pointRange.location > 0{
                if string == "." {
                    return false
                }
                //如果輸入框中“.”，當字串長度淺去小數點前面的字串長度大於設定的小數點位數，輸入無效
                if strlen > 0,
                    (strlen - pointRange.location) > remain + 1 {
                    return false
                }
        }
        let zeroRange = (textField.text! as NSString).range(of: "0")
        if zeroRange.length == 1,
            //判斷輸入第一個字是否為"0"
            zeroRange.location == 0{
            //當TextField只有一個字，且為0，再輸入的字不是0或小數點時，取代那個字
            if !(string == "0"),
                !(string == "."),
                textField.text?.count == 1 {
                textField.text = string
                return false
            }else {
                if pointRange.length == 0,
                    pointRange.location > 0{//當TextField只有一個字，且為0，不能再次輸入"0"
                    if string == "0"{
                        return false
                    }
                }
            }
        }
        if !scanner.scanCharacters(from: numbers as CharacterSet, into: nil),
            string.count != 0 {
            return false
        }
        return true
    }
}



