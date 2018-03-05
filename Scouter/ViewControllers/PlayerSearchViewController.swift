//
//  FirstViewController.swift
//  Scouter
//
//  Created by James Timberlake on 3/5/18.
//  Copyright © 2018 James Timberlake. All rights reserved.
//

import UIKit

class PlayerSearchViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView?
    
    var service : ScoutService?
    var players: [Player?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        service = ScoutService(scoutDelegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension PlayerSearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count >= 4 else {
            return
        }
        
        service?.searchForPlayers(query: searchText)
    }
}

extension PlayerSearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension PlayerSearchViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let playerArray = players else {
            return 0
        }
        return playerArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = players?[indexPath.row] as Player?
        
        let bats = player?.Bats as! Int
        let throwNum = player?.Throws as! Int
        let isPitcher = player?.IsPitcher as! Bool
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "PlayerView")
        cell.textLabel?.text = player?.FullName
        cell.detailTextLabel?.text = "Bats: \(bats) Throws: \(throwNum) IsPitcher: \(isPitcher)"
        
        return cell
    }
}

extension PlayerSearchViewController : ScoutServiceListener {
    func scoutListenerOnTeamsReceived(teams: [Team?]) {
        
    }
    
    func scoutListenerOnAllPlayersReceived(players: [Player?]) {
        self.players = players
        tableView?.reloadData()
    }
    
    func scoutListenerOnPlayersSearchReceived(players: [Player?]) {
        self.players = players
        tableView?.reloadData()
    }
    
    func scoutListenerOnPlayerReceived(player: Player?) {
        
    }

}
