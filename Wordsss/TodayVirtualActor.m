//
//  TodayVirtualActor.m
//  Wordsss
//
//  Created by Kelvin Ren on 12/12/11.
//  Copyright (c) 2011 Ren Inc. All rights reserved.
//

#import "TodayVirtualActor.h"

#import "UserDataManager.h"
#import "WordsssDBDataManager.h"

static TodayVirtualActor* sharedTodayVirtualActor = nil;

@implementation TodayVirtualActor

@synthesize user = _user;

@synthesize wordPre = _wordPre;
@synthesize wordCur = _wordCur;
@synthesize wordPos = _wordPos;

@synthesize wordRecordPre = _wordRecordPre;
@synthesize wordRecordCur = _wordRecordCur;
@synthesize wordRecordPos = _wordRecordPos;

@synthesize todayWordSum;

@synthesize wordRecordSet = _wordRecordSet;

@synthesize screenTitle, screenInfo;

#pragma mark -

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

#pragma mark -

+ (TodayVirtualActor*)todayVirtualActor
{
    if (!sharedTodayVirtualActor) {
        sharedTodayVirtualActor = [[TodayVirtualActor alloc] init];
        [sharedTodayVirtualActor prepare];
    }
    
    if ([sharedTodayVirtualActor checkNextDayByTime]) {
        [sharedTodayVirtualActor nextDay];
    }
    
    return sharedTodayVirtualActor;
}

#pragma mark -

- (void)updateWord
{
    // Move
    _wordPos = _wordCur;
    _wordCur = _wordPre;
    
    WordsssDBDataManager* wdm = [WordsssDBDataManager wordsssDBDataManager];
    
    //
    if (_wordRecordPre) {
        NSNumber* word_id = _wordRecordPre.word_id;
        _wordPre = [wdm getWordWithId:word_id];
    }
}

- (void)updateWordRecord
{
    // Move
    _wordRecordPos = _wordRecordCur;
    _wordRecordCur = _wordRecordPre;
    
    //
    _wordRecordPre = nil;
    while ([_wordRecordSet count]) {
        int index = rand() % [_wordRecordSet count];
        _wordRecordPre = (WordRecord*)[[_wordRecordSet allObjects] objectAtIndex:index];
        
        if ([_wordRecordPre.word_id intValue] != [_wordRecordCur.word_id intValue]) {
            break;
        }
    }
}

#pragma mark -

- (void)updateUser
{
    // Get UserDataManager
    UserDataManager* udm = [UserDataManager userdataManager];
    
    // Get user
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    _user = [[udm.managedObjectContext executeFetchRequest:request error:nil] lastObject];
    
    if (!_user) {
        _user = [udm createUser];
    }
}

- (void)updateWordRecordSet
{
    // Get UserDataManager
    UserDataManager* udm = [UserDataManager userdataManager];
    
    // Get wordRecordSet
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"WordRecord"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"day == %d", [_user.status.day intValue]]];
    _wordRecordSet = [NSMutableSet setWithArray:[udm.managedObjectContext executeFetchRequest:request error:nil]];
    _newWordCount = 0;
    
    //
    NSSet* tempSet = nil;
    [request setPredicate:[NSPredicate predicateWithFormat:@"day == %d+0", [_user.status.day intValue]]];
    tempSet = [NSMutableSet setWithArray:[udm.managedObjectContext executeFetchRequest:request error:nil]];
    NSLog(@"Word record in day %d+0: %lu", [_user.status.day intValue], (unsigned long)[tempSet count]);
    [request setPredicate:[NSPredicate predicateWithFormat:@"day == %d+1", [_user.status.day intValue]]];
    tempSet = [NSMutableSet setWithArray:[udm.managedObjectContext executeFetchRequest:request error:nil]];
    NSLog(@"Word record in day %d+1: %lu", [_user.status.day intValue], (unsigned long)[tempSet count]);
    [request setPredicate:[NSPredicate predicateWithFormat:@"day == %d+2", [_user.status.day intValue]]];
    tempSet = [NSMutableSet setWithArray:[udm.managedObjectContext executeFetchRequest:request error:nil]];
    NSLog(@"Word record in day %d+2: %lu", [_user.status.day intValue], (unsigned long)[tempSet count]);
    [request setPredicate:[NSPredicate predicateWithFormat:@"day == %d+3", [_user.status.day intValue]]];
    tempSet = [NSMutableSet setWithArray:[udm.managedObjectContext executeFetchRequest:request error:nil]];
    NSLog(@"Word record in day %d+3: %lu", [_user.status.day intValue], (unsigned long)[tempSet count]);
    [request setPredicate:[NSPredicate predicateWithFormat:@"day == %d+4", [_user.status.day intValue]]];
    tempSet = [NSMutableSet setWithArray:[udm.managedObjectContext executeFetchRequest:request error:nil]];
    NSLog(@"Word record in day %d+4: %lu", [_user.status.day intValue], (unsigned long)[tempSet count]);
    [request setPredicate:[NSPredicate predicateWithFormat:@"day == %d+5", [_user.status.day intValue]]];
    tempSet = [NSMutableSet setWithArray:[udm.managedObjectContext executeFetchRequest:request error:nil]];
    NSLog(@"Word record in day %d+5: %lu", [_user.status.day intValue], (unsigned long)[tempSet count]);
    
    NSLog(@"updataWordRecordSet: %lu", (unsigned long)[_wordRecordSet count]);
}

- (void)fillWordRecordSetFromWordRecord
{
    // Enough
    if ([_wordRecordSet count] >= kTodayWordLimit)
    {
        return;
    }
    
    // Get UserDataManager
    UserDataManager* udm = [UserDataManager userdataManager];
    
    // NOT Enough
    // Get new wordRecord
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"WordRecord"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"day == 0"]];
    NSArray* new_wordRecord_array = [udm.managedObjectContext executeFetchRequest:request error:nil];
    
    int a = (int)[_wordRecordSet count];
    // Set new wordRecord
    for (WordRecord* wr in new_wordRecord_array) {
        // Set
        [wr prepare:_user];
        
        // Add
        [_wordRecordSet addObject:wr];
        
        if ([_wordRecordSet count] >= kTodayWordLimit)
        {
            int b = (int)[_wordRecordSet count];
            _newWordCount += (b - a);
            NSLog(@"fillWordRecordSetFromWordRecord!");
            return;
        }
    }
    
    int c = (int)[_wordRecordSet count];
    _newWordCount += (c - a);
    NSLog(@"fillWordRecordSetFromWordRecord: %lu", (unsigned long)[_wordRecordSet count]);
}

- (void)fillWordRecordSetFromWordByFrequency
{
    // Enough
    if ([_wordRecordSet count] >= kTodayWordLimit)
        return;
    
    // NOT Enough
    // Get existing wordRecord
    NSMutableSet* word_id_set = [[NSMutableSet alloc] init];
    for (WordRecord* wr in _wordRecordSet) {
        [word_id_set addObject:wr.word_id];
    }
    // Get frequency range
    int freqCur = [_user.defult freqCurrent];
    int freqTar = [_user.defult freqTarget];
    
    WordsssDBDataManager* wdm = [WordsssDBDataManager wordsssDBDataManager];
    
    // Get new word
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Word"];
    // NSString* pred_1 = [NSString stringWithFormat:@"(NOT (word_dict == nil))"];                // 有意思
    // NSString* pred_2 = [NSString stringWithFormat:@"(NOT (id in %@))", word_id_set];            // 非已有
    // NSString* pred_3 = [NSString stringWithFormat:@"(%d >= frequency.frequency AND frequency.frequency >= %d)", max, min];      // 够难度
    [request setPredicate:[NSPredicate predicateWithFormat:@"(NOT (word_dict == nil)) AND (NOT (id in %@)) AND (%d > frequency.freq AND frequency.freq >= %d)", word_id_set, freqCur, freqTar]];
    NSSet* new_word_set = [NSMutableSet setWithArray:[wdm.managedObjectContext executeFetchRequest:request error:nil]];
    
    int a = (int)[_wordRecordSet count];
    UserVirtualActor* uva = [UserVirtualActor userVirtualActor];
    // Set new wordRecord
    for (Word* w in new_word_set) {
        // Get
        WordRecord* wr = [uva createWordRecord:w];
        
        // Set
        [wr prepare:_user];
        
        // Add
        [_wordRecordSet addObject:wr];
        
        if ([_wordRecordSet count] >= kTodayWordLimit)
        {
            int b = (int)[_wordRecordSet count];
            _newWordCount += (b - a);
            NSLog(@"fillWordRecordSetFromWordByFrequency!");
            return;
        }
    }
    
    int c = (int)[_wordRecordSet count];
    _newWordCount += (c - a);
    NSLog(@"fillWordRecordSetFromWordByFrequency: %lu", (unsigned long)[_wordRecordSet count]);
}

- (void)fillWordRecordSetFromWordByField
{
    // Enough
    if ([_wordRecordSet count] >= kTodayWordLimit)
        return;
    
    // NOT Enough
    // Get existing wordRecord
    NSMutableSet* word_id_set = [[NSMutableSet alloc] init];
    for (WordRecord* wr in _wordRecordSet) {
        [word_id_set addObject:wr.word_id];
    }
    // Get frequency range
    NSString* fieldTarget = [_user.defult fieldTarget];
    
    WordsssDBDataManager* wdm = [WordsssDBDataManager wordsssDBDataManager];
    
    // Get new word
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Word"];
    // NSString* pred_1 = [NSString stringWithFormat:@"(NOT (word_dict == nil))"];                // 有意思
    // NSString* pred_2 = [NSString stringWithFormat:@"(NOT (id in %@))", word_id_set];            // 非已有
    // NSString* pred_3 = [NSString stringWithFormat:@"(%d >= frequency.frequency AND frequency.frequency >= %d)", max, min];      // 够难度
    [request setPredicate:[NSPredicate predicateWithFormat:@"(NOT (word_dict == nil)) AND (NOT (id in %@)) AND (field.%K == %@)", word_id_set, fieldTarget, [NSNumber numberWithBool:YES]]];
    NSSet* new_word_set = [NSMutableSet setWithArray:[wdm.managedObjectContext executeFetchRequest:request error:nil]];
    
    int a = (int)[_wordRecordSet count];
    UserVirtualActor* uva = [UserVirtualActor userVirtualActor];
    // Set new wordRecord
    for (Word* w in new_word_set) {
        // Get
        WordRecord* wr = [uva createWordRecord:w];
        
        // Set
        [wr prepare:_user];
        
        // Add
        [_wordRecordSet addObject:wr];
        
        if ([_wordRecordSet count] >= kTodayWordLimit)
        {
            int b = (int)[_wordRecordSet count];
            _newWordCount += (b - a);
            NSLog(@"fillWordRecordSetFromWordByField!");
            return;
        }
    }
    
    int c = (int)[_wordRecordSet count];
    _newWordCount += (c - a);
    NSLog(@"fillWordRecordSetFromWordByField: %lu", (unsigned long)[_wordRecordSet count]);
}

- (void)updateTestWordRecord
{
    // Get new word
    WordsssDBDataManager* wdm = [WordsssDBDataManager wordsssDBDataManager];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Word"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == \"pregnant\""]];
    
    NSSet* new_word_set = [NSMutableSet setWithArray:[wdm.managedObjectContext executeFetchRequest:request error:nil]];
    
    _wordRecordSet = [NSMutableSet set];
    
    UserVirtualActor* uva = [UserVirtualActor userVirtualActor];
    // Set new wordRecord
    for (Word* w in new_word_set) {
        // Get
        WordRecord* wr = [uva createWordRecord:w];
        
        // Set
        [wr prepare:_user];
        
        // Add
        [_wordRecordSet addObject:wr];
    }
}

- (BOOL)isNeedUpdateScreen
{
    return _isNeedUpdateScreen;
}

- (void)setNeedUpdateScreen:(BOOL)need
{
    _isNeedUpdateScreen = need;
}

- (void)updateScreenTitle:(NSString*)title info:(NSString*)info
{
    //
    self.screenTitle = title;
    self.screenInfo = info;
    
    //
    _isNeedUpdateScreen = YES;
}

- (void)prepare
{
    // Init
    _wordPre = _wordCur = _wordPos = nil;
    _wordRecordPre = _wordRecordCur = _wordRecordPos = nil;
    
    // Get user
    [self updateUser];
    
    // Get wordRecordArray
    [self updateWordRecordSet];
    
    // First time launch
    if ([_wordRecordSet count] == 0) {
        // More wordRecordArray
        [self fillWordRecordSetFromWordRecord];
        [self fillWordRecordSetFromWordByField];
        [self fillWordRecordSetFromWordByFrequency];
    }
    
    // Get WordRecord Word
    [self updateWordRecord];
    [self updateWord];
    [self updateWordRecord];
    [self updateWord];
    [self updateWordRecord];
    [self updateWord];
    
    //
    self.todayWordSum = [NSNumber numberWithInt:(int)[_wordRecordSet count]];
    
    //
    [self updateScreenTitle:@"计划已更新" info:[NSString stringWithFormat:@"新增单词 %d 个", _newWordCount]];
}

//
- (BOOL)checkNextDayByTime
{
    if (!_user.status.date) {
        return NO;
    }
    
    float deltaTime = [[NSDate date] timeIntervalSinceDate:_user.status.date];
    
    if ([_wordRecordSet count] >= 80) {
        return NO;
    }
    
    if (deltaTime > 3 * 60 * 60) {
        return YES;
    }
    
    return NO;
}

//
- (BOOL)checkNextDayByCount
{
    // float memDegree = [_user.defult.memDegree floatValue];
    
    //
    // int wordRemainLimit = kTodayWordLimit * ((1-memDegree)*kWordRemainFactorMin + memDegree*kWordRemainFactorMax);
    int wordRemainLimit = 20;
    if ([_wordRecordSet count] <= wordRemainLimit) {
        NSLog(@"wordRemain: %lu", (unsigned long)[_wordRecordSet count]);
        return YES;
    }
    
    //
    // int totalViewLimit = kTodayWordLimit * ((1-memDegree)*kTotalViewFactorMin + memDegree*kTotalViewFactorMax);
    int totalViewLimit = 300;
    if ([_user.status.dlc intValue] >= totalViewLimit) {
        NSLog(@"viewCount: %d", [_user.status.dlc intValue]);
        return YES;
    }
    
    return NO;
}

- (void)nextDay
{
    UserDataManager* udm = [UserDataManager userdataManager];
    
    // WordRecord++ & store HisRecord
    for (WordRecord* wr in _wordRecordSet) {
        //
        [wr levelUpdate];
        //
        [udm createHisRecord:wr forUser:_user];
        //
        [wr nextDay];
        [wr cleardl];
    }
    
    // Day++
    [udm createStaRecord:_user];
    
    [_user nextDay];
    [_user cleardl];
    
    // Get user
    [self updateUser];
    
    // Get wordRecordArray
    [self updateWordRecordSet];
    
    // More wordRecordArray
    [self fillWordRecordSetFromWordRecord];
    // Even more wordRecordArray
    [self fillWordRecordSetFromWordByField];
    [self fillWordRecordSetFromWordByFrequency];
    
    //
    self.todayWordSum = [NSNumber numberWithInt:(int)[_wordRecordSet count]];
    
    //
    [self updateScreenTitle:@"计划已更新" info:[NSString stringWithFormat:@"新增单词 %d 个", _newWordCount]];
}

- (BOOL)checkWordRecord:(WordRecord*)wordRecord
{
    if ([wordRecord.dls intValue] >= 0) {
        return YES;
    }
    if ([wordRecord.dlc intValue] >= 5) {
        return YES;
    }
    
    return NO;
}

- (void)dropWordRecord:(WordRecord*)wordRecord
{
    UserDataManager* udm = [UserDataManager userdataManager];
    
    //
    [udm createHisRecord:wordRecord forUser:_user];
    
    //
    [wordRecord nextDay];
    [wordRecord cleardl];
    
    //
    if (wordRecord) {
        [_wordRecordSet removeObject:wordRecord];
    }
}

- (void)setWordRecordCurLevelInc
{
    [_user dlInc];
    [_wordRecordCur dlInc];
    
    //
    [_wordRecordCur levelUpdate];
    
    //
    if ([self checkWordRecord:_wordRecordCur]) {
        [self dropWordRecord:_wordRecordCur];
    }
    
    //
    if ([self checkNextDayByCount]) {
        [self nextDay];
    }
}

- (void)setWordRecordCurLevelDec
{
    [_user dlInc];
    [_wordRecordCur dlDec];
    
    //
    if ([self checkWordRecord:_wordRecordCur]) {
        //
        [_wordRecordCur levelUpdate];
        
        //
        [self dropWordRecord:_wordRecordCur];
    }
    
    //
    if ([self checkNextDayByCount]) {
        [self nextDay];
    }
}

- (void)setWordRecordPosLevelDec
{
    [_user dlInc];
    [_wordRecordPos dlDec];
    
    //
    [_wordRecordPos levelUpdate];
    
    // Add Back
    [_wordRecordSet addObject:_wordRecordPos];
    
    //
    if ([self checkWordRecord:_wordRecordPos]) {
        [self dropWordRecord:_wordRecordPos];
    }
    
    //
    if ([self checkNextDayByCount]) {
        [self nextDay];
    }
}

- (void)setWordRecordCurLevelIncTop
{
    [_user dlInc];
    [_wordRecordCur setLevel:[NSNumber numberWithInt:-1]];
    [_wordRecordCur dlInc];
    
    //
    if ([self checkWordRecord:_wordRecordCur]) {
        [self dropWordRecord:_wordRecordCur];
    }
    
    //
    if ([self checkNextDayByCount]) {
        [self nextDay];
    }
}

@end
