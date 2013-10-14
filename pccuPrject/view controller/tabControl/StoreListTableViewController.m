//
//  StoreListTableViewController.m
//  SlyCoolForEst
//
//  Created by sinss on 12/7/30.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import "StoreListTableViewController.h"
#import "slMapViewController.h"
#import "StoreTemp.h"
#import "globalFunction.h"
#import "StoreDetailTableViewController.h"
#import "customTopicCell.h"
#import "shareHeaderView.h"
#import "infoPanel.h"

#define kCustomRowHeight  60.0
#define kCustomRowCount   9
#define kAppIconHeight    48
#define kAppIconWidth    64

@interface StoreListTableViewController ()

- (void)reloadStoreData;
- (void)reloadStoreDataOfRefreshing;
- (void)crateBarButton;
- (void)showMapView;
- (void)showCategoryView;

@end

@implementation StoreListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        lazyImages = [[MHLazyTableImages alloc] init];
		lazyImages.placeholderImage = [UIImage imageNamed:@"loading"];
		lazyImages.delegate = self;
        self.title = NSLocalizedString(@"士林好康", @"商店列表");
        self.tabBarItem.image = [UIImage imageNamed:tab1Image];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tableView_bg]];
    [self.tableView setBackgroundView:bgView];
    [bgView release];
    /*
     隔線刪除
     */
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    if (currentPredicateStr == nil)
    {
        currentPredicateStr = [[NSString alloc] initWithFormat:@"1=1"];
    }
    if (currentPredicateDistance == nil)
    {
        currentPredicateDistance = [[NSString alloc] initWithFormat:@"1=1"];
    }
    [self crateBarButton];
    if (downloadStore == nil)
    {
        NSString *tabUrl1 = [[appConfigRecord appConfigInstance] tabURL1];
        if (tabUrl1 != nil)
        {
            downloadStore = [[downloadStoreDelegate alloc] initWithURL:tabUrl1];
            downloadStore.currLocation = [[appConfigRecord appConfigInstance] currentLocation];
            downloadStore.csvLoadtype = csvLoadtypeStore;
            [downloadStore setDelegate:self];
        }
    }
    if (storeArray == nil)
    {
        //[self reloadStoreData];
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
    HUD.labelText = @"資料讀取中...";
    [HUD showWhileExecuting:@selector(reloadStoreData) onTarget:self withObject:nil animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    [storeArray release], storeArray = nil;
    [predictStoreArray release], predictStoreArray = nil;
    [currentPredicateStr release], currentPredicateStr = nil;
    [currentPredicateDistance release], currentPredicateDistance = nil;
    [downloadStore release], downloadStore = nil;
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [predictStoreArray count];
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
    NSString *currAddress = [[appConfigRecord appConfigInstance] currentAddress];
    if([currAddress length] > 0)
        [headerView.titleLabel setText:currAddress];
    else
        [headerView.titleLabel setText:@"偵測不到目前所在位置...."];
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
    
    StoreTemp *store = [predictStoreArray objectAtIndex:row];
    [lazyImages addLazyImageForCell:cell withIndexPath:indexPath];
    
	cell.textLabel.text = store.StoreName;
    
    NSString *distanceString = [NSString stringWithFormat:@"%@ / %@",[globalFunction formatDistance:store.Distance],store.StoreNews];
    
    cell.detailTextLabel.text = distanceString ;
    
    /*
    NSString *bundle =  [[NSBundle mainBundle] pathForResource:store.StoreType ofType:@"png"] ;
    UIImage *image = [UIImage imageWithContentsOfFile: bundle];
    UIButton *myEngButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myEngButton setFrame:CGRectMake(280, 5, 24, 24)];
    [myEngButton setImage:image forState:UIControlStateNormal];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = myEngButton;
     */
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
    StoreDetailTableViewController *detailViewController = [[StoreDetailTableViewController alloc] initWithStyle:UITableViewStylePlain];;
    StoreTemp *store = [predictStoreArray objectAtIndex:[indexPath row]];
    [detailViewController setCurrentStore:store];
    [detailViewController setCurrAddress:[[appConfigRecord appConfigInstance] currentAddress]];
    [detailViewController setCurrLocation:[[appConfigRecord appConfigInstance] currentLocation]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
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

	StoreTemp *tblA = [predictStoreArray objectAtIndex:indexPath.row];
    
	return [NSURL URLWithString:tblA.PicB];
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
    storeArray = [[NSArray alloc] initWithArray:stores];
    NSString *precStr = [NSString stringWithFormat:@"%@ AND %@",currentPredicateDistance, currentPredicateStr];
    NSPredicate *prec = [NSPredicate predicateWithFormat:precStr];
    predictStoreArray = [[NSArray alloc] initWithArray:[storeArray filteredArrayUsingPredicate:prec]];
    //NSLog(@"%@",storeArray);
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - typeSelect delegate
- (void)storeTypeView:(StoreTypeSelectViewController *)view didSelectWithPredict:(NSString*)predictate
{
    currentPredicateStr = [[NSString alloc] initWithFormat:@"%@",predictate];
    NSString *precStr = [NSString stringWithFormat:@"%@ AND %@",currentPredicateDistance, currentPredicateStr];
    NSPredicate *prec = [NSPredicate predicateWithFormat:precStr];
    predictStoreArray = [[NSArray alloc] initWithArray:[storeArray filteredArrayUsingPredicate:prec]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - distance select delegate

- (void)distanceView:(DistanceSelectViewController *)view didSelectDistanceWithPredict:(NSString *)predicateStr
{
    currentPredicateDistance = [[NSString alloc] initWithFormat:@"%@", predicateStr];
    NSString *precStr = [NSString stringWithFormat:@"%@ AND %@",currentPredicateDistance, currentPredicateStr];
    NSPredicate *prec = [NSPredicate predicateWithFormat:precStr];
    predictStoreArray = [[NSArray alloc] initWithArray:[storeArray filteredArrayUsingPredicate:prec]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - user define function

- (void)reloadStoreData
{
    [downloadStore startGetStoreWithRefreshing:NO];
}
- (void)reloadStoreDataOfRefreshing
{
    [downloadStore startGetStoreWithRefreshing:YES];
}

- (void)crateBarButton
{
    UIBarButtonItem *mapItem  = [[UIBarButtonItem alloc] initWithTitle:@"士林大地圖" style:UIBarButtonItemStylePlain target:self action:@selector(showMapView)];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"關閉" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemPress)];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:mapItem, nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:closeItem, nil];
    [mapItem release];
    [closeItem release];
}

- (void)showMapView
{
    slMapViewController *mapView = [[slMapViewController alloc] initWithNibName:@"slMapViewController" bundle:nil];
    mapView.currLocation = [[appConfigRecord appConfigInstance] currentLocation];
    mapView.currAddress = [[appConfigRecord appConfigInstance] currentAddress];
    mapView.storeArray = predictStoreArray;
    
    //[mapView viewWillAppear:YES];
	mapView.title = @"士林大地圖";
    [self.navigationController pushViewController:mapView animated:YES];
    [mapView release];
}

- (void)closeItemPress
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)showCategoryView
{
    StoreTypeSelectViewController *typeView = [[StoreTypeSelectViewController alloc] initWithNibName:@"StoreTypeSelectViewController" bundle:nil];
    [typeView setDelegate:self];
    [typeView setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [self presentViewController:typeView animated:YES completion:nil];
    [typeView release];
}
- (void) showDistance
{
    DistanceSelectViewController *distanceView = [[DistanceSelectViewController alloc] initWithNibName:@"DistanceSelectViewController" bundle:nil];
    [distanceView setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [distanceView setDelegate:self];
    [self presentViewController:distanceView animated:YES completion:nil];
    [distanceView release];
}

@end
