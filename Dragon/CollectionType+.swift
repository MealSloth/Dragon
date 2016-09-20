//
//  CollectionType+.swift
//  Dragon
//
//  Created by Michael Fourre on 8/2/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

extension Collection
{
    subscript (safe index: Index) -> Iterator.Element?
    {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
