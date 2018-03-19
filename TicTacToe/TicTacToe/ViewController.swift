//
//  ViewController.swift
//  TicTacToe
//
//  Created by Alexandre Henrique Silva on 15/03/18.
//  Copyright © 2018 Alexhenri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    
   /*  I was doing this using matrix. But i try it to improve by using button tags
    
    struct Matrix {
        let rows: Int, columns: Int
        var grid: [Int]
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(repeating: 0, count: rows * columns)
        }
        func indexIsValid(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && column >= 0 && column < columns
        }
        subscript(row: Int, column: Int) -> Int {
            get {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            set {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }*/
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var resultView: UIView!
    
    let cross           = 1
    let circle          = 2
    let draw            = 3
    
    var counter         = 0
    var crossTurn       = true
    
    var gameState = [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0] // positions
    let combinationsToWin = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
   // var matrix          = Matrix(rows: 3, columns: 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.resultView.alpha = 0

        //initiatesMatrix()
        
        initiatesGame()
    }

    /*
    func initiatesMatrix(){
        for i in 0...2 {
            for j in 0...2{
                matrix[i,j] = 0
            }
        }
        for view in self.view.subviews as [UIView] {
            if let button = view as? UIButton {
                button.setImage(nil, for:[])
                button.isEnabled = true
            }
        }
    }
    
    func checkWinner() -> Bool {
        
        if((matrix[0,0] == matrix[1,1]) && (matrix[1,1] == matrix[2,2]) && (matrix [2,2] != 0)){
            return true
        }
        
        if((matrix[0,2] == matrix[1,1]) && (matrix[1,1] == matrix[2,0]) && (matrix [2,0] != 0)){
            return true
        }
        
        for i in 0...2 {
            
            if((matrix[0,i] == matrix[1,i]) && (matrix[1,i] == matrix[2,i]) && (matrix [2,i] != 0)){
                return true
            }
            
            if((matrix[i,0] == matrix[i,1]) && (matrix[i,1] == matrix[i,2]) && (matrix [i,2] != 0)){
                return true
            }
        }
        counter += 1
        return false
    }*/
        
    func initiatesGame(){
            
            gameState = [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0]
            
            for view in self.view.subviews as [UIView] {
                if let button = view as? UIButton {
                    button.setImage(nil, for:[])
                    button.isEnabled = true
                }
            }
            
    }
    
    func checkWinner() -> Bool {
        
        for combinations in combinationsToWin {
            if(gameState[combinations[0]] != 0) && gameState[combinations[0]] == gameState[combinations[1]] && gameState[combinations[1]] == gameState[combinations[2]] {
                return true
            }
        }
        
        counter += 1
        return false
    }
    
    func gameFinish(winner: Int){
        
        if winner == cross {
            resultLabel.text = "Cross player won. Congratulations!!"
        } else if winner == circle {
            resultLabel.text = "Circle player won. Congratulations!!"
        } else {
            resultLabel.text = "You two sucks."
        }
        
        for view in self.view.subviews as [UIView] {
            if let button = view as? UIButton {
                button.isEnabled = false
            }
        }
        
        UIView.animate(withDuration: 2) {
            self.resultView.alpha = 1
        }
        
    }
    
    
    @IBAction func playAgainButtonTapped(_ sender: UIButton) {
        //initiatesMatrix()
        initiatesGame()
        
        counter          = 0
        resultView.alpha = 0
        crossTurn        = true
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var playerTurn: Int
        
        if crossTurn {
            playerTurn = cross
            sender.setImage(UIImage(named: "X"), for: [])
            crossTurn = false
        } else {
            playerTurn = circle
            sender.setImage(UIImage(named: "O"), for: [])
            crossTurn = true
        }
        
        gameState[sender.tag - 1] = playerTurn
        sender.isEnabled = false
        
        if checkWinner() {
            gameFinish(winner: playerTurn)
        }  else  if counter > 8  { gameFinish(winner: draw) }
    }
        
/* I was doing with matrix.
         
        
     @IBAction func OneOneButtonTapped(_ sender: UIButton) {
        if crossTurn {
            matrix[0,0] = cross
            sender.setImage(UIImage(named: "X"), for: [])
            crossTurn = false
        } else {
            matrix[0,0] = circle
            sender.setImage(UIImage(named: "O"), for: [])
            crossTurn = true
            
        }
        sender.isEnabled = false
        if checkWinner() {
            gameFinish(winner: cross)
        }  else  if counter > 8  { gameFinish(winner: 3) }
    }

    @IBAction func OneTwoButtonTapped(_ sender: UIButton) {
        if crossTurn {
            matrix[0,1] = cross
            sender.setImage(UIImage(named: "X"), for: [])
            crossTurn = false
        } else {
            matrix[0,1] = circle
            sender.setImage(UIImage(named: "O"), for: [])
            crossTurn = true
            
        }
        sender.isEnabled = false
        if checkWinner() {
            gameFinish(winner: cross)
        }  else  if counter > 8  { gameFinish(winner: 3) }
    }
    
    @IBAction func OneThreeButtonTapped(_ sender: UIButton) {
        if crossTurn {
            matrix[0,2] = cross
            sender.setImage(UIImage(named: "X"), for: [])
            crossTurn = false
        } else {
            matrix[0,2] = circle
            sender.setImage(UIImage(named: "O"), for: [])
            crossTurn = true
            
        }
        sender.isEnabled = false
        if checkWinner() {
            gameFinish(winner: cross)
        }  else  if counter > 8  { gameFinish(winner: 3) }
    }
    
    @IBAction func TwoOneButtonTapped(_ sender: UIButton) {
        if crossTurn {
            matrix[1,0] = cross
            sender.setImage(UIImage(named: "X"), for: [])
            crossTurn = false
        } else {
            matrix[1,0] = circle
            sender.setImage(UIImage(named: "O"), for: [])
            crossTurn = true
            
        }
        sender.isEnabled = false
        if checkWinner() {
            gameFinish(winner: cross)
        }  else  if counter > 8  { gameFinish(winner: 3) }
    }
    
    @IBAction func TwoTwoButtonTapped(_ sender: UIButton) {
        if crossTurn {
            matrix[1,1] = cross
            sender.setImage(UIImage(named: "X"), for: [])
            crossTurn = false
        } else {
            matrix[1,1] = circle
            sender.setImage(UIImage(named: "O"), for: [])
            crossTurn = true
            
        }
        sender.isEnabled = false
        if checkWinner() {
            gameFinish(winner: cross)
        }  else  if counter > 8  { gameFinish(winner: 3) }
    }
    
    @IBAction func TwoThreeButtonTapped(_ sender: UIButton) {
        if crossTurn {
            matrix[1,2] = cross
            sender.setImage(UIImage(named: "X"), for: [])
            crossTurn = false
        } else {
            matrix[1,2] = circle
            sender.setImage(UIImage(named: "O"), for: [])
            crossTurn = true
            
        }
        sender.isEnabled = false
        if checkWinner() {
            gameFinish(winner: cross)
        }  else  if counter > 8  { gameFinish(winner: 3) }
    }
    
    @IBAction func ThreeOneButton(_ sender: UIButton) {
        if crossTurn {
            matrix[2,0] = cross
            sender.setImage(UIImage(named: "X"), for: [])
            crossTurn = false
        } else {
            matrix[2,0] = circle
            sender.setImage(UIImage(named: "O"), for: [])
            crossTurn = true
            
        }
        sender.isEnabled = false
        if checkWinner() {
            gameFinish(winner: cross)
        }  else  if counter > 8  { gameFinish(winner: 3) }
    }
    
    @IBAction func ThreeTwoButton(_ sender: UIButton) {
        if crossTurn {
            matrix[2,1] = cross
            sender.setImage(UIImage(named: "X"), for: [])
            crossTurn = false
        } else {
            matrix[2,1] = circle
            sender.setImage(UIImage(named: "O"), for: [])
            crossTurn = true
            
        }
        sender.isEnabled = false
        if checkWinner() {
            gameFinish(winner: cross)
        }  else  if counter > 8  { gameFinish(winner: 3) }
    }
    @IBAction func ThreeThreeButtonTapped(_ sender: UIButton) {
        if crossTurn {
            matrix[2,2] = cross
            sender.setImage(UIImage(named: "X"), for: [])
            crossTurn = false
        } else {
            matrix[2,2] = circle
            sender.setImage(UIImage(named: "O"), for: [])
            crossTurn = true
            
        }
        sender.isEnabled = false
        if checkWinner() {
            gameFinish(winner: cross)
        }  else  if counter > 8  { gameFinish(winner: 3) }
    }

    */
}

