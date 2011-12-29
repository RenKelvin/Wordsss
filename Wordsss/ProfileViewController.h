//
//  ProfileViewController.h
//  Wordsss
//
//  Created by Ren Kelvin on 10/1/11.
//  Copyright 2011 Ren Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RKNavigationController.h"
#import "RKNavigationControllerDelegate.h"

#import "RKChartView.h"

#import "ProfileVirtualActor.h"

@interface ProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKNavigationControllerDelegate>
{
    //
    ProfileVirtualActor* _profileVirtualActor;
    
    //
    RKChartView* _chartView;
}

@property (nonatomic, retain) IBOutlet UILabel* infoLeftLabel;
@property (nonatomic, retain) IBOutlet UILabel* infoRightLabel;

@property (nonatomic, retain) IBOutlet RKChartView* chartView;

- (void)update;

@end
