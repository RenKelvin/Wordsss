//
//  Profile.m
//  Wordsss
//
//  Created by Kelvin Ren on 12/12/11.
//  Copyright (c) 2011 Ren Inc. All rights reserved.
//

#import "Profile.h"
#import "User.h"


@implementation Profile

@dynamic nickname;
@dynamic user;

+ (Profile*)insertEntity:(NSDictionary*)dict inManagedObjectContext:(NSManagedObjectContext*)context
{
    Profile* entity = nil;
    
    entity = [NSEntityDescription insertNewObjectForEntityForName:@"Profile" inManagedObjectContext:context];
    
    return entity;
}

@end
