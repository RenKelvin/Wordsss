//
//  TBBTListELViewController.h
//  Wordsss
//
//  Created by Ren Chuan on 7/12/12.
//  Copyright (c) 2012 Ren Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "List.h"

#import "TBBTListTLViewController.h"

#import "WordsssDBDataManager.h"

@interface TBBTListELViewController : UIViewController <UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSNumber* _seasonNum;
}

@property (nonatomic, retain) IBOutlet UILabel* titleLabel;

#pragma mark - Instance method

- (TBBTListELViewController*)initWithSeasonNum:(NSNumber*)seasonNum;

@end
