//
//  MenuVC.swift
//  Pong
//
//  Created by Mohammed Sayerwala on 5/1/18.
//  Copyright © 2018 Mohammed Sayerwala. All rights reserved.
//

import UIKit

enum gameType {
    case easy
    case medium
    case hard
}

class MenuVC: UIViewController {

   
    @IBAction func easy(_ sender: Any) {
        moveToGame(game: .easy)
    }
    
    @IBAction func medium(_ sender: Any) {
        moveToGame(game: .medium)
    }
    
    @IBAction func hard(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game: gameType){
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        currentGameType = game
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}
