//
//  MAListWordCell.m
//  Wordsss
//
//  Created by Ren Chuan on 2/29/12.
//  Copyright (c) 2012 Ren Inc. All rights reserved.
//

#import "MAListWordCell.h"

@implementation MAListWordCell

@synthesize maListWord;

@synthesize nameLabel, meaningLabel;
@synthesize addButton;
@synthesize wordPosLevelImageView, wordPosLevelLeftImageView, wordPosLevelBodyImageView, wordPosLevelRightImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configCell
{
    [self.nameLabel setText:self.maListWord.word_list.word.name];
    [self.meaningLabel setText:self.maListWord.meaning];
    
    //
    UserVirtualActor* uva = [UserVirtualActor userVirtualActor];
    Word* w = nil;    
    WordRecord* wr = nil;
    
    // Word
    w = self.maListWord.word_list.word;
    
    //
    if (w) {
        //
        wr = [uva getWordRecord:w];
        
        // WordPos Level Bar
        if (wr) {
            [self.addButton setHidden:YES];
            
            [self.wordPosLevelLeftImageView setHidden:NO];
            [self.wordPosLevelBodyImageView setHidden:NO];
            [self.wordPosLevelRightImageView setHidden:NO];
            
            int bodyWidth = 0;
            
            if ([wr.level intValue] == -1) {
                bodyWidth = 281;
            }
            else {
                bodyWidth = 281 / 11.0 * [wr.level intValue];
            }
            
            CGRect frame;
            
            frame = self.wordPosLevelBodyImageView.frame;
            frame.size.width = bodyWidth;
            self.wordPosLevelBodyImageView.frame = frame;
            
            frame = self.wordPosLevelRightImageView.frame;
            frame.origin.x = 20 + bodyWidth;
            self.wordPosLevelRightImageView.frame = frame;
        }
        else {
            [self.addButton setHidden:NO];
            
            [self.wordPosLevelLeftImageView setHidden:YES];
            [self.wordPosLevelBodyImageView setHidden:YES];
            [self.wordPosLevelRightImageView setHidden:YES];
        }
    }
}

- (IBAction)addButtonClicked:(id)sender
{
    //
    UserVirtualActor* uva = [UserVirtualActor userVirtualActor];
    Word* w = nil;    
    WordRecord* wr = nil;
    
    // Word
    w = self.maListWord.word_list.word;
    
    //
    if (w) {
        //
        [uva createWordRecord:w];

        //
        wr = [uva getWordRecord:w];
        
        // WordPos Level Bar
        if (wr) {
            [self.addButton setHidden:YES];
            
            [self.wordPosLevelLeftImageView setHidden:NO];
            [self.wordPosLevelBodyImageView setHidden:NO];
            [self.wordPosLevelRightImageView setHidden:NO];
            
            int bodyWidth = 0;
            
            if ([wr.level intValue] == -1) {
                bodyWidth = 281;
            }
            else {
                bodyWidth = 281 / 11.0 * [wr.level intValue];
            }
            
            CGRect frame;
            
            frame = self.wordPosLevelBodyImageView.frame;
            frame.size.width = bodyWidth;
            self.wordPosLevelBodyImageView.frame = frame;
            
            frame = self.wordPosLevelRightImageView.frame;
            frame.origin.x = 20 + bodyWidth;
            self.wordPosLevelRightImageView.frame = frame;
        }
        else {
            [self.addButton setHidden:NO];
            
            [self.wordPosLevelLeftImageView setHidden:YES];
            [self.wordPosLevelBodyImageView setHidden:YES];
            [self.wordPosLevelRightImageView setHidden:YES];
        }
    }
}

@end
