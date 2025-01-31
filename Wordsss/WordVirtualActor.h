//
//  WordVirtualActor.h
//  Wordsss
//
//  Created by Ren Chuan on 12/26/11.
//  Copyright (c) 2011 Ren Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Word.h"
#import "Word_Dict.h"
#import "Word_Relation.h"

#import "Word_Association.h"
#import "Word_Rootaffix.h"
#import "Word_Sense.h"

#import "Association.h"
#import "Rootaffix.h"
#import "Sense.h"

#import "MwcDictWord.h"

#import "UserDataManager.h"

#import "UserVirtualActor.h"

@interface WordVirtualActor : NSObject {
    //
    Word* _word;
    WordRecord* _wordRecord;
    
    //
    NSArray* _adcDictWordArray;
    NSArray* _mwcDictWordArray;
    NSArray* _sentenceArray;
    NSArray* _derivativeArray;
    NSArray* _conversionArray;
    NSArray* _synonymArray;
    NSArray* _antonymArray;
    NSArray* _wordAssociationArray;
    NSArray* _wordRootaffixArray;
    NSArray* _wordSenseArray;
    
    NSArray* _wordMemsArray;
    
    //
    NSArray* _hisRecords;
}

@property (nonatomic, retain) Word* word;
@property (nonatomic, retain) WordRecord* wordRecord;

+ (WordVirtualActor*)wordVirtualActor:(Word*)word;

- (WordVirtualActor*)init:(Word*)word;

- (void)prepare;

- (NSArray*)getAhdDictWord;
- (NSArray*)getMwcDictWord;
- (NSArray*)getSentence;
- (NSArray*)getConversion;
- (NSArray*)getDerivative;
- (NSArray*)getSynonym;
- (NSArray*)getAntonym;
- (NSArray*)getWordAssociation;
- (NSArray*)getWordRootaffix;
- (NSArray*)getWordSense;

- (NSArray*)getWordMems;

- (NSMutableArray*)getHisRecords;

- (NSString*)getMemDiffString;
- (NSString*)getFullMeaning;

@end
