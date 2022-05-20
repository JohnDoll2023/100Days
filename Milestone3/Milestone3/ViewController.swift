//
//  ViewController.swift
//  Milestone3
//
//  Created by John Doll on 5/19/22.
//

import UIKit

class ViewController: UIViewController {
    var wordList = [String]()
    var guessedLetters = [String]()
    var livesLeftLabel: UILabel!
    var letterButtons = [UIButton]()
    var chosenWord: String!
    var mysteryWord = "?" {
        didSet {
            chosenWordLabel.text = mysteryWord
        }
    }
    var chosenWordLabel: UILabel!
    
    var livesLeft = 7 {
        didSet {
            livesLeftLabel.text = "Lives left: \(livesLeft)"
        }
    }
    
    func startGame(action: UIAlertAction! = nil) {
        chosenWord = wordList.randomElement()
        mysteryWord = String(repeating: "?", count: chosenWord.count)
        for letter in letterButtons {
            letter.isHidden = false
        }
        mysteryWord = "????????"
        guessedLetters.removeAll()
        livesLeft = 7
        
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        livesLeftLabel = UILabel()
        livesLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        livesLeftLabel.textAlignment = .right
        livesLeftLabel.text = "Lives left: 7"
        view.addSubview(livesLeftLabel)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(buttonsView)
        
        chosenWordLabel = UILabel()
        chosenWordLabel.translatesAutoresizingMaskIntoConstraints = false
        chosenWordLabel.textAlignment = .center
        chosenWordLabel.text = "????????"
        chosenWordLabel.numberOfLines = 0
        chosenWordLabel.font = UIFont.systemFont(ofSize: 40)
        view.addSubview(chosenWordLabel)
        
        
        NSLayoutConstraint.activate([
            livesLeftLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            livesLeftLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            buttonsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            buttonsView.heightAnchor.constraint(equalToConstant: 200),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            
            chosenWordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            chosenWordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chosenWordLabel.heightAnchor.constraint(equalToConstant: 200),
            chosenWordLabel.bottomAnchor.constraint(equalTo: buttonsView.topAnchor)
        ])
        
        let width = UIScreen.main.bounds.width/5
        let height = 40
        let letters = "abcdefghijklmnopqrstuvwxyz"
        
        for row in 0..<4 {
            for col in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                letterButton.setTitle(String(letters[letters.index(letters.startIndex, offsetBy: row*5 + col)]), for: .normal)
                
                let frame = CGRect(x: col * Int(width), y: row * height, width: Int(width), height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            }
        }
        for i in 0..<6 {
            let letterButton = UIButton(type: .system)
            letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            letterButton.setTitle(String(letters[letters.index(letters.startIndex, offsetBy: 20 + i)]), for: .normal)
            
            let frame = CGRect(x: i * Int(width * (5/6)), y: 4 * height, width: Int(width * (5/6)), height: height)
            letterButton.frame = frame
            
            buttonsView.addSubview(letterButton)
            letterButtons.append(letterButton)
            letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }
        // add z
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                wordList = startWords.components(separatedBy: "\n")
            }
        }
        
        startGame()
    }
    
    @objc func letterTapped(_ sender : UIButton) {
        guard let answerLetter = sender.titleLabel?.text else { return }
        sender.isHidden = true
        if chosenWord.firstIndex(of: Character(answerLetter)) != nil {
            var chars = Array(mysteryWord)
            let chosen = Array(chosenWord)
            for i in 0..<chosenWord.count {
                if (chosen[i] == Character(answerLetter)) {
                    chars[i] = chosen[i]
                }
            }
            mysteryWord = String(chars)
            
            if (mysteryWord.elementsEqual(chosenWord)) {
                let ac = UIAlertController(title: "Congrats!", message: "You correctly guessed that the word was \(chosenWord!)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Play again", style: .default, handler: startGame))
                present(ac, animated: true)
            }
        } else {
            livesLeft -= 1
            if (livesLeft == 0) {
                let ac = UIAlertController(title: "Game over!", message: "Sorry, you ran out of lives. The word was \(chosenWord!)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Play again", style: .default, handler: startGame))
                present(ac, animated: true)
            }
        }
    }


}

