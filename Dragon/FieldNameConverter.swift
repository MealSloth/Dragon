//
//  FieldNameConverter.swift
//  Dragon
//
//  Created by Michael Fourre on 11/8/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

protocol FieldNameConverter {
    static func getClientName(forServerName serverName: String) -> String
    static func getServerName(forClientName clientName: String) -> String
}
