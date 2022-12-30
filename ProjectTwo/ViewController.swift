//
//  ViewController.swift
//  ProjectTwo
//
//  Created by Luiz R on 29/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    @IBOutlet var scoreText: UILabel!
    
    var countries = [String]()
    var score = 0
    
    var correctAnswer = 0
    var questionsAnswered = 0
    
    let questionsAmountToFinish = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
    }
    
    func checkAnswer(title: inout String, message: inout String, _ sender: UIButton) {
        if sender.tag == correctAnswer {
            title = "Correto"
            score += 1
        } else {
            title = "Errado"
            message += "Essa bandeira era de \(countries[sender.tag].uppercased())."
            
            // Don't let the score go negative numbers
            if score != 0 {
                score -= 1
            }
        }
        
        message += "\nSua pontuação é de \(score) \(score > 1 ? "pontos" : "ponto")"
        
        questionsAnswered += 1
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String = ""
        var message: String = ""
        
        // Check if user input answer is correct or not
        // and edit the message result based on it
        
        // **Applies the use of inout knowledge to experience it**
        checkAnswer(title: &title, message: &message, sender)
        
        // End game session when questionsAmountToFinish is achieved
        if questionsAnswered == questionsAmountToFinish {
            title = "Resultado"
            message = "Sua pontuação foi de \(score)/\(questionsAmountToFinish)"
            
            questionsAnswered = 0
            score = 0
        }
        
        // Render alert to show user the result of his answer
        let alertController = UIAlertController(title: title, message: message , preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continuar", style: .default, handler: askQuestion))
        present(alertController, animated: true)
        
        // Upgrade the score in the label text
        scoreText.text = String(score)

    }
    
    
}

