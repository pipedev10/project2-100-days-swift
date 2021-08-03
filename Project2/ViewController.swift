//
//  ViewController.swift
//  Project2
//
//  Created by Pipe Carrasco on 30-07-21.
//

import UIKit

class ViewController: UIViewController {
    let TOTALTOANSWER = 10
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("us")
        countries.append("uk")
         better code
        */
        
        countries += ["estonia", "france", "germany", "ireland",
                      "italy", "monaco", "nigeria", "poland",
                      "russia", "spain", "us", "uk"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        //button2.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        print(countries)
        print(correctAnswer)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) - score: \(score)"
    }


    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else{
            title = "Wrong! That’s the flag of \(countries[correctAnswer].uppercased())"
            score -= 1
        }
        totalAnswer += 1
        /*
         my solution
         ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: {action in
            self.askQuestion()
        }))
         */
        
        if(totalAnswer == TOTALTOANSWER) {
            let alertGameFinished = UIAlertController(title: title, message: "Game finished your total score is \(score).", preferredStyle: .alert)
            alertGameFinished.addAction(UIAlertAction(title: "start from the beginning", style: .default, handler: { action in
                self.score = 0
                self.askQuestion()
            }))
            alertGameFinished.addAction(UIAlertAction(title: "shared result?", style: .default, handler: { action in
                self.shareResult()
            }))
            present(alertGameFinished, animated: true)
        }else{
            let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
    }
    
    func shareResult(){
        let vc = UIActivityViewController(activityItems: ["Game finished your total score is \(score)."], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        self.score = 0
        self.askQuestion()
    }
    
}

