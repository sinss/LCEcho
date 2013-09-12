//
//  drawTableViewController.m
//  SlyCool001
//
//  Created by sinss on 12/10/6.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import "drawTableViewController.h"
#import "shareHeaderView.h"
#import "shareFooterView.h"
#import "drawRecord.h"
#import "MoreContentViewController.h"

#define kCustomRowHeight  60.0
#define kCustomRowCount   9
#define kAppIconHeight    48
#define kAppIconWidth    64

@interface drawTableViewController ()

- (void)reloadStoreData;
- (void)reloadStoreDataOfRefreshing;
- (void)createBarButton;
- (void)closeItemPress;


@end

@implementation drawTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.title = NSLocalizedString(@"", @"");
        self.tabBarItem.image = [UIImage imageNamed:tab3Image];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (downloadDraw == nil)
    {
        NSString *tabUrl = [[appConfigRecord appConfigInstance] tabURL3];
        if (tabUrl != nil)
        {
            downloadDraw = [[downloadStoreDelegate alloc] initWithURL:tabUrl];
            downloadDraw.currLocation = [[appConfigRecord appConfigInstance] currentLocation];
            downloadDraw.csvLoadtype = csvLoadTypeDraw;
            [downloadDraw setDelegate:self];
        }
    }
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    if (_refreshHeaderView == nil)
    {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
    
	[_refreshHeaderView refreshLastUpdatedDate];
    
	self.tableView.rowHeight = kCustomRowHeight;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.labelText = @"資料讀取中...";
    [HUD showWhileExecuting:@selector(reloadStoreData) onTarget:self withObject:nil animated:YES];
}

- (void)dealloc
{
    [drawArray release], drawArray = nil;
    [downloadDraw release], downloadDraw = nil;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [drawArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    shareFooterView *headerView = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"shareHeaderView" owner:self options:nil];
    for (id currentObj in topLevelObjects)
    {
        if ([currentObj isKindOfClass:[shareFooterView class]])
        {
            headerView = currentObj;
            break;
        }
    }
    /*
     NSString *currAddress = [[appConfigRecord appConfigInstance] currentAddress];
     if([currAddress length] > 0)
     [headerView.titleLabel setText:currAddress];
     else
     [headerView.titleLabel setText:@"偵測不到目前所在位置...."];
     */
    [headerView.titleLabel setText:@"◎ 本次舉辦之所有抽獎、比賽、活動皆與蘋果公司無關。"];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *drawCellIdentifier = @"drawCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:drawCellIdentifier];
    NSUInteger row = [indexPath row];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:drawCellIdentifier] autorelease];
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
    drawRecord *draw = [drawArray objectAtIndex:row];
    [cell.textLabel setText:draw.dTitle];
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
    NSInteger row = [indexPath row];
    drawRecord *draw = [drawArray objectAtIndex:row];
    
    NSURL *url = [NSURL URLWithString:draw.dUrl];
    if (url != nil)
    {
        MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
        [moreContentView setCurrentUrl:url];
        [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentModalViewController:moreContentView animated:YES];
        [moreContentView release];
    }
}

#pragma mark - reload table view data

- (void)reloadTableViewDataSource
{
    _reloading = YES;
    [self reloadStoreDataOfRefreshing];
}


- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading;
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date];
	
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    
}



#pragma mark download delegate

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFaildDownloadWithError:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
}

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFinishDownloadWithData:(NSArray *)stores
{
    drawArray = [[NSArray alloc] initWithArray:stores];
    //NSLog(@"%@",storeArray);
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)reloadStoreData
{
    [downloadDraw startGetStoreWithRefreshing:NO];
}
- (void)reloadStoreDataOfRefreshing
{
    [downloadDraw startGetStoreWithRefreshing:YES];
}

- (void)createBarButton
{
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"關閉" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemPress)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:closeItem, nil];
    [closeItem release];
}

- (void)closeItemPress
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
