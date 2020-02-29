//
//  ViewController.swift
//  ApplePie
//
//  Created by Stanislav Starzhynskyi on 14/02/2020.
//  Copyright © 2020 Stanislav Starzhynskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["pasta", "pizza", "cake", "ice-creame", "candy", "lazagne"]
    let incorrectMoveAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLoses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!

    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view.
    }


    func newRound() {
        if !listOfWords.isEmpty{
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMoveAllowed, guessedLetters: [])
            enableLetterButtons(true)
        updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons {
            button.isEnabled = enable
        }
        
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLoses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
    }
    

    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLoses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
        
    }
    
    
}

