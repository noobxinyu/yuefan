//
//  SettingsViewController.m
//  YueFan
//
//  Created by Xinyu Li on 30/3/14.
//  Copyright (c) 2014 nus. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsTableViewCell.h"
#import "Utils.h"
#import "RCSwitchOnOff.h"
#import "FlatTheme.h"

@interface SettingsViewController ()

@property (nonatomic, strong) NSArray* settingTitles;

@property (nonatomic, strong) NSArray* settingsElements;

@property (nonatomic, strong) NSString* boldFontName;

@property (nonatomic, strong) UIColor* onColor;

@property (nonatomic, strong) UIColor* offColor;

@property (nonatomic, strong) UIColor* dividerColor;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    self.boldFontName = @"Avenir-Black";
    
    self.onColor = [UIColor colorWithRed:7.0/255 green:61.0/255 blue:48.0/255 alpha:1.0f];
    self.offColor = [UIColor colorWithRed:32.0/255 green:158.0/255 blue:133.0/255 alpha:1.0f];

    self.dividerColor = [UIColor whiteColor];
    
    [FlatTheme styleNavigationBarWithFontName:self.boldFontName andColor:self.onColor];
    [FlatTheme styleSegmentedControlWithFontName:self.boldFontName andSelectedColor:self.onColor andUnselectedColor:self.offColor andDidviderColor:self.dividerColor];
    
    self.navigationItem.leftBarButtonItem = [Utils getMenuItem];
    self.navigationItem.rightBarButtonItem  = [Utils getSearchButtonItem];
    
    self.title = @"Settings";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = nil;
    
    
    self.tableView.backgroundColor = [UIColor colorWithRed:231.0/255 green:235.0/255 blue:238.0/255 alpha:1.0f];
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.settingTitles  = [NSArray arrayWithObjects:@"Bluetooth", @"Cloud backup", @"Show Offers", @"Streaming", @"Manage Accounts", nil];
    
    self.settingsElements = [NSArray arrayWithObjects:@"None", @"Switch", @"Segment", @"None", @"None", nil];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    headerView.backgroundColor = [UIColor clearColor];
    
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(30, 9, 200, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:self.boldFontName size:20.0f];
    label.textColor = self.onColor;
    
    label.text = section == 0 ? @"Account Settings" : @"User Information";
    
    [headerView addSubview:label];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // A case was selected, so push into the CaseDetailViewController
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingsCell"];
    
    NSString* title = self.settingTitles[indexPath.row];
    
    cell.textLabel.text = [title uppercaseString];
    cell.textLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:self.boldFontName size:12.0f];
    
    NSString* element = self.settingsElements[indexPath.row];
    
    if([element isEqualToString:@"Switch"]){
        
        RCSwitchOnOff* cellSwitch = [self createSwitch];
        [cell addSubview:cellSwitch];
    }
    else if ([element isEqualToString:@"Segment"]){
        
        UISegmentedControl* control = [self createSegmentedControlWithItems:[NSArray arrayWithObjects:@"YES", @"NO", nil]];
        
        [cell addSubview:control];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

-(RCSwitchOnOff*)createSwitch{
    
    FlatTheme* theme = [[FlatTheme alloc] init];
    theme.switchOnBackground = [Utils drawImageOfSize:CGSizeMake(70, 30) andColor:self.onColor];
    theme.switchOffBackground = [Utils drawImageOfSize:CGSizeMake(70, 30) andColor:self.onColor];
    theme.switchThumb = [Utils drawImageOfSize:CGSizeMake(30, 29) andColor:self.offColor];
    theme.switchTextOffColor = [UIColor whiteColor];
    theme.switchTextOnColor = [UIColor whiteColor];
    theme.switchFont = [UIFont fontWithName:self.boldFontName size:12.0f];
    
    RCSwitchOnOff* settingSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(230, 7, 70, 30) andTheme:theme];
    return settingSwitch;
}

-(UISegmentedControl*)createSegmentedControlWithItems:(NSArray*)items{
    
    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    
    segmentedControl.frame = CGRectMake(150, 7, 150, 30);
    segmentedControl.selectedSegmentIndex = 0;
    
    return segmentedControl;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
