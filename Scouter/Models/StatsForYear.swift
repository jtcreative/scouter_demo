//
//  StatsForYear.swift
//  Scouter
//
//  Created by James Timberlake on 3/5/18.
//  Copyright © 2018 James Timberlake. All rights reserved.
//

import SwiftyJSON

public class StatsForYear {
    var PlayerID = 0
    var YearID = 0
    var LevelID = 0
    var TeamID = 0
    var G = 0
    var AB = 0
    var B1 = 0
    var B2 = 0
    var B3 = 0
    var HR = 0
    var UBB = 0
    var HBP = 0
    var SO = 0
    var CI = 0
    var IBB = 0
    var SH = 0
    var SF = 0
    var SB = 0
    var CS = 0
    var PA = 0
    var R = 0
    var RBI = 0
    var OUTS = 0
    var ER = 0
    var GS = 0
    var GF = 0
    var CG = 0
    var SHO = 0
    var W = 0
    var L = 0
    var SV = 0
    var TeamAssigned: Team
    var LevelAssigned: Level
    
    init(playerID : Int,
        yearID : Int,
        levelID : Int,
        teamID : Int,
        g : Int,
        aB : Int,
        b1 : Int,
        b2 : Int,
        b3 : Int,
        hR : Int,
        uBB : Int,
        hBP : Int,
        sO : Int,
        cI : Int,
        iBB :Int,
        sH : Int,
        sF : Int,
        sB : Int,
        cS : Int,
        pA : Int,
        r : Int,
        rBI : Int,
        oUTS : Int,
        eR : Int,
        gS : Int,
        gF : Int,
        cG : Int,
        sHO : Int,
        w : Int,
        l : Int,
        sV : Int,
        team : Team,
        level: Level) {
        
        PlayerID = playerID
        YearID = yearID
        LevelID = levelID
        TeamID = teamID
        G = g
        AB = aB
        B1 = b1
        B2 = b2
        B3 = b3
        HR = hR
        UBB = uBB
        HBP = hBP
        SO = sO
        CI = cI
        IBB = iBB
        SH = sH
        SF = sF
        SB = sB
        CS = cS
        PA = pA
        R = r
        RBI = rBI
        TeamAssigned = team
        LevelAssigned = level
    }
    
    class func build(json:JSON) -> StatsForYear {
        return StatsForYear(playerID:json["PlayerID"].intValue,
                            yearID : json["YearID"].intValue,
                            levelID : json["LevelID"].intValue,
                            teamID : json["TeamID"].intValue,
                            g : json["G"].intValue,
                            aB : json["AB"].intValue,
                            b1 : json["B1"].intValue,
                            b2 : json["B2"].intValue,
                            b3 : json["B3"].intValue,
                            hR : json["HR"].intValue,
                            uBB : json["UBB"].intValue,
                            hBP : json["HBP"].intValue,
                            sO : json["SO"].intValue,
                            cI : json["CI"].intValue,
                            iBB :json["IBB"].intValue,
                            sH : json["SH"].intValue,
                            sF : json["SF"].intValue,
                            sB : json["SB"].intValue,
                            cS : json["CS"].intValue,
                            pA : json["PA"].intValue,
                            r : json["R"].intValue,
                            rBI : json["RBI"].intValue,
                            oUTS : json["OUTS"].intValue,
                            eR : json["ER"].intValue,
                            gS : json["GS"].intValue,
                            gF : json["GF"].intValue,
                            cG : json["RBI"].intValue,
                            sHO : json["SHO"].intValue,
                            w : json["W"].intValue,
                            l : json["L"].intValue,
                            sV : json["SV"].intValue,
                            team : Team.build(json: json["Team"]),
                            level: Level.build(json: json["Level"]))
    }
}

extension StatsForYear {
    public func getHits() -> Int {
        return B1 + B2 + B3 + HR
    }
    
    public func getWalks() -> Int {
        return UBB + IBB
    }
    
    public func getAVG() -> Int {
        return B1 + B2 + B3 + HR / AB
    }
    
    public func getOBP() -> Int {
        return (B1 + B2 + B3 + HR + UBB + IBB + HBP) / (AB + UBB + IBB + HBP + SF)
    }
    
    public func getSLG() -> Int {
        return (B1 + 2 * B2 + 3 + B3 + 4 * HR) / AB
    }
    
    public func getOPS() -> Int {
        return getOBP() + getSLG()
    }
    
    public func getInningsPitched() -> Int {
        return (OUTS / 3) + (OUTS % 3) / 10
    }
    
    public func getERA() -> Float {
        return Float((Float(ER) * 27.0) / Float(OUTS))
    }
}
