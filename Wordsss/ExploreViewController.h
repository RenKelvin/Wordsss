//
//  ExploreViewController.h
//  Wordsss
//
//  Created by RenKelvin on 11-10-3.
//  Copyright 2011年 Ren Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExploreVirtualActor.h"

#import "WordsssDBVirtualActor.h"

#import "Word_Association.h"
#import "Word_Rootaffix.h"
#import "Word_Sense.h"

#import "WordCellMem.h"
#import "RKTableHeader.h"

#import "WordViewController.h"

@interface ExploreViewController : UIViewController <UITabBarDelegate, UITableViewDataSource, UITextFieldDelegate, UISearchBarDelegate, UIScrollViewDelegate> {
    //
    ExploreVirtualActor* _exploreVirtualActor;
    
    //
    UISearchBar* _searchBar;    
    UITableView* _tableView;
    
    //
    NSArray* _rowArray;
    
    //
    NSString* _searchText;
}

@property (nonatomic, retain) IBOutlet UISearchBar* searchBar;
@property (nonatomic, retain) IBOutlet UITableView* tableView;

@property (nonatomic, retain) IBOutlet UIButton* coverButton;

- (IBAction)coverButtonClicked:(id)sender;

@end
