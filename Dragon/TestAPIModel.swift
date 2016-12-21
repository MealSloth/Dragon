//
//  TestAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 12/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class TestAPIModel: APIModel
{
    var testInt: NSNumber?
    var testString: String?
    var testIntList: [NSNumber]?
    var testStringList: [String]?
    var testPostModel: PostAPIModel?
    var testConsumerModel: ConsumerAPIModel?
    var testUserModelList: [UserAPIModel]?
    var testConsumerModelList: [ConsumerAPIModel]?
    
//    var fieldTestInt: String { return "test_int" }
//    var fieldTestString: String { return "test_string" }
//    var fieldTestIntList: String { return "test_int_list" }
//    var fieldTestStringList: String { return "test_string_list" }
//    var fieldTestPostModel: String { return "test_post_model" }
//    var fieldTestConsumerModel: String { return "test_consumer_model" }
//    var fieldTestUserModelList: String { return "test_user_model_list" }
//    var fieldTestConsumerModelList: String { return "test_consumer_model_list" }
//    
//    required init?(jsonOptional: [String:Any]?)
//    {
//        guard let json = jsonOptional else { return nil }
//        
//        super.init()
//        
//        self.testInt = json[fieldTestInt] as? NSNumber
//        self.testString = json[fieldTestString] as? String
//        
//        let intList = json[fieldTestIntList] as? [Int]
//        var list: [NSNumber] = []
//        if let realIntList = intList
//        {
//            for i in realIntList
//            {
//                list.append(i as NSNumber)
//            }
//        }
//        self.testIntList = list
//        
//        let stringList = json[fieldTestStringList] as? [String]
//        var list2: [String] = []
//        if let realStringList = stringList
//        {
//            for i2 in realStringList
//            {
//                list2.append(i2)
//            }
//        }
//        self.testStringList = list2
//        
//        if let postJson = json[fieldTestPostModel] as? [String:Any]
//        {
//            self.testPostModel = PostAPIModel(json: postJson)
//        }
//        
//        if let consumerJson = json[fieldTestConsumerModel] as? [String:Any]
//        {
//            self.testConsumerModel = ConsumerAPIModel(json: consumerJson)
//        }
//        
//        if let userList = json[fieldTestUserModelList] as? [Any]
//        {
//            var userModelList: [UserAPIModel] = []
//            for user in userList
//            {
//                if let userModel = user as? [String:Any]
//                {
//                    userModelList.append(UserAPIModel(json: userModel))
//                }
//            }
//            self.testUserModelList = userModelList
//        }
//        
//        if let consumerList = json[fieldTestConsumerModelList] as? [Any]
//        {
//            var consumerModelList: [ConsumerAPIModel] = []
//            for consumer in consumerList
//            {
//                if let consumerModel = consumer as? [String:Any]
//                {
//                    consumerModelList.append(ConsumerAPIModel(json: consumerModel))
//                }
//            }
//            self.testConsumerModelList = consumerModelList
//        }
//        
//        self.initialize(json, skip: [
//            fieldTestInt,
//            fieldTestString,
//            fieldTestIntList,
//            fieldTestStringList,
//            fieldTestPostModel,
//            fieldTestConsumerModel,
//            fieldTestUserModelList,
//            fieldTestConsumerModelList,
//        ])
//        
//    }
//    
//    required init(json: [String:Any])
//    {
//        super.init()
//        
//        self.testInt = json[fieldTestInt] as? NSNumber
//        self.testString = json[fieldTestString] as? String
//        
//        let intList = json[fieldTestIntList] as? [Int]
//        var list: [NSNumber] = []
//        if let realIntList = intList
//        {
//            for i in realIntList
//            {
//                list.append(i as NSNumber)
//            }
//        }
//        self.testIntList = list
//        
//        let stringList = json[fieldTestStringList] as? [String]
//        var list2: [String] = []
//        if let realStringList = stringList
//        {
//            for i2 in realStringList
//            {
//                list2.append(i2)
//            }
//        }
//        self.testStringList = list2
//        
//        if let postJson = json[fieldTestPostModel] as? [String:Any]
//        {
//            self.testPostModel = PostAPIModel(json: postJson)
//        }
//        
//        if let consumerJson = json[fieldTestConsumerModel] as? [String:Any]
//        {
//            self.testConsumerModel = ConsumerAPIModel(json: consumerJson)
//        }
//        
//        if let userList = json[fieldTestUserModelList] as? [Any]
//        {
//            var userModelList: [UserAPIModel] = []
//            for user in userList
//            {
//                if let userModel = user as? [String:Any]
//                {
//                    userModelList.append(UserAPIModel(json: userModel))
//                }
//            }
//            self.testUserModelList = userModelList
//        }
//        
//        if let consumerList = json[fieldTestConsumerModelList] as? [Any]
//        {
//            var consumerModelList: [ConsumerAPIModel] = []
//            for consumer in consumerList
//            {
//                if let consumerModel = consumer as? [String:Any]
//                {
//                    consumerModelList.append(ConsumerAPIModel(json: consumerModel))
//                }
//            }
//            self.testConsumerModelList = consumerModelList
//        }
//        
//        self.initialize(json, skip: [
//            fieldTestInt,
//            fieldTestString,
//            fieldTestIntList,
//            fieldTestStringList,
//            fieldTestPostModel,
//            fieldTestConsumerModel,
//            fieldTestUserModelList,
//            fieldTestConsumerModelList,
//        ])
//    }
}
