//
//  TodayVirtualActor.h
//  Wordsss
//
//  Created by Kelvin Ren on 12/12/11.
//  Copyright (c) 2011 Ren Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Word.h"
#import "User.h"
#import "Defult.h"
#import "Status.h"
#import "HisRecord.h"
#import "WordRecord.h"

#import "UserVirtualActor.h"

#import "RKTabBarController.h"

#define kTodayWordLimit       120
#define kTotalViewFactorMin   1.5
#define kTotalViewFactorMax   4.5
#define kWordRemainFactorMin  0.1
#define kWordRemainFactorMax  0.3

@class TodayViewControllerV3;

@interface TodayVirtualActor : NSObject
{
    //
    User* _user;
    
    // 
    Word* _wordPre;
    Word* _wordCur;
    Word* _wordPos;
    
    //
    
    //
    WordRecord* _wordRecordPre;
    WordRecord* _wordRecordCur;
    WordRecord* _wordRecordPos;
    
    //
    int _newWordCount;
    
    BOOL _isNeedUpdateScreen;
}

@property (nonatomic, retain) User* user;

@property (nonatomic, retain) Word* wordPre;
@property (nonatomic, retain) Word* wordCur;
@property (nonatomic, retain) Word* wordPos;

@property (nonatomic, retain) WordRecord* wordRecordPre;
@property (nonatomic, retain) WordRecord* wordRecordCur;
@property (nonatomic, retain) WordRecord* wordRecordPos;

@property (nonatomic, retain) NSNumber* todayWordSum;

@property (nonatomic, retain) NSMutableSet* wordRecordSet;

@property (nonatomic, retain) NSString* screenTitle;
@property (nonatomic, retain) NSString* screenInfo;

#pragma mark - Class method

+ (TodayVirtualActor*)todayVirtualActor;

#pragma mark - Instance method

- (void)prepare;

- (void)nextDay;

- (void)updateWord;

- (void)updateWordRecord;

- (BOOL)checkNextDayByTime;
- (BOOL)checkNextDayByCount;

- (void)setWordRecordCurLevelInc;
- (void)setWordRecordCurLevelDec;

- (void)setWordRecordPosLevelDec;
- (void)setWordRecordCurLevelIncTop;

- (BOOL)isNeedUpdateScreen;
- (void)setNeedUpdateScreen:(BOOL)need;

@end
