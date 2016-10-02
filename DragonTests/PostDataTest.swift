//
//  PostDataTest.swift
//  Dragon
//
//  Created by Michael Fourre on 10/1/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import Foundation

class PostDataTest
{
    func testPostStore()
    {
        PostPageRequest().request(
            onCompletion: { (result: PostPageResult) -> Void in
                
            },
            onError: { (error) -> Void in
                
            }
        )
    }
    
    func testPostFetch()
    {
        
    }
}
