//
//  bannerContentTableViewController.m
//  SlyCool001
//
//  Created by sinss on 12/8/27.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import "bannerContentTableViewController.h"
#import "customPictureCell.h"
#import "topicInformationCell.h"
#import "topicExInformationCell.h"
#import "MoreContentViewController.h"
#import "shareHeaderView.h"
#import "adRecord.h"
#import "SBJSON.h"

#define contentKey @"content"
@interface bannerContentTableViewController ()

- (void)createBarButton;
- (void)closeItemPress;

@end

@implementation bannerContentTableViewController
@synthesize currentAdRecord;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.title = [NSString stringWithFormat:@"精選活動"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tableView_bg]];
    [self.tableView setBackgroundView:bgView];
    [bgView release];
    [self createBarButton];
    NSError *error = nil;
    SBJSON *json = [[SBJSON new] autorelease];
	contentDict = [[NSDictionary alloc] initWithDictionary:[json objectWithString:currentAdRecord.adContent error:&error]];
    titleDict = [[NSDictionary alloc] initWithDictionary:[json objectWithString:currentAdRecord.adTitle error:&error]];
    NSLog(@"content:%@",contentDict);
    NSLog(@"title:%@",titleDict);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [currentAdRecord release], currentAdRecord = nil;
    [contentDict release], contentDict = nil;
    [titleDict release], titleDict = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [contentDict valueForKey:contentKey];
    if (section == 0)
        return [array count];
    return 1;
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
    if (section == 0)
    {
        [headerView.titleLabel setText:[NSString stringWithFormat:@"活動內容"]];
    }
    else if (section == 1)
    {
        [headerView.titleLabel setText:[NSString stringWithFormat:@"活動網址"]];
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    if (sec == 0)
    {
        NSArray *array = [contentDict valueForKey:contentKey];
        NSString *contentString = [array objectAtIndex:row];
        NSUInteger lineNo = lineNo = ([contentString length] / klineWordUnit);
        return kdefaultCellHeight + lineNo * ktextViewHeightUnit;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *titleCellIdentifier = @"titleCellIdentifier";
    static NSString *urlCellIdentifier = @"urlCellIdentifier";
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    if (sec == 0)
    {
        topicInformationCell *cell = [self.tableView dequeueReusableCellWithIdentifier:titleCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"topicInformationCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[topicInformationCell class]])
                {
                    cell = currentObj;
                    break;
                }
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        if (row % 2 == 1)
        {
            UIView *cellView = [[UIView alloc] init];
            [cellView setBackgroundColor:oddCellBackgroundColor];
            [cell setBackgroundView:cellView];
            [cellView release];
        }
        NSArray *titles = [titleDict valueForKey:contentKey];
        NSArray *contents = [contentDict valueForKey:contentKey];
        [cell.titleLabel setText:[titles objectAtIndex:row]];
        [cell.contentTextView setText:[contents objectAtIndex:row]];
        //重新調整textview的高度
        NSUInteger lineNo = [[contents objectAtIndex:row] length] / klineWordUnit;
        NSUInteger newHeight = kdefaultTextViewHeight + lineNo * ktextViewHeightUnit;
        CGRect rect = cell.contentTextView.frame;
        [cell.contentTextView setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, newHeight)];
        return cell;
    }
    else
    {
        //延伸資訊
        topicExInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:urlCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"topicExInformationCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[topicExInformationCell class]])
                {
                    cell = currentObj;
                    break;
                }
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
            [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
        }
        [cell.titleLabel setText:[NSString stringWithFormat:@"點我看詳細內容"]];
        return cell;
    }
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
    if ([indexPath section] == 1)
    {
        NSURL *url = [NSURL URLWithString:currentAdRecord.contentUrl];
        if (url != nil)
        {
            MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
            [moreContentView setCurrentUrl:url];
            [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:moreContentView animated:YES completion:nil];
            [moreContentView release];
        }
    }
}

- (void)createBarButton
{
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:mainPageItemName style:UIBarButtonItemStylePlain target:self action:@selector(closeItemPress)];
    self.navigationItem.rightBarButtonItem = closeItem;
}

- (void)closeItemPress
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
