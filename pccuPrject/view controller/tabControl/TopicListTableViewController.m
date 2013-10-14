//
//  TopicListTableViewController.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import "TopicListTableViewController.h"
#import "topicDetailViewController.h"
#import "customTopicCell.h"
#import "slyCoolA.h"

#define kCustomRowHeight  60.0
#define kCustomRowCount   9
#define kAppIconHeight    48
#define kAppIconWidth    64

@interface TopicListTableViewController ()

- (void)reloadTopicData;
- (void)reloadTopicDataOfRefreshing;
- (void)crateBarButton;
- (void)closeItemPress;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end

@implementation TopicListTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
        lazyImages = [[MHLazyTableImages alloc] init];
		lazyImages.placeholderImage = [UIImage imageNamed:@"loading"];
		lazyImages.delegate = self;
        self.title = NSLocalizedString(@"主題好康", @"消息發佈");
        self.tabBarItem.image = [UIImage imageNamed:tab2Image];
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
    [self crateBarButton];
    if (downloadProcess == nil)
    {
        NSString *topicUrl = [[appConfigRecord appConfigInstance] tabURL2];
        if (topicUrl != nil)
        {
            downloadProcess = [[downloadStoreDelegate alloc] initWithURL:topicUrl];
            downloadProcess.csvLoadtype = csvLoadtypeTopic;
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
    
    lazyImages.tableView = self.tableView;
	self.tableView.rowHeight = kCustomRowHeight;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.labelText = @"載入中...";
    [HUD showWhileExecuting:@selector(reloadTopicData) onTarget:self withObject:nil animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    lazyImages.delegate = nil;
    [topicArray release], topicArray = nil;
    [downloadProcess release], downloadProcess = nil;
	[lazyImages release], lazyImages = nil;
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
    return [topicArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *topicCellIdentifier = @"topicCellIdentifier";
    NSUInteger row = [indexPath row];
/*
    customTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customTopicCell" owner:self options:nil];
        for (id currentObj in topLevelObjects)
        {
            if ([currentObj isKindOfClass:[customTopicCell class]])
            {
                cell = currentObj;
                break;
            }
        }
        if (row % 2 == 1)
        {
            UIView *cellView = [[UIView alloc] init];
            [cellView setBackgroundColor:oddCellBackgroundColor];
            [cell setBackgroundView:cellView];
            [cellView release];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    slyCoolA *topic = [topicArray objectAtIndex:row];
    [cell.titleLabel setText:topic.ATitle];
    [cell.subTitleLabel setText:topic.ASubTitle];
    NSURL *url =[NSURL URLWithString:topic.APicA];
    [cell initImageViewWithUrl:url andImageName:[NSString stringWithFormat:@"topic_%@_%i",[globalFunction getTodayString],row]];
     */

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:topicCellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:topicCellIdentifier] autorelease];
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
    
    slyCoolA *topic = [topicArray objectAtIndex:row];
    [lazyImages addLazyImageForCell:cell withIndexPath:indexPath];
	cell.textLabel.text = topic.ATitle;
    cell.detailTextLabel.text = topic.ASubTitle;

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
    slyCoolA *topicItem = [topicArray objectAtIndex:[indexPath row]];
    topicDetailViewController *topicDetail = [[topicDetailViewController alloc] initWithStyle:UITableViewStylePlain];
    [topicDetail setCurrentTopic:topicItem];
    [self.navigationController pushViewController:topicDetail animated:YES];
    [topicDetail release];
}

#pragma mark - reload table view data

- (void)reloadTableViewDataSource{
    _reloading = YES;
    [self reloadTopicDataOfRefreshing];
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
	[lazyImages scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
	[lazyImages scrollViewDidEndDecelerating:scrollView];
}

#pragma mark -
#pragma mark MHLazyTableImagesDelegate

- (NSURL*)lazyImageURLForIndexPath:(NSIndexPath*)indexPath
{
    
	slyCoolA *topic = [topicArray objectAtIndex:indexPath.row];
    
	return [NSURL URLWithString:topic.APicA];
}

- (UIImage*)postProcessLazyImage:(UIImage*)image forIndexPath:(NSIndexPath*)indexPath
{
    if (image.size.width != kAppIconHeight && image.size.height != kAppIconHeight)
	{
        CGSize itemSize = CGSizeMake(kAppIconWidth, kAppIconHeight);
		UIGraphicsBeginImageContextWithOptions(itemSize, YES, 0);
		CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
		[image drawInRect:imageRect];
		UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		return newImage;
    }
    else
    {
        return image;
    }
}

#pragma mark - download process

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFaildDownloadWithError:(NSString *)errorMessage
{
    
}
- (void)downloadDelegate:(downloadStoreDelegate *)obj didFinishDownloadWithData:(NSArray *)array
{
    topicArray = [[NSArray alloc] initWithArray:array];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - 其它函式
- (void)reloadTopicData
{
    [downloadProcess startGetStoreWithRefreshing:NO];
}
- (void)reloadTopicDataOfRefreshing
{
    [downloadProcess startGetStoreWithRefreshing:YES];
}

- (void)crateBarButton
{
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:mainPageItemName style:UIBarButtonItemStylePlain target:self action:@selector(closeItemPress)];
    self.navigationItem.rightBarButtonItem = closeItem;
}
- (void)closeItemPress
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
