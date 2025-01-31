//
//  WordViewController.h
//  Wordsss
//
//  Created by RenKelvin on 11-10-4.
//  Copyright 2011年 Ren Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WordBooksViewController.h"
#import "WordRelationsViewController.h"
#import "WordMemsViewController.h"
#import "WordStatisticsViewController.h"

//#import "RKNavigationControllerDelegate.h"

#import "Word.h"

#import "WordVirtualActor.h"

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kWordViewSectionFrame CGRectMake(0, 47, 320, (kScreenHeight - 160))
#define kWordViewSectionFrameShort CGRectMake(0, 47 + 31 + 10, 320, (kScreenHeight - 160) - 31 - 10)

@interface WordViewController : UIViewController <UINavigationControllerDelegate, UIActionSheetDelegate>
{
    //
    Word* _word;
    WordVirtualActor* _wordVirtualActor;
}

@property (nonatomic, retain) Word* word;

@property (nonatomic, retain) IBOutlet UILabel* wordTitleLabel;

@property (nonatomic, retain) IBOutlet UIButton* transToListButton;

@property (nonatomic, retain) IBOutlet UIButton* navigationLeftButton;

@property (nonatomic, retain) IBOutlet UIButton* wordBooksSectionButton;
@property (nonatomic, retain) IBOutlet UIButton* wordRelationsSectionButton;
@property (nonatomic, retain) IBOutlet UIButton* wordMemsSectionButton;
@property (nonatomic, retain) IBOutlet UIButton* wordStatisticsSectionButton;

@property (nonatomic, retain) IBOutlet UIImageView* wordPosLevelImageView;
@property (nonatomic, retain) IBOutlet UIImageView* wordPosLevelLeftImageView;
@property (nonatomic, retain) IBOutlet UIImageView* wordPosLevelBodyImageView;
@property (nonatomic, retain) IBOutlet UIImageView* wordPosLevelRightImageView;

@property (nonatomic, retain) NSArray* sectionViewControllers;
@property (nonatomic, retain) UIView* currentSectionView;

- (WordViewController*)init:(Word*)word;

- (void)initSectionViewControllers;

- (IBAction)selectSectionButtonDown:(UIButton*)button;

- (IBAction)navigationBackButtonClicked:(id)sender;
- (IBAction)navigationBookmarksButtonClicked:(id)sender;

- (void)selectSectionWithIndex:(NSInteger)index;

@end
