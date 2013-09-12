//
//  topicDetailViewController.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import "topicDetailViewController.h"
#import "SlyCoolA.h"
#import "customPictureCell.h"
#import "topicInformationCell.h"
#import "topicExInformationCell.h"
#import "SBJSON.h"
#import "MoreContentViewController.h"
#import "shareHeaderView.h"

@interface topicDetailViewController ()

- (void)createTableData;

@end

@implementation topicDetailViewController
@synthesize currentTopic;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
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
    if (groupArray == nil)
    {
        [self createTableData];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)dealloc
{
    [currentTopic release], currentTopic = nil;
    [groupArray release], groupArray = nil;
    [resultArray release], resultArray = nil;
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [resultArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tmpArray = [resultArray objectAtIndex:section];
    return [tmpArray count];
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
    if ([[groupArray objectAtIndex:section] isEqualToString:@"延伸資訊"])
        [headerView.titleLabel setText:@"延伸資訊"];
    else if (section == 0)
        [headerView.titleLabel setText:@"好康內容"];
    else
        [headerView.titleLabel setText:@""];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    if ([[groupArray objectAtIndex:sec] isEqualToString:@"A"] ||
        [[groupArray objectAtIndex:sec] isEqualToString:@"B"] ||
        [[groupArray objectAtIndex:sec] isEqualToString:@"C"])
    {
        if (row == 0)
        {
            NSUInteger lineNo = 0;
            if ([[groupArray objectAtIndex:sec] isEqualToString:@"A"])
            {
                lineNo = ([currentTopic.AConA length] / klineWordUnit);
            }
            else if ([[groupArray objectAtIndex:sec] isEqualToString:@"B"])
            {
                lineNo = ([currentTopic.AConB length] / klineWordUnit);
            }
            else if ([[groupArray objectAtIndex:sec] isEqualToString:@"C"])
            {
                lineNo = ([currentTopic.AConC length] / klineWordUnit);
            }
            return kdefaultCellHeight + lineNo * ktextViewHeightUnit;
        }
        else if (row == 1)
        {
            return 194;
        }
        return 40;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *exInfoCellIdentifier = @"exInfoCellIdentifier";
    static NSString *detfaultCellIdentifier = @"detfaultCellIdentifier";
    static NSString *titleCellIdentifier = @"titleCellIdentifier";
    static NSString *pictureCellIdentfier = @"pictureCellIdentfier";
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    if ([[groupArray objectAtIndex:sec] isEqualToString:@"A"])
    {
        if (row == 1)
        {
            customPictureCell *cell = [self.tableView dequeueReusableCellWithIdentifier:pictureCellIdentfier];
            //圖片
            if (cell == nil)
            {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customPictureCell" owner:self options:nil];
                for (id currentObj in topLevelObjects)
                {
                    if ([currentObj isKindOfClass:[customPictureCell class]])
                    {
                        cell = currentObj;
                        break;
                    }
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            [cell initImageViewWithUrl:[NSURL URLWithString:currentTopic.APicA] andImageName:[NSString stringWithFormat:@"topic_%@_A",currentTopic.ANo]];
            return cell;
        }
        else
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
            [cell.titleLabel setText:currentTopic.ASubA];
            [cell.contentTextView setText:currentTopic.AConA];
            //重新調整textview的高度
            NSUInteger lineNo = [currentTopic.AConA length] / klineWordUnit;
            NSUInteger newHeight = kdefaultTextViewHeight + lineNo * ktextViewHeightUnit;
            CGRect rect = cell.contentTextView.frame;
            [cell.contentTextView setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, newHeight)];
            return cell;
        }
    }
    else if ([[groupArray objectAtIndex:sec] isEqualToString:@"B"])
    {
        if (row == 1)
        {
            customPictureCell *cell = [self.tableView dequeueReusableCellWithIdentifier:pictureCellIdentfier];
            //圖片
            if (cell == nil)
            {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customPictureCell" owner:self options:nil];
                for (id currentObj in topLevelObjects)
                {
                    if ([currentObj isKindOfClass:[customPictureCell class]])
                    {
                        cell = currentObj;
                        break;
                    }
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            [cell initImageViewWithUrl:[NSURL URLWithString:currentTopic.APicB] andImageName:[NSString stringWithFormat:@"topic_%@_B",currentTopic.ANo]];
            return cell;
        }
        else
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
            [cell.titleLabel setText:currentTopic.ASubB];
            [cell.contentTextView setText:currentTopic.AConB];
            //重新調整textview的高度
            NSUInteger lineNo = [currentTopic.AConB length] / klineWordUnit;
            NSUInteger newHeight = kdefaultTextViewHeight + lineNo * ktextViewHeightUnit;
            CGRect rect = cell.contentTextView.frame;
            [cell.contentTextView setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, newHeight)];
            return cell;
        }
    }
    else if ([[groupArray objectAtIndex:sec] isEqualToString:@"C"])
    {
        if (row == 1)
        {
            customPictureCell *cell = [self.tableView dequeueReusableCellWithIdentifier:pictureCellIdentfier];
            //圖片
            if (cell == nil)
            {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customPictureCell" owner:self options:nil];
                for (id currentObj in topLevelObjects)
                {
                    if ([currentObj isKindOfClass:[customPictureCell class]])
                    {
                        cell = currentObj;
                        break;
                    }
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            [cell initImageViewWithUrl:[NSURL URLWithString:currentTopic.APicC] andImageName:[NSString stringWithFormat:@"topic_%@_C",currentTopic.ANo]];
            return cell;
        }
        else
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
            [cell.titleLabel setText:currentTopic.ASubC];
            [cell.contentTextView setText:currentTopic.AConC];
            //重新調整textview的高度
            NSUInteger lineNo = [currentTopic.AConC length] / klineWordUnit;
            NSUInteger newHeight = kdefaultTextViewHeight + lineNo * ktextViewHeightUnit;
            CGRect rect = cell.contentTextView.frame;
            [cell.contentTextView setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, newHeight)];
            return cell;
        }
    }
    else
    {
        //延伸資訊
        topicExInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:exInfoCellIdentifier];
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
        NSArray *tmpArray = [resultArray objectAtIndex:sec];
        if ([[tmpArray objectAtIndex:row] isEqualToString:@"subcon"])
        {
            [cell.titleLabel setText:currentTopic.ASubCon];
        }
        else if ([[tmpArray objectAtIndex:row] isEqualToString:@"exinfo"])
        {
            [cell.titleLabel setText:currentTopic.ExInfo];
        }
        else if ([[tmpArray objectAtIndex:row] isEqualToString:@"fb"])
        {
            [cell.titleLabel setText:@"Facebook連結"];
        }
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detfaultCellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:detfaultCellIdentifier] autorelease];
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
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    if ([[groupArray objectAtIndex:sec] isEqualToString:@"A"] ||
        [[groupArray objectAtIndex:sec] isEqualToString:@"B"] ||
        [[groupArray objectAtIndex:sec] isEqualToString:@"C"])
    {
        
    }
    else
    {
        NSArray *tmpArray = [resultArray objectAtIndex:sec];
        if ([[tmpArray objectAtIndex:row] isEqualToString:@"subcon"])
        {
        }
        else if ([[tmpArray objectAtIndex:row] isEqualToString:@"exinfo"])
        {
            MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
            [moreContentView setCurrentUrl:[NSURL URLWithString:currentTopic.ExInfoURL]];
            [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentModalViewController:moreContentView animated:YES];
            [moreContentView release];
        }
        else if ([[tmpArray objectAtIndex:row] isEqualToString:@"fb"])
        {
            MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
            [moreContentView setCurrentUrl:[NSURL URLWithString:currentTopic.FBURL]];
            [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentModalViewController:moreContentView animated:YES];
            [moreContentView release];
        }
    }
}

- (void)createTableData
{
    NSMutableArray *groups = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:0];
    if ([currentTopic.ASubA length] > 0)
    {
        [groups addObject:@"A"];
        NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:0];
        [tmp addObject:currentTopic.ASubA];

        if ([currentTopic.APicA length] > 0)
        {
            [tmp addObject:currentTopic.APicA];
        }
        [results addObject:tmp];
    }
    if ([currentTopic.ASubB length] > 0)
    {
        [groups addObject:@"B"];
        NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:0];
        [tmp addObject:currentTopic.ASubB];
        if ([currentTopic.APicB length] > 0)
        {
            [tmp addObject:currentTopic.APicA];
        }
        [results addObject:tmp];
    }
    if ([currentTopic.ASubC length] > 0)
    {
        [groups addObject:@"C"];
        NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:0];
        [tmp addObject:currentTopic.ASubC];
        if ([currentTopic.APicC length] > 0)
        {
            [tmp addObject:currentTopic.APicC];
        }
        [results addObject:tmp];
    }
    if ([currentTopic.ExInfo length] > 0 || [currentTopic.FBURL length] > 0 ||
        [currentTopic.ASubCon length] > 0)
    {
        [groups addObject:@"延伸資訊"];
        NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:0];
        if ([currentTopic.ASubCon length] > 0)
        {
            //小計資訊
            [tmp addObject:@"subcon"];
        }
        if ([currentTopic.ExInfo length] > 0)
        {
            //延伸資訊
            [tmp addObject:@"exinfo"];
        }
        if ([currentTopic.FBURL length] > 0)
        {
            //fb網址
            [tmp addObject:@"fb"];
        }
        [results addObject:tmp];
    }
    
    groupArray = [[NSArray alloc] initWithArray:groups];
    resultArray = [[NSArray alloc] initWithArray:results];
}

@end
