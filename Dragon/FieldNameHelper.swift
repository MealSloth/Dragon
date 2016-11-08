//
//  FieldNameHelper.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class FieldNameHelper: FieldNameConverter
{
    class func getClientName(forServerName serverName: String) -> String
    {
        var clientName: String = ""
        
        if (serverName == "id")
        {
            return serverName
        }
        else if (serverName.contains("_id"))
        {
            clientName += self.getClientName(forSubstring: serverName.substring(to: serverName.index(serverName.endIndex, offsetBy: -3)))
            clientName += "ID"
        }
        else
        {
            clientName = self.getClientName(forSubstring: serverName)
        }
        
        return clientName
    }
    
    class func getServerName(forClientName clientName: String) -> String
    {
        var serverName: String = ""
        
        if (clientName == "ID")
        {
            return "id"
        }
        else if (clientName.contains("ID"))
        {
            serverName += self.getServerName(forSubstring: clientName.substring(to: clientName.index(clientName.endIndex, offsetBy: -2)))
            serverName += "_id"
        }
        else
        {
            serverName = self.getServerName(forSubstring: clientName)
        }
        
        return serverName
    }
    
    fileprivate class func getClientName(forSubstring substring: String) -> String
    {
        var clientName: String  = ""
        var wasUnderscore: Bool = false
        
        for character in substring.characters
        {
            let cs: String = String(character)
            if (cs != "_")
            {
                if (wasUnderscore == false)
                {
                    clientName += cs
                }
                else
                {
                    wasUnderscore = false
                    clientName += cs.uppercased()
                }
            }
            else
            {
                wasUnderscore = true
            }
        }
        
        return clientName
    }
    
    fileprivate class func getServerName(forSubstring substring: String) -> String
    {
        var serverName: String = ""
        
        for character in substring.characters
        {
            let cs: String = String(character)
            if (cs.uppercased() != cs)
            {
                serverName += cs
            }
            else
            {
                serverName += "_"
                serverName += cs.lowercased()
            }
        }
        
        return serverName
    }
}
