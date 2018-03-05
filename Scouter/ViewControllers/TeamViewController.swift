//
//  SecondViewController.swift
//  Scouter
//
//  Created by James Timberlake on 3/5/18.
//  Copyright © 2018 James Timberlake. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView?
    
    var service : ScoutService?
    
    var teams : [Team?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        service = ScoutService(scoutDelegate: self)
        service?.getTeams()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension TeamViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension TeamViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let teamArray = teams else {
            return 0
        }
        return teamArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let team = teams?[indexPath.row] as Team?
        
        let city = team?.City as! String
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TeamView")
        cell.textLabel?.text = team?.Name
        cell.detailTextLabel?.text = "City: \(city)"
        
        return cell
    }
}

extension TeamViewController : ScoutServiceListener {
    func scoutListenerOnTeamsReceived(teams: [Team?]) {
        self.teams = teams
        tableView?.reloadData()
    }
    
    func scoutListenerOnAllPlayersReceived(players: [Player?]) {

    }
    
    func scoutListenerOnPlayersSearchReceived(players: [Player?]) {

    }
    
    func scoutListenerOnPlayerReceived(player: Player?) {
        
    }
    
}
