//
//  Team.swift
//  Scouter
//
//  Created by James Timberlake on 3/5/18.
//  Copyright © 2018 James Timberlake. All rights reserved.
//

import SwiftyJSON

public class Team {
    
    var TeamID = 0
    var City = ""
    var Name = ""
    var Abbr = ""
    var LeagueID = 0
    var FullName = ""
    
    init(teamId:Int, city:String, name:String, abbr:String, leagueId:Int, fullName:String) {
        TeamID = teamId
        City = city
        Name = name
        Abbr = abbr
        LeagueID = leagueId
        FullName = fullName
    }
    

    class func build(json:JSON) -> Team {
        return Team(teamId:json["TeamID"].intValue,
                      city:json["City"].stringValue,
                      name:json["Name"].stringValue,
                      abbr:json["Abbr"].stringValue,
                      leagueId:json["LeagueID"].intValue,
                      fullName:json["FullName"].stringValue)
    }
}
