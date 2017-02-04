//
//  CollectionType+.swift
//  Dragon
//
//  Created by Michael Fourre on 8/2/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

extension Collection {
    subscript(safe index: Index) -> Iterator.Element? {
        return index >= self.startIndex && index < self.endIndex ? self[index] : nil
    }
}
