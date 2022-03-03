//
//  ViewController.swift
//  #13Replace_Anastasia
//
//  Created by Anastasia Bilous on 2022-02-16.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var findField: UITextField!
    @IBOutlet weak var replaceField: UITextField!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var updatedTextLabel: UILabel!
    
    var inputText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func changeLook(name: UITextField) {
            name.borderStyle = .none
            name.layer.cornerRadius = 10
            name.layer.borderWidth = 1
            name.layer.borderColor = UIColor.black.withAlphaComponent(0.75).cgColor
            name.layer.shadowOpacity = 1
            name.layer.shadowRadius = 2.0
            name.layer.shadowOffset = CGSize.init(width: 0, height: 3)
            name.layer.shadowColor = UIColor.gray.cgColor
            name.leftView = UIView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: 10,
                                                 height: name.frame.height))
            name.leftViewMode = .always
        }
        
        func changeLookView(name:UITextView) {
            name.layer.borderWidth = 1
            name.layer.borderColor = UIColor.black.cgColor
        }
        
        changeLook(name: replaceField)
        changeLook(name: findField)
        changeLookView(name: inputTextView)
    }
    
    override func viewDidLayoutSubviews() {
        updatedTextLabel.sizeToFit()
    }
    
    func warningMessage(name: String) {
        let alertVc = UIAlertController(
            title: "WARNING",
            message: name,
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default)
        alertVc.addAction(okAction)
        present(alertVc, animated: true, completion: nil)
    }
    
    func replace() {
        inputText = inputTextView.text
        let findText = findField.text ?? ""
        let replaceText = replaceField.text ?? ""
        inputText = inputText.replacingOccurrences(of: findText,
                                                   with: replaceText)
    }
    
    func cleanSpaces() {
        inputText = inputText.replacingOccurrences(of: ".", with: ". ")
        inputText = inputText.replacingOccurrences(
            of: "\\s*(\\p{Po}\\s?)\\s*",
            with: "$1",
            options: [.regularExpression])
        inputText = inputText.replacingOccurrences(of: ". . ", with: ". ")
        if inputText[inputText.index(before: inputText.endIndex)] == " " {
            inputText.remove(at: inputText.index(before: inputText.endIndex))
        }
    }
    
    func capitalize() {
        var arrayFromInputText = [Character]()
        var stringFromArrayInputText = ""
        
        for char in inputText {
            arrayFromInputText.append(char)
        }
        
        for (i, char) in arrayFromInputText.enumerated() {
            
            let capitalStartIndex = arrayFromInputText[arrayFromInputText.startIndex].uppercased()
            arrayFromInputText[arrayFromInputText.startIndex] = Character(capitalStartIndex)
            
            if char == "."  && i <= arrayFromInputText.count - 2 {
                let capitalLetter = (arrayFromInputText[i+2]).uppercased()
                arrayFromInputText[i+2] = Character(capitalLetter)
            }
        }
        
        for char in arrayFromInputText {
            stringFromArrayInputText += String(char)
        }
        
        updatedTextLabel.text = stringFromArrayInputText
    }
    
    @IBAction func replaceButton(_ sender: Any) {
        
        if findField.text?.isEmpty == true && inputTextView.text?.isEmpty == true {
            warningMessage(name: "Fields 'Find' and 'Input text' are empty")
        }
        else if findField.text?.isEmpty == true {
            warningMessage(name: "Field 'Find' is empty")
        }
        else if inputTextView.text?.isEmpty == true {
            warningMessage(name: "Field 'Input text' is empty")
        }
        else {
            replace()
            cleanSpaces()
            capitalize()
        }
    }
}

