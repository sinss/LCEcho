//
//  carnivalDetailTableViewController.m
//  SlyCool001
//
//  Created by sinss on 12/10/6.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import "carnivalDetailTableViewController.h"
#import "storeInformationCell.h"
#import "customTextViewCell.h"
#import "activityRecord.h"
#import "stageRecord.h"
#import "drawRecord.h"
#import "movieRecord.h"
#import "shareHeaderView.h"
#import "MoreContentViewController.h"

@interface carnivalDetailTableViewController ()

@end

@implementation carnivalDetailTableViewController
@synthesize currentActivity, detailType;
@synthesize currentMovie, currentStage;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self createBackItem];
    if (groupArray == nil)
    {
        groupArray = [[NSArray alloc] initWithObjects:@"基本資訊",@"說明", nil];
    }
    if (informationArray == nil)
    {
        informationArray = [[NSArray alloc] initWithObjects:@"基本資訊", nil];
    }
    if (detailType == carnivalDetailTypeActivity)
    {
        if (contentArray == nil)
        {
            contentArray = [[NSArray alloc] initWithObjects:@"content", nil];
        }
    }
    else if (detailType == carnivalDetailTypeStage)
    {
        if (contentArray == nil)
        {
            contentArray = [[NSArray alloc] initWithObjects:@"content", @"otherUrl" ,nil];
        }
    }
    else if (detailType == carnivalDetailTypeMovie)
    {
        if (contentArray == nil)
        {
            contentArray = [[NSArray alloc] initWithObjects:@"content", @"movieUrl", @"otherUrl" ,nil];
        }
    }
}

- (void)dealloc
{
    [groupArray release], groupArray = nil;
    [currentActivity release], currentActivity = nil;
    [currentStage release], currentStage = nil;
    [currentMovie release], currentMovie = nil;
    [informationArray release], informationArray = nil;
    [contentArray release], contentArray = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [groupArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [informationArray count];
    }
    else if (section == 1)
    {
        return [contentArray count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = [indexPath section];
    NSInteger row = [indexPath row];
    if (sec == 0)
        return 240;
    else
    {
        NSInteger lineNo = 0;
        if (detailType == carnivalDetailTypeActivity)
        {
            lineNo = [currentActivity.aIntroduction length] / klineWordUnit;
            return kdefaultCellHeight + lineNo * ktextViewHeightUnit;
        }
        else if (detailType == carnivalDetailTypeStage)
        {
            if (row == 0)
            {
                lineNo = [currentStage.sIntroduction length] / klineWordUnit;
                return kdefaultCellHeight + lineNo * ktextViewHeightUnit;
            }
        }
        else if (detailType == carnivalDetailTypeMovie)
        {
            if (row == 0)
            {
                lineNo = [currentMovie.mIntroduction length] / klineWordUnit;
                return kdefaultCellHeight + lineNo * ktextViewHeightUnit;
            }
        }
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    shareHeaderView *headerView = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"shareHeaderView" owner:self options:nil];
    for (id currentObj in topLevelObjects)
    {
        if ([currentObj isKindOfClass:[shareHeaderView class]])
        {
            headerView = currentObj;
            break;
        }
    }
    NSString *title = [groupArray objectAtIndex:section];
    [headerView.titleLabel setText:title];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *emptyCellIdnetifier = @"emptyCellIdnetifier";
    static NSString *commonCellIdentifier = @"commonCellIdentifier";
    static NSString *informationCellIdentifier = @"informationCellIdentifier";
    static NSString *contentCellIdentifier = @"contentCellIdentifier";
    
    NSInteger sec = [indexPath section];
    NSInteger row = [indexPath row];
    if (detailType == carnivalDetailTypeActivity)
    {
        if (sec == 0)
        {
            storeInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:informationCellIdentifier];
            if (cell == nil)
            {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"storeInformationCell" owner:self options:nil];
                for (id currentObj in topLevelObjects)
                {
                    if ([currentObj isKindOfClass:[storeInformationCell class]])
                    {
                        cell = currentObj;
                        break;
                    }
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                if (row % 2 == 1)
                {
                    UIView *cellView = [[UIView alloc] init];
                    [cellView setBackgroundColor:oddCellBackgroundColor];
                    [cell setBackgroundView:cellView];
                    [cellView release];
                }
            }
            [cell.titleLabel setText:currentActivity.aTitle];
            NSURL *url =[NSURL URLWithString:currentActivity.aImageUrl];
            [cell initImageViewWithUrl:url andImageName:currentActivity.aID];
            [cell.addressLabel setText:currentActivity.aLocationDesc];
            [cell.phoneTextView setText:@""];
            [cell.distanceLabel setText:@""];
            
            return cell;
        }
        else
        {
            customTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCellIdentifier];
            if (cell == nil)
            {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customTextViewCell" owner:self options:nil];
                for (id currentObj in topLevelObjects)
                {
                    if ([currentObj isKindOfClass:[customTextViewCell class]])
                    {
                        cell = currentObj;
                        break;
                    }
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                if (row % 2 == 1)
                {
                    UIView *cellView = [[UIView alloc] init];
                    [cellView setBackgroundColor:oddCellBackgroundColor];
                    [cell setBackgroundView:cellView];
                    [cellView release];
                }
            }
            NSUInteger lineNo = [currentActivity.aIntroduction length] / klineWordUnit;
            NSUInteger newHeight = kdefaultTextViewHeight + lineNo * ktextViewHeightUnit;
            CGRect rect = cell.contentTextView.frame;
            [cell.contentTextView setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, newHeight)];
            [cell.contentTextView setText:currentActivity.aIntroduction];
            return cell;
        }
    }
    else if (detailType == carnivalDetailTypeStage)
    {
        if (sec == 0)
        {
            storeInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:informationCellIdentifier];
            if (cell == nil)
            {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"storeInformationCell" owner:self options:nil];
                for (id currentObj in topLevelObjects)
                {
                    if ([currentObj isKindOfClass:[storeInformationCell class]])
                    {
                        cell = currentObj;
                        break;
                    }
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                if (row % 2 == 1)
                {
                    UIView *cellView = [[UIView alloc] init];
                    [cellView setBackgroundColor:oddCellBackgroundColor];
                    [cell setBackgroundView:cellView];
                    [cellView release];
                }
            }
            [cell.titleLabel setText:currentStage.sTitle];
            NSURL *url =[NSURL URLWithString:currentStage.sImageUrl];
            [cell initImageViewWithUrl:url andImageName:currentStage.sID];
            [cell.addressLabel setText:currentStage.sLocationDesc];
            [cell.phoneTextView setText:currentStage.sTime];
            [cell.distanceLabel setText:@""];
            
            return cell;
        }
        else
        {
            if (row == 0)
            {
                customTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCellIdentifier];
                if (cell == nil)
                {
                    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customTextViewCell" owner:self options:nil];
                    for (id currentObj in topLevelObjects)
                    {
                        if ([currentObj isKindOfClass:[customTextViewCell class]])
                        {
                            cell = currentObj;
                            break;
                        }
                    }
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    if (row % 2 == 1)
                    {
                        UIView *cellView = [[UIView alloc] init];
                        [cellView setBackgroundColor:oddCellBackgroundColor];
                        [cell setBackgroundView:cellView];
                        [cellView release];
                    }
                }
                NSUInteger lineNo = [currentStage.sIntroduction length] / klineWordUnit;
                NSUInteger newHeight = kdefaultTextViewHeight + lineNo * ktextViewHeightUnit;
                CGRect rect = cell.contentTextView.frame;
                [cell.contentTextView setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, newHeight)];
                [cell.contentTextView setText:currentStage.sIntroduction];
                return cell;
            }
            else
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commonCellIdentifier];
                if (cell == nil)
                {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commonCellIdentifier] autorelease];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
                    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
                    if (row % 2 == 1)
                    {
                        UIView *cellView = [[UIView alloc] init];
                        [cellView setBackgroundColor:oddCellBackgroundColor];
                        [cell setBackgroundView:cellView];
                        [cellView release];
                    }
                }
                if ([[contentArray objectAtIndex:row] isEqualToString:@"otherUrl"])
                {
                    [cell.textLabel setText:@"外部連結"];
                }
                else if ([[contentArray objectAtIndex:row] isEqualToString:@"movieUrl"])
                {
                    [cell.textLabel setText:@"影片連結"];
                }
                return cell;
            }
        }
    }
    else if (detailType == carnivalDetailTypeMovie)
    {
        if (sec == 0)
        {
            storeInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:informationCellIdentifier];
            if (cell == nil)
            {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"storeInformationCell" owner:self options:nil];
                for (id currentObj in topLevelObjects)
                {
                    if ([currentObj isKindOfClass:[storeInformationCell class]])
                    {
                        cell = currentObj;
                        break;
                    }
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                if (row % 2 == 1)
                {
                    UIView *cellView = [[UIView alloc] init];
                    [cellView setBackgroundColor:oddCellBackgroundColor];
                    [cell setBackgroundView:cellView];
                    [cellView release];
                }
            }
            [cell.titleLabel setText:currentMovie.mTitle];
            NSURL *url =[NSURL URLWithString:currentMovie.mImageUrl];
            [cell initImageViewWithUrl:url andImageName:currentMovie.mID];
            [cell.addressLabel setText:currentMovie.mDirector];
            [cell.phoneTextView setText:currentMovie.mTeamDesc];
            [cell.distanceLabel setText:@""];
            
            return cell;
        }
        else
        {
            if (row == 0)
            {
                customTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCellIdentifier];
                if (cell == nil)
                {
                    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customTextViewCell" owner:self options:nil];
                    for (id currentObj in topLevelObjects)
                    {
                        if ([currentObj isKindOfClass:[customTextViewCell class]])
                        {
                            cell = currentObj;
                            break;
                        }
                    }
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    if (row % 2 == 1)
                    {
                        UIView *cellView = [[UIView alloc] init];
                        [cellView setBackgroundColor:oddCellBackgroundColor];
                        [cell setBackgroundView:cellView];
                        [cellView release];
                    }
                }
                NSUInteger lineNo = [currentMovie.mIntroduction length] / klineWordUnit;
                NSUInteger newHeight = kdefaultTextViewHeight + lineNo * ktextViewHeightUnit;
                CGRect rect = cell.contentTextView.frame;
                [cell.contentTextView setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, newHeight)];
                [cell.contentTextView setText:currentMovie.mIntroduction];
                return cell;
            }
            else
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commonCellIdentifier];
                if (cell == nil)
                {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commonCellIdentifier] autorelease];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
                    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
                    if (row % 2 == 1)
                    {
                        UIView *cellView = [[UIView alloc] init];
                        [cellView setBackgroundColor:oddCellBackgroundColor];
                        [cell setBackgroundView:cellView];
                        [cellView release];
                    }
                }
                if ([[contentArray objectAtIndex:row] isEqualToString:@"otherUrl"])
                {
                    [cell.textLabel setText:@"外部連結"];
                }
                else if ([[contentArray objectAtIndex:row] isEqualToString:@"movieUrl"])
                {
                    [cell.textLabel setText:@"影片連結"];
                }
                return cell;
            }
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:emptyCellIdnetifier forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:emptyCellIdnetifier] autorelease];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = [indexPath section];
    NSInteger row = [indexPath row];
    if (detailType == carnivalDetailTypeStage)
    {
        if (sec == 1)
        {
            if (row == 1)
            {
                NSURL *url = [NSURL URLWithString:currentStage.sOtherUrl];
                if (url != nil)
                {
                    MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
                    [moreContentView setCurrentUrl:url];
                    [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                    [self presentModalViewController:moreContentView animated:YES];
                    [moreContentView release];
                }
            }
        }
    }
    else if (detailType == carnivalDetailTypeMovie)
    {
        if (sec == 1)
        {
            if (row == 1)
            {
                NSURL *url = [NSURL URLWithString:currentMovie.mMovieUrl];
                if (url != nil)
                {
                    MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
                    [moreContentView setCurrentUrl:url];
                    [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                    [self presentModalViewController:moreContentView animated:YES];
                    [moreContentView release];
                }
            }
            else if (row == 2)
            {
                NSURL *url = [NSURL URLWithString:currentMovie.mOtherUrl];
                if (url != nil)
                {
                    MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
                    [moreContentView setCurrentUrl:url];
                    [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                    [self presentModalViewController:moreContentView animated:YES];
                    [moreContentView release];
                }
            }
        }
    }
}

- (void)createBackItem
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backItemPress:)];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObject:backItem];
    [backItem release];
}

- (void)backItemPress:(UIBarButtonItem*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
