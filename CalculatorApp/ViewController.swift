//
//  ViewController.swift
//  CalculatorApp
//
//  Created by RyomaShindo on 2018/07/16.
//  Copyright © 2018年 RyomaShindo. All rights reserved.
//

import UIKit
import Expression
import Repro
import Repro.RPREventProperties
import SafariServices

class ViewController: UIViewController {
    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBAction func goBack(_ segue:UIStoryboardSegue) {}
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func goNext(_ sender:UIButton) {
        let next = storyboard!.instantiateViewController(withIdentifier: "next2ViewController")
        self.present(next,animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        formulaLabel.text = ""
        answerLabel.text = ""
        Repro.setIntUserProfile(25, forKey:"Age")
        setupTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("start viewWillApper")
        
//        Repro.resumeRecording()
    }
    
    func setupTextView() {
        
        let text = "詳細はこちらをご覧ください"
        
        textView.isSelectable = true
        textView.isEditable = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.isScrollEnabled = false // これが必要な理由は後述
        
        let attributedString = NSMutableAttributedString(string: text)
        let range = NSString(string: text).range(of: "こちら")
        
        attributedString.addAttribute(
            NSAttributedStringKey.link,
            value: "app-settings:GENERAL",
            range: range)
        
        textView.attributedText = attributedString
//        textView.linkTextAttributes = [NSForegroundColorAttributeName: UIColor.red]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func goNextSegue(_ sender: UIButton) {
//        performSegue(withIdentifier: "nextSegue", sender: nil)
//    }

    @IBAction func inputFormula(_ sender: UIButton) {
        guard let formulaText = formulaLabel.text else {
            return
        }
        guard let senderedText = sender.titleLabel?.text else {
            return
        }
        formulaLabel.text = formulaText + senderedText
    }
    
    @IBAction func clearCalculation(_ sender: UIButton) {
        formulaLabel.text = ""
        answerLabel.text = ""
    }
    
    @IBAction func calculateAnswer(_ sender: UIButton) {
        Repro.track("PushAnswer", properties: nil)
        // =ボタンが押されたら答えを計算して表示する
        guard let formulaText = formulaLabel.text else {
            return
        }
        let formula: String = formatFormula(formulaText)
        answerLabel.text = evalFormula(formula)
        
        let properties = RPRViewContentProperties()
        
        properties.value = 5000.0
        properties.currency = "JPY"
        properties.contentName = "Slim Jeans"
        properties.contentCategory = "Clothing & Shoes > Mens > Clothing"

        Repro.trackViewContent("1234", properties: properties)
    }
    
    private func formatFormula(_ formula: String) -> String {
        // 入力された整数には`.0`を追加して小数として評価する
        // また`÷`を`/`に、`×`を`*`に置換する
        let formattedFormula: String = formula.replacingOccurrences(
            of: "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
            with: "$1.0",
            options: NSString.CompareOptions.regularExpression,
            range: nil
            ).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
        return formattedFormula
    }
    
    private func evalFormula(_ formula: String) -> String {
        do {
            // Expressionで文字列の計算式を評価して答えを求める
            let expression = Expression(formula)
            let answer = try expression.evaluate()
            return formatAnswer(String(answer))
        } catch {
            // 計算式が不当だった場合
            return "式を正しく入力してください"
        }
    }
    
    private func formatAnswer(_ answer: String) -> String {
        // 答えの小数点以下が`.0`だった場合は、`.0`を削除して答えを整数で表示する
        let formattedAnswer: String = answer.replacingOccurrences(
            of: "\\.0$",
            with: "",
            options: NSString.CompareOptions.regularExpression,
            range: nil)
        return formattedAnswer
    }
}

