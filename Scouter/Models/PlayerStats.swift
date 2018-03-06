//
//  PlayerStats.swift
//  Scouter
//
//  Created by James Timberlake on 3/5/18.
//  Copyright © 2018 James Timberlake. All rights reserved.
//

import SwiftyJSON


public class PlayerStat {
    
    var Batting : [StatsForYear]?
    var Pitching : [StatsForYear]?
    
    init(batting : [StatsForYear]?, pitching : [StatsForYear]?) {
        Batting = batting
        Pitching = pitching
    }
    
    class func build(json: JSON) -> PlayerStat {
        return PlayerStat(batting: json["Batting"].array?.map({ return StatsForYear.build(json: $0)}),
                          pitching: json["Pitching"].array?.map({ return StatsForYear.build(json: $0)}))
    }
}


