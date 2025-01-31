//
//  Word_Sense.h
//  Wordsss
//
//  Created by Kelvin Ren on 12/21/11.
//  Copyright (c) 2011 Ren Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Sense, Word;

@interface Word_Sense : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * meaning_cn;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) Word *word;
@property (nonatomic, retain) Sense *sense;

+ (Word_Sense *)entityWithId:(NSNumber *)entityId inManagedObjectContext:(NSManagedObjectContext *)context;

@end
