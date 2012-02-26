//
//  SearchHis.h
//  Wordsss
//
//  Created by Ren Chuan on 2/25/12.
//  Copyright (c) 2012 Ren Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HisData;

@interface SearchHis : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * word_id;
@property (nonatomic, retain) HisData *hisData;

@end
