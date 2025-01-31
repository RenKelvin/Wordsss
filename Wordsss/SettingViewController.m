//
//  SettingViewController.m
//  Wordsss
//
//  Created by RenKelvin on 11-10-3.
//  Copyright 2011年 Ren Inc. All rights reserved.
//

#import "SettingViewController.h"

static char* nameArray[13] = {
    "未制定",      // 0    - Zero
    "基础",       // 1    - Basic
    "初中",       // 2    - Middle
    "高中",       // 3    - High
    "CET4",     // 4    - CET4
    "CET6",     // 5    - CET6
    "考研",       // 6    - GET
    "IELTS",    // 7    - IELTS
    "TOEFL",    // 8    - TOEFL
    "SAT",      // 9    - SAT
    "GRE",      // 10   - GRE
    "GMAT",     // 11   - GMAT
    "超神"        // 12   - HolyShit
};

@implementation SettingViewController

@synthesize nameTextField, pickerView, pickerAccessoryView, levelPickerView;
@synthesize curLabel, tarLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)update
{
    //
    NSString* nameString = _settingVirtualActor.user.profile.nickname;
    [self.nameTextField setText:nameString];
    
    //
    int curLvl = [_settingVirtualActor.user.defult.currentLevel intValue];
    int tarLvl = [_settingVirtualActor.user.defult.targetLevel intValue];
    
    // Update label
    [self.curLabel setText:[NSString stringWithCString:nameArray[curLvl] encoding:4]];
    [self.tarLabel setText:[NSString stringWithCString:nameArray[tarLvl] encoding:4]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get todayVirtualActor
    _settingVirtualActor = [SettingVirtualActor settingVirtualActor];
    
    //
    [self update];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[[self navigationController] navigationBar] setBackgroundImage:[UIImage imageNamed:@"topbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - IBAction

- (IBAction)curLevelButtonClicked:(id)sender
{
    //
    int curRow = [_settingVirtualActor.user.defult.currentLevel intValue] - 1;
    [self.pickerView selectRow:curRow inComponent:0 animated:YES];
    int tarRow = [_settingVirtualActor.user.defult.targetLevel intValue] - 1;
    [self.pickerView selectRow:tarRow inComponent:1 animated:YES];
    
    //
    curORtar = 0;
    
    // Show pickerView
    RKTabBarController* tvc = ((RKTabBarController*)[[UIApplication sharedApplication] delegate].window.rootViewController);
    [self.levelPickerView setFrame:kLevelPickerViewFrameHide];
    [tvc.view addSubview:self.levelPickerView];
    
    [UIView animateWithDuration:0.3 animations:^(void){
        [self.levelPickerView setFrame:kLevelPickerViewFrameShow];
    }];
}

- (IBAction)tarLevelButtonClicked:(id)sender
{
    //
    int curRow = [_settingVirtualActor.user.defult.currentLevel intValue] - 1;
    [self.pickerView selectRow:curRow inComponent:0 animated:YES];
    int tarRow = [_settingVirtualActor.user.defult.targetLevel intValue] - 1;
    [self.pickerView selectRow:tarRow inComponent:1 animated:YES];
    
    //
    curORtar = 1;
    
    // Show pickerView
    RKTabBarController* tvc = ((RKTabBarController*)[[UIApplication sharedApplication] delegate].window.rootViewController);
    [self.levelPickerView setFrame:kLevelPickerViewFrameHide];
    [tvc.view addSubview:self.levelPickerView];
    
    [UIView animateWithDuration:0.3 animations:^(void){
        [self.levelPickerView setFrame:kLevelPickerViewFrameShow];
    }];
}

- (IBAction)doneButtonClicked:(id)sender
{
    //
    int curRow = (int)[self.pickerView selectedRowInComponent:0];
    int tarRow = (int)[self.pickerView selectedRowInComponent:1];
    
    // ERROR
    if (curRow >= tarRow) {
        [[[UIAlertView alloc] initWithTitle:@"范围无效" message:@"您必须从较低水平选择至较高水平。" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil] show];
    }
    else {
        _settingVirtualActor.user.defult.currentLevel = [NSNumber numberWithInt:curRow + 1];
        _settingVirtualActor.user.defult.targetLevel = [NSNumber numberWithInt:tarRow + 1];
        
        // Update label
        [self.curLabel setText:[NSString stringWithCString:nameArray[curRow+1] encoding:4]];
        [self.tarLabel setText:[NSString stringWithCString:nameArray[tarRow+1] encoding:4]];
        
        // Hide pickerView
        [UIView animateWithDuration:0.3 animations:^(void)
         {
             [self.levelPickerView setFrame:kLevelPickerViewFrameHide];
         }];
    }
}

- (IBAction)resetButtonClicked:(id)sender
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"重置当前记忆数据" otherButtonTitles:nil];
    UITabBar* tabBar = ((RKTabBarController*)[[UIApplication sharedApplication] delegate].window.rootViewController).tabBar;
    [actionSheet showFromTabBar:tabBar];
}

- (IBAction)patentButtonClicked:(id)sender
{
    //    PatentViewController* pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"PatentViewController"];
    //    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:pvc];
    //    [self presentModalViewController:nc animated:YES];
    
    AboutViewController* avc = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
    
    [[self navigationController] pushViewController:avc animated:YES];
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString* string = [NSString string];
    
    // string = [NSString stringWithFormat:@"%@ - %@", [NSString stringWithCString:nameArray[row+1] encoding:4], [NSString stringWithCString:vocaArray[row+1] encoding:4]];
    string = [NSString stringWithFormat:@"%@", [NSString stringWithCString:nameArray[row+1] encoding:4]];
    
    return string;
}

#pragma mark - UIPickerViewDatasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 12;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //
    [_settingVirtualActor.user.profile setNickname:textField.text];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UserDataManager* udm = [UserDataManager userdataManager];
            [udm resetAll];
            break;
        }
        case 1:
        {
            ;
            break;
        }
        default:
            break;
    }
}

@end
