//
//  movieTableViewController.m
//  SlyCool001
//
//  Created by sinss on 12/10/6.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import "movieTableViewController.h"
#import "shareHeaderView.h"
#import "shareFooterView.h"
#import "activityRecord.h"
#import "carnivalDetailTableViewController.h"
#import "MoreContentViewController.h"

#define kCustomRowHeight  60.0
#define kCustomRowCount   9
#define kAppIconHeight    48
#define kAppIconWidth    64

@interface movieTableViewController ()

- (void)reloadStoreData;
- (void)reloadStoreDataOfRefreshing;
- (void)createBarButton;
- (void)closeItemPress;

@end

@implementation movieTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        lazyImages = [[MHLazyTableImages alloc] init];
		lazyImages.placeholderImage = [UIImage imageNamed:@"loading"];
		lazyImages.delegate = self;
        self.title = NSLocalizedString(@"", @"");
        self.tabBarItem.image = [UIImage imageNamed:tab2Image];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
     隔線刪除
     */
    if (downloadMovie == nil)
    {
        NSString *tabUrl = [[appConfigRecord appConfigInstance] tabURL4];
        if (tabUrl != nil)
        {
            downloadMovie = [[downloadStoreDelegate alloc] initWithURL:tabUrl];
            downloadMovie.currLocation = [[appConfigRecord appConfigInstance] currentLocation];
            downloadMovie.csvLoadtype = csvLoadTypeMovie;
            [downloadMovie setDelegate:self];
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
    
    lazyImages.tableView = self.tableView;
	self.tableView.rowHeight = kCustomRowHeight;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.labelText = @"資料讀取中...";
    [HUD showWhileExecuting:@selector(reloadStoreData) onTarget:self withObject:nil animated:YES];
}

- (void)dealloc
{
    lazyImages.delegate = nil;
    [movieArray release], movieArray = nil;
    [downloadMovie release], downloadMovie = nil;
	[lazyImages release], lazyImages = nil;
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
    return [movieArray count];
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
    [headerView.titleLabel setText:@"◎ 本次所有抽獎、比賽、活動皆與蘋果公司無關。"];
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *storeCellIdentifier = @"storeCellIdentifier";
    NSUInteger row = [indexPath row];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:storeCellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:storeCellIdentifier] autorelease];
        
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
    
    movieRecord *movie = [movieArray objectAtIndex:row];
    [lazyImages addLazyImageForCell:cell withIndexPath:indexPath];
    
	cell.textLabel.text = movie.mTitle;
    
    //NSString *distanceString = [NSString stringWithFormat:@"%@ / %@",[globalFunction formatDistance:store.Distance],store.StoreNews];
    
    cell.detailTextLabel.text = movie.mDirector;
    
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
    movieRecord *movie = [movieArray objectAtIndex:[indexPath row]];
    if ([movie.mID isEqualToString:@"m0"])
    {
        NSURL *url = [NSURL URLWithString:movie.mOtherUrl];
        if (url != nil)
        {
            MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
            [moreContentView setCurrentUrl:url];
            [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:moreContentView animated:YES completion:nil];
            [moreContentView release];
        }
    }
    else
    {
        carnivalDetailTableViewController *detailView = [[[carnivalDetailTableViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        [detailView setDetailType:carnivalDetailTypeMovie];
        [detailView setCurrentMovie:movie];
        [self.navigationController pushViewController:detailView animated:YES];

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
	movieRecord *movie = [movieArray objectAtIndex:indexPath.row];
    //NSLog(@"url:%@",tblA.aImageUrl);
	return [NSURL URLWithString:movie.mImageUrl];
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



#pragma mark download delegate

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFaildDownloadWithError:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
}

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFinishDownloadWithData:(NSArray *)stores
{
    movieArray = [[NSArray alloc] initWithArray:stores];
    //NSLog(@"%@",storeArray);
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)reloadStoreData
{
    [downloadMovie startGetStoreWithRefreshing:NO];
}
- (void)reloadStoreDataOfRefreshing
{
    [downloadMovie startGetStoreWithRefreshing:YES];
}

- (void)createBarButton
{
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"關閉" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemPress)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:closeItem, nil];
    [closeItem release];
}

- (void)closeItemPress
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
