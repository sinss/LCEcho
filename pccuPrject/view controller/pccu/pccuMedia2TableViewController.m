//
//  pccuMedia2TableViewController.m
//  pccuPrject
//
//  Created by sinss on 12/11/11.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "pccuMedia2TableViewController.h"
#import "ODRefreshControl.h"
#import "pccuMediaOtherViewController.h"

#define kCustomRowHeight  60.0
#define kCustomRowCount   9
#define kAppIconHeight    48
#define kAppIconWidth    64

@interface pccuMedia2TableViewController ()

- (void)reloadMediaData;
- (void)reloadMediaDataOfRefreshing;

@end

@implementation pccuMedia2TableViewController
@synthesize pccuMediaType;

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
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"news_bg.png"]];
    [self.tableView setBackgroundView:bgView];
    [bgView release];
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
    if (downloadMedia == nil)
    {
        NSString *tabUrl1 = nil;
        switch (pccuMediaType)
        {
            case 1:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuMedia1];
                break;
            case 2:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuMedia2];
                break;
            case 3:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuMedia3];
                break;
            case 4:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuMedia4];
                break;
            case 5:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuMedia5];
                break;
            case 6:
                tabUrl1 = [[appConfigRecord appConfigInstance] pccuMedia7];
                break;
        }
        if (tabUrl1 != nil)
        {
            downloadMedia = [[downloadStoreDelegate alloc] initWithURL:tabUrl1];
            downloadMedia.currLocation = [[appConfigRecord appConfigInstance] currentLocation];
            downloadMedia.csvLoadtype = csvLoadTypePccuOther;
            downloadMedia.pccuMediaType = pccuMediaType;
            [downloadMedia setDelegate:self];
        }
    }
    lazyImages.tableView = self.tableView;
	self.tableView.rowHeight = kCustomRowHeight;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.labelText = @"資料讀取中...";
    [HUD showWhileExecuting:@selector(reloadMediaData) onTarget:self withObject:nil animated:YES];
}

- (void)dealloc
{
    [pccuMediaArray release], pccuMediaArray = nil;
    [downloadMedia release], downloadMedia = nil;
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
    return [pccuMediaArray count];
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
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [cell.textLabel setShadowColor:[UIColor lightGrayColor]];
        [cell.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        [cell.detailTextLabel setShadowColor:[UIColor lightGrayColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    pccuMediaOther *record = [pccuMediaArray objectAtIndex:row];
    [lazyImages addLazyImageForCell:cell withIndexPath:indexPath];
    
	cell.textLabel.text = record.mTitle;
    
    //NSString *distanceString = [NSString stringWithFormat:@"%@ / %@",[globalFunction formatDistance:store.Distance],store.StoreNews];
    
    [cell.detailTextLabel setText:record.mSubTitle];
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
    NSUInteger row = [indexPath row];
    pccuMediaOther *record = [pccuMediaArray objectAtIndex:row];
    pccuMediaOtherViewController *pccuDetailView = [[pccuMediaOtherViewController alloc] initWithNibName:@"pccuMediaOtherViewController" bundle:nil];
    [pccuDetailView setCurrentMediaRecord:record];
    [self.navigationController pushViewController:pccuDetailView animated:YES];
    [pccuDetailView release];
}

#pragma mark - ODRefreshControl refresh function
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 1.5f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       [self reloadMediaDataOfRefreshing];
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
    
	pccuMediaOther *record = [pccuMediaArray objectAtIndex:indexPath.row];
    //NSLog(@"url:%@",tblA.aImageUrl);
	return [NSURL URLWithString:record.mImageUrl];
}


#pragma mark download delegate

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFaildDownloadWithError:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
}

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFinishDownloadWithData:(NSArray *)newsArray
{
    pccuMediaArray = [[NSArray alloc] initWithArray:newsArray];
    //NSLog(@"%@",storeArray);
    [self.tableView reloadData];
}


- (void)reloadMediaData
{
    [downloadMedia startGetStoreWithRefreshing:NO];
}
- (void)reloadMediaDataOfRefreshing
{
    [downloadMedia startGetStoreWithRefreshing:YES];
}

@end
