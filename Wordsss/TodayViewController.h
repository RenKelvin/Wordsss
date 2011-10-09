//
//  TodayViewController.h
//  Wordsss
//
//  Created by RenKelvin on 11-10-2.
//  Copyright 2011年 Ren Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "RKNavigationController.h"
#import "RKNavigationControllerDelegate.h"

#import "UserDelegater.h"
#import "TodayDelegater.h"

@interface TodayViewController : UIViewController <RKNavigationControllerDelegate, UINavigationControllerDelegate>
{
    UserDelegater* userDelegater;
    TodayDelegater* todayDelegater;
}

@property (nonatomic, retain) IBOutlet UIImageView* wordSliderImageView;
@property (nonatomic, retain) IBOutlet UIView* wordSliderTouchArea;
@property (nonatomic, retain) IBOutlet UIView* wordSliderLeftTapArea;
@property (nonatomic, retain) IBOutlet UIView* wordSliderRightTapArea;

- (IBAction)wordDetailSelected:(id)sender;

- (void)wordSliderPanning:(UIPanGestureRecognizer*)recognizer;
- (void)wordSliderLeftTap:(UITapGestureRecognizer*)recognizer;
- (void)wordSliderRightTap:(UITapGestureRecognizer*)recognizer;

@end
