//
//  ListsViewController.m
//  Wordsss
//
//  Created by RenKelvin on 11-10-2.
//  Copyright 2011年 Ren Inc. All rights reserved.
//

#import "ListsViewController.h"

@implementation ListsViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    _listsVirtualActor = [ListsVirtualActor listsVirtualActor];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListViewController* lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
    ListCell* cell = (ListCell*)[tableView cellForRowAtIndexPath:indexPath];
    lvc = [lvc initWithList:cell.list];
    [[self navigationController] pushViewController:lvc animated:YES];    
}

#pragma - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    RKTableHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"RKDashBoard" owner:self options:nil] objectAtIndex:0];
    
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    headerView.titleLabel.text = @"其他词表";
    
    return headerView;
}

// Section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_listsVirtualActor getListDictionary] count];
}

// Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* WordBooksTableViewCellIndentifier = @"ListsTableViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:WordBooksTableViewCellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WordBooksTableViewCellIndentifier];
    }
    
    NSDictionary* dict = [_listsVirtualActor getListDictionary];
    [(ListCell*)cell setList:[[dict allValues] objectAtIndex:indexPath.row]];
    [(ListCell*)cell configCell];
    
    return cell;
}

@end
