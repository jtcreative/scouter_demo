//
//  ScoutService.swift
//  Scouter
//
//  Created by James Timberlake on 3/5/18.
//  Copyright © 2018 James Timberlake. All rights reserved.
//

import Alamofire
import SwiftyJSON

public protocol ScoutServiceListener {
    func scoutListenerOnAllPlayersReceived(players: [Player?])
    func scoutListenerOnPlayersSearchReceived(players: [Player?])
    func scoutListenerOnPlayerReceived(player: Player?)
    func scoutListenerOnTeamsReceived(teams: [Team?])
    func scoutListenerOnPlayerStatsReceived(playerStats: PlayerStat)
    func scoutListenerOnTeamRosterReceived(players: [Player?])
}

public class ScoutService {
    
    let baseUrl: String
    var delegate: ScoutServiceListener?
    
    init(scoutDelegate:ScoutServiceListener?) {
        baseUrl = "https://jobposting28.azurewebsites.net/api"
        delegate = scoutDelegate
    }
    
}

//player apis
extension ScoutService {
    
    public func getAllPlayers() {
        let url = baseUrl + "/player"
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let players = self.createPlayerList(json: json) {
                    self.delegate?.scoutListenerOnAllPlayersReceived(players: players)
                }
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func searchForPlayers(query: String) {
        let url = baseUrl + "/player?criteria=\(query)"
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let players = self.createPlayerList(json: json) {
                    self.delegate?.scoutListenerOnPlayersSearchReceived(players: players)
                }
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getPlayer(playerId : Int) {
        let url = baseUrl + "/player/\(playerId)"
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let player = Player.build(json: json)
                self.delegate?.scoutListenerOnPlayerReceived(player: player)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getPlayerStats(playerId: Int) {
        let url = baseUrl + "/player/\(playerId)/stats"
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let playerStats = PlayerStat.build(json: json)
                self.delegate?.scoutListenerOnPlayerStatsReceived(playerStats: playerStats)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func createPlayerList(json: JSON) -> [Player?]? {
        if let array = (json.array?.map {  return Player.build(json: $0) }) {
            return array
        }
        return nil
    }
    
}

extension ScoutService {
    
    public func getTeams() {
        let url = baseUrl + "/team"
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let teams = (json.array?.map {  return Team.build(json: $0) }) {
                    self.delegate?.scoutListenerOnTeamsReceived(teams: teams)
                }
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getTeamRoster(teamId: Int) {
        let url = baseUrl + "/team/\(teamId)/roster"
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let players = self.createPlayerList(json: json) {
                    self.delegate?.scoutListenerOnTeamRosterReceived(players: players)
                }
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
}
