//
//  moreTableViewController.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import "moreTableViewController.h"
#import "customTopicCell.h"
#import "slyCoolC.h"
#import "MoreContentViewController.h"
#import "MoreDetailTableViewController.h"

#define kCustomRowHeight  60.0
#define kCustomRowCount   9
#define kAppIconHeight    48
#define kAppIconWidth    64

@interface moreTableViewController ()

- (void)reloadMoreData;
- (void)reloadMoreDataOfRefreshing;
- (void)createBarButton;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end

@implementation moreTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.title = NSLocalizedString(@"系聯卡", @"系聯卡");
        self.tabBarItem.image = [UIImage imageNamed:tab5Image];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card_bg.png"]];
    [self.tableView setBackgroundView:bgView];
    [bgView release];
    //[self createBarButton];
    if (downloadProcess == nil)
    {
        NSString *moreUrl = [[appConfigRecord appConfigInstance] tabURL4];
        if (moreUrl != nil)
        {
            downloadProcess = [[downloadStoreDelegate alloc] initWithURL:moreUrl];
            downloadProcess.csvLoadtype = csvLoadTypePccuCards;
            [downloadProcess setDelegate:self];
        }
    }
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
    HUD.labelText = @"載入中...";
    [HUD showWhileExecuting:@selector(reloadMoreData) onTarget:self withObject:nil animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)dealloc
{
    [moreArray release], moreArray = nil;
    [downloadProcess release], downloadProcess = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [moreArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *moreCellIdentifier = @"moreCellIdentifier";
    NSUInteger row = [indexPath row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:moreCellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (row % 2 == 1)
        {
            UIView *cellView = [[UIView alloc] init];
            [cellView setBackgroundColor:oddCellBackgroundColor];
            [cell setBackgroundView:cellView];
            [cellView release];
        }
        [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        [cell.textLabel setShadowColor:[UIColor whiteColor]];
        [cell.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [cell.detailTextLabel setShadowColor:[UIColor whiteColor]];
    }
    slyCoolC *moreItem = [moreArray objectAtIndex:row];
	cell.textLabel.text = moreItem.CName;
    
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
    slyCoolC *moreItem = [moreArray objectAtIndex:[indexPath row]];
    if ([moreItem.CType isEqualToString:@"0"])
    {
        MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
        [moreContentView setCurrentUrl:[NSURL URLWithString:moreItem.CContent]];
        [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:moreContentView animated:YES completion:nil];
        [moreContentView release];
    }
    else if ([moreItem.CType isEqualToString:@"4"])
    {
        NSURL *url = [ [ NSURL alloc ] initWithString:moreItem.CContent];
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        MoreDetailTableViewController *moreDetailView = [[MoreDetailTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [moreDetailView setCurrentMoreItem:moreItem];
        [moreDetailView setTitle:moreItem.CName];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:moreDetailView];
        [nav setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:moreDetailView animated:YES completion:nil];
        [nav release];
        [moreDetailView release];
    }
}

#pragma mark - reload table view data

- (void)reloadTableViewDataSource{
    _reloading = YES;
    [self reloadMoreDataOfRefreshing];
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

#pragma mark - download process

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFaildDownloadWithError:(NSString *)errorMessage
{
    
}
- (void)downloadDelegate:(downloadStoreDelegate *)obj didFinishDownloadWithData:(NSArray *)array
{
    moreArray = [[NSArray alloc] initWithArray:array];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - 其它函式
- (void)reloadMoreData
{
    [downloadProcess startGetStoreWithRefreshing:NO];
}
- (void)reloadMoreDataOfRefreshing
{
    [downloadProcess startGetStoreWithRefreshing:YES];
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
