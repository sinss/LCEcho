//
//  pccuNewsTableViewController.m
//  pccuPrject
//
//  Created by sinss on 12/10/21.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "pccuNewsTableViewController.h"
#import "shareHeaderView.h"
#import "shareFooterView.h"
#import "appConfigRecord.h"
#import "ODRefreshControl.h"
#import "pccuNewsDetailViewController.h"

#define kCustomRowHeight  60.0
#define kCustomRowCount   9
#define kAppIconHeight    48
#define kAppIconWidth    64

@interface pccuNewsTableViewController ()

- (void)reloadNewsData;
- (void)reloadStoreDataOfRefreshing;

@end

@implementation pccuNewsTableViewController
@synthesize typeOfPccuNews;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        lazyImages = [[MHLazyTableImages alloc] init];
		lazyImages.placeholderImage = [UIImage imageNamed:@"loading.png"];
		lazyImages.delegate = self;
        self.title = NSLocalizedString(@"", @"");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if (typeOfPccuNews != pccuNewsType8)
    {
        [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"student.png"]];
        [self.tableView setBackgroundView:bgView];
        [bgView release];
    }
    else
    {
        [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"news_bg.png"]];
        [self.tableView setBackgroundView:bgView];
        [bgView release];
    }
    
    if (downloadPccuNews == nil)
    {
        NSString *tabUrl1 = nil;
        switch (typeOfPccuNews)
        {
            case pccuNewsType1:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuNews1];
                break;
            case pccuNewsType2:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuNews2];
                break;
            case pccuNewsType3:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuNews3];
                break;
            case pccuNewsType4:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuNews4];
                break;
            case pccuNewsType5:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuNews5];
                break;
            case pccuNewsType6:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuNews6];
                break;
            case pccuNewsType7:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuMedia6];
                break;
            case pccuNewsType8:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuMedia6];
                break;
                break;
        }
        if (tabUrl1 != nil)
        {
            downloadPccuNews = [[downloadStoreDelegate alloc] initWithURL:tabUrl1];
            downloadPccuNews.currLocation = [[appConfigRecord appConfigInstance] currentLocation];
            downloadPccuNews.csvLoadtype = csvLoadTypePccuNews;
            downloadPccuNews.typeOfPccuNews = typeOfPccuNews;
            [downloadPccuNews setDelegate:self];
        }
    }
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
    lazyImages.tableView = self.tableView;
	self.tableView.rowHeight = kCustomRowHeight;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.labelText = @"資料讀取中...";
    [HUD showWhileExecuting:@selector(reloadNewsData) onTarget:self withObject:nil animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"height:%f", self.view.frame.origin.y);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    lazyImages.delegate = nil;
    [pccuNewsArray release], pccuNewsArray = nil;
    [downloadPccuNews release], downloadPccuNews = nil;
	[lazyImages release], lazyImages = nil;
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pccuNewsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *pccuNewsCellIdentifier = @"pccuNewsCellIdentifier";
    NSUInteger row = [indexPath row];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:pccuNewsCellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:pccuNewsCellIdentifier] autorelease];
        
        if (row % 2 == 1)
        {
            UIView *cellView = [[UIView alloc] init];
            [cellView setBackgroundColor:oddCellBackgroundColor];
            [cell setBackgroundView:cellView];
            [cellView release];
        }
        [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setBackgroundColor:[UIColor lightGrayColor]];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [cell.textLabel setShadowColor:[UIColor whiteColor]];
        [cell.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        [cell.detailTextLabel setShadowColor:[UIColor lightGrayColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    pccuNewsRecord *news = [pccuNewsArray objectAtIndex:row];
    [lazyImages addLazyImageForCell:cell withIndexPath:indexPath];
    
	cell.textLabel.text = news.nTitle;
    
    //NSString *distanceString = [NSString stringWithFormat:@"%@ / %@",[globalFunction formatDistance:store.Distance],store.StoreNews];
    
    [cell.detailTextLabel setText:news.nSubTitle];
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
    pccuNewsRecord *record = [pccuNewsArray objectAtIndex:[indexPath row]];
    pccuNewsDetailViewController *pccuNewsDetailView = [[pccuNewsDetailViewController alloc] initWithNibName:@"pccuNewsDetailViewController" bundle:nil];
    [pccuNewsDetailView setCurrentPccuRecord:record];
    [self.navigationController pushViewController:pccuNewsDetailView animated:YES];
    [pccuNewsDetailView release];
}

#pragma mark - ODRefreshControl refresh function
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 1.5f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       [self reloadStoreDataOfRefreshing];
                       [refreshControl endRefreshing];
                   });
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
	[lazyImages scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
	[lazyImages scrollViewDidEndDecelerating:scrollView];
}

#pragma mark -
#pragma mark MHLazyTableImagesDelegate

- (NSURL*)lazyImageURLForIndexPath:(NSIndexPath*)indexPath
{
    
	pccuNewsRecord *tblA = [pccuNewsArray objectAtIndex:indexPath.row];
    //NSLog(@"url:%@",tblA.aImageUrl);
	return [NSURL URLWithString:tblA.nImageUrl];
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

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFinishDownloadWithData:(NSArray *)newsArray
{
    pccuNewsArray = [[NSArray alloc] initWithArray:newsArray];
    //NSLog(@"%@",storeArray);
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self.tableView insertSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadData];
}


- (void)reloadNewsData
{
    [downloadPccuNews startGetStoreWithRefreshing:NO];
}
- (void)reloadStoreDataOfRefreshing
{
    [downloadPccuNews startGetStoreWithRefreshing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"size:%f, scroll:%f", scrollView.contentSize.height, scrollView.contentOffset.y);
}
@end
