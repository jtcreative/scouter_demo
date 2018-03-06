//
//  PlayerDetailViewController.swift
//  Scouter
//
//  Created by James Timberlake on 3/5/18.
//  Copyright © 2018 James Timberlake. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

public class PlayerDetailViewController : UIViewController {
    
    @IBOutlet weak var tableView : UITableView?;
    
    @IBOutlet weak var imageView : UIImageView?;
    
    @IBOutlet weak var playerName : UILabel?;
    
    @IBOutlet weak var statSegment : UISegmentedControl?;
    
    public var player: Player?
    
    var playerStats: PlayerStat?;
    
    var currentDataSource : [StatsForYear?]?
    
    private var service : ScoutService?
    
    @IBAction public func switchTableViewSource() {
        
    }
    
    func resetPlayerStatSource() {
        switch(statSegment?.selectedSegmentIndex)
        {
        case 0?:
                currentDataSource = playerStats?.Batting
        case 1?:
                currentDataSource = playerStats?.Pitching
        default:
            currentDataSource = playerStats?.Batting
            
        }
        
        DispatchQueue.main.async{
            self.tableView?.reloadData()
            self.tableView?.setNeedsDisplay()
        }
    }
    
    public required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        service = ScoutService(scoutDelegate: self)
        if let playerID = player?.PlayerID {
            service?.getPlayerStats(playerId:playerID)
        }
        imageView?.contentMode = .scaleAspectFit
        playerName?.text = player?.FullName
        if let headShotUrl = player?.HeadShotUrl {
            if let url = URL(string:headShotUrl) {
                self.imageView?.af_setImage(withURL: url)
            }
        }
    }
    
}

extension PlayerDetailViewController : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( statSegment?.selectedSegmentIndex == 0 ) {
            return 9
        } else {
            return 8
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if( statSegment?.selectedSegmentIndex == 0 ) {
            return getBattingTableVieCell(index: indexPath.row, section: indexPath.section)
        } else {
            return getPitchingTableViewCell(index: indexPath.row, section: indexPath.section)
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if let count = currentDataSource?.count {
            return count
        }
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let stats = currentDataSource![section] {
            return "Year \(stats.YearID)"
        }
        
        return ""
    }
    
    func getBattingTableVieCell(index:Int, section:Int) -> UITableViewCell {
        let cell = UITableViewCell(style: .value2, reuseIdentifier: "PlayerStatCell")
        var leftTitle : String?
        var rightStat : String?
        
        guard let section = currentDataSource![section] else {
            return cell
        }
        
        switch(index)
        {
        case 0:
                leftTitle = "Games"
                rightStat = "\(section.getAVG())"
        case 1:
                leftTitle = "At Bats"
                rightStat = "\(section.getOBP())"
        case 2:
                leftTitle = "Hits"
                rightStat = "\(section.getHits())"
        case 3:
                leftTitle = "Strike Outs"
                rightStat = "\(section.SO)"
        case 4:
            leftTitle = "Walks"
            rightStat = "\(section.getWalks())"
        case 5:
            leftTitle = "AVG"
            rightStat = "\(section.getAVG())"
        case 6:
            leftTitle = "OBP"
            rightStat = "\(section.getOBP())"
        case 7:
            leftTitle = "SLG"
            rightStat = "\(section.getSLG())"
        case 8:
            leftTitle = "OPS"
            rightStat = "\(section.getOPS())"
        default:
            leftTitle = ""
            rightStat = ""
        }
        
        cell.textLabel?.text = leftTitle
        cell.detailTextLabel?.text = rightStat
        return cell
    }

    func getPitchingTableViewCell(index:Int, section:Int) -> UITableViewCell {
        let cell = UITableViewCell(style: .value2, reuseIdentifier: "PlayerStatCell")
        var leftTitle : String?
        var rightStat : String?
        
        guard let section = currentDataSource![section] else {
            return cell
        }
        
        switch(index)
        {
        case 0:
            leftTitle = "Games"
            rightStat = "\(section.getAVG())"
        case 1:
            leftTitle = "Games Started"
            rightStat = "\(section.GS)"
        case 2:
            leftTitle = "Wins-Losses-Saves"
            rightStat = "\(section.W)-\(section.L)-\(section.SV)"
        case 3:
            leftTitle = "Innings Pitched"
            rightStat = "\(section.getInningsPitched())"
        case 4:
            leftTitle = "Hits"
            rightStat = "\(section.getHits())"
        case 5:
            leftTitle = "Strike Outs"
            rightStat = "\(section.SO)"
        case 6:
            leftTitle = "Walks"
            rightStat = "\(section.getWalks())"
        case 7:
            leftTitle = "ERA"
            rightStat = "\(section.getERA())"
        default:
            leftTitle = ""
            rightStat = ""
        }
        
        cell.textLabel?.text = leftTitle
        cell.detailTextLabel?.text = rightStat
        return cell
        
        
    }
}

extension PlayerDetailViewController : ScoutServiceListener {
    public func scoutListenerOnAllPlayersReceived(players: [Player?]) {
        
    }
    
    public func scoutListenerOnPlayersSearchReceived(players: [Player?]) {
        
    }
    
    public func scoutListenerOnPlayerReceived(player: Player?) {
        
    }
    
    public func scoutListenerOnTeamsReceived(teams: [Team?]) {
        
    }
    
    public func scoutListenerOnPlayerStatsReceived(playerStats: PlayerStat) {
        self.playerStats = playerStats
        self.resetPlayerStatSource()
    }
    
    public func scoutListenerOnTeamRosterReceived(players: [Player?]) {
    
    }
}
