//
//  DictWordCell.h
//  Wordsss
//
//  Created by Ren Chuan on 12/29/11.
//  Copyright (c) 2011 Ren Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AhdDictWord.h"
#import "MwcDictWord.h"
#import "AhdDictSentence.h"

@interface DictWordCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel* meaningBlueLabel;
@property (nonatomic, retain) IBOutlet UILabel* meaningGreyLabel;

@property (nonatomic, retain) AhdDictWord* ahdDictWord;
@property (nonatomic, retain) MwcDictWord* mwcDictWord;
@property (nonatomic, retain) AhdDictSentence* ahdDictSentence;

- (void)configCell;
- (void)clear;

- (CGFloat)getHeight;

@end
