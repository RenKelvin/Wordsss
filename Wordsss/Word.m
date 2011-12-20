//
//  Word.m
//  Wordsss
//
//  Created by Kelvin Ren on 12/21/11.
//  Copyright (c) 2011 Ren Inc. All rights reserved.
//

#import "Word.h"
#import "Word_Association.h"
#import "Word_Dict.h"
#import "Word_List.h"
#import "Word_Rootaffix.h"
#import "Word_Sense.h"


@implementation Word

@dynamic id;
@dynamic name;
@dynamic word_association;
@dynamic word_rootaffix;
@dynamic word_sense;
@dynamic word_dict;
@dynamic word_list;

+ (Word *)wordWithID:(NSNumber *)wordId inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"Word" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"id == %@", wordId]];
    
    Word *result = [[context executeFetchRequest:request error:NULL] lastObject];
    
    // [request release];
    
    return result;
}

@end
