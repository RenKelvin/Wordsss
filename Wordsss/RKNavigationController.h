//
//  RkNavigationController.h
//  Wordsss
//
//  Created by RenKelvin on 11-10-4.
//  Copyright 2011年 Ren Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RKNavigationView.h"

@interface RKNavigationController : UINavigationController
{
    UIView *customNavigationbBarView;
}

- (void)hideBuiltinNavigationBar;
- (void)showCustomNavigationBar;

@end
