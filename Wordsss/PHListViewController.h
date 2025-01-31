//
//  PHListViewController.h
//  Wordsss
//
//  Created by Ren Chuan on 2/29/12.
//  Copyright (c) 2012 Ren Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "List.h"

#import "PHListWordCell.h"

#import "WordViewController.h"

#import "WordsssDBDataManager.h"

@interface PHListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    List* _list;
    NSArray* _listWordArray;    

}

@property (nonatomic, retain) IBOutlet UILabel* titleLabel;

- (PHListViewController*)initWithList:(List*)list;

- (IBAction)navigationBackButtonClicked:(id)sender;

@end
