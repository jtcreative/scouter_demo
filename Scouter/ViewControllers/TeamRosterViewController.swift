//
//  TeamRosterViewController.swift
//  Scouter
//
//  Created by James Timberlake on 3/6/18.
//  Copyright © 2018 James Timberlake. All rights reserved.
//

import UIKit

class TeamRosterViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView?
    @IBOutlet weak var teamLabel : UILabel?
    
    var service : ScoutService?
    
    var team : Team?
    public var players: [Player?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamLabel?.text = team?.FullName
        // Do any additional setup after loading the view, typically from a nib.
        service = ScoutService(scoutDelegate: self)
        service?.getTeamRoster(teamId: (team?.TeamID)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension TeamRosterViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let playerDetailController = storyboard.instantiateViewController(withIdentifier: "PlayerDetailViewController") as! PlayerDetailViewController
        playerDetailController.player = players?[indexPath.row]
        
        self.navigationController?.pushViewController(playerDetailController, animated: true)
    }
}

extension TeamRosterViewController : UITableViewDataSource {
    
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

extension TeamRosterViewController : ScoutServiceListener {
    func scoutListenerOnAllPlayersReceived(players: [Player?]) {
        
    }
    
    func scoutListenerOnPlayersSearchReceived(players: [Player?]) {
        
    }
    
    func scoutListenerOnPlayerReceived(player: Player?) {
        
    }
    
    func scoutListenerOnTeamsReceived(teams: [Team?]) {
        
    }
    
    func scoutListenerOnPlayerStatsReceived(playerStats: PlayerStat) {
        
    }
    
    func scoutListenerOnTeamRosterReceived(players: [Player?]) {
        self.players = players
        tableView?.reloadData()
    }
}
