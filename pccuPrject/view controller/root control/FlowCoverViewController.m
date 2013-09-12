//
//  FlowCoverViewController.m
//  FlowCover
//
//  Created by William Woody on 12/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "FlowCoverViewController.h"
#import "StoreListTableViewController.h"
#import "TopicListTableViewController.h"
#import "SylinCardTableViewController.h"
#import "sylinCoinViewController.h"
#import "BrandListTableViewController.h"
#import "moreTableViewController.h"
#import "bannerContentTableViewController.h"



@interface FlowCoverViewController()

- (void)tappedWithFlowCoverIndex:(NSUInteger)index;
- (void)loadAdImageView;
- (void)loadAdDataImageView;
- (void)setTimer;
- (void)timerTick;

- (void)reloadAdData;

@end

@implementation FlowCoverViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [adScrollView setDelegate:self];
    if (downloadProcess == nil)
    {
        NSString *adUrl = [[appConfigRecord appConfigInstance] adUrl];
        if (adUrl != nil)
        {
            downloadProcess = [[downloadStoreDelegate alloc] initWithURL:adUrl];
            [downloadProcess setDelegate:self];
            [downloadProcess setCsvLoadtype:csvloadtypeAdUrl];
            [downloadProcess startGetStoreWithRefreshing:YES];
        }
    }
    [self setTimer];
    //[self loadAdImageView];
}

- (void)viewDidAppear:(BOOL)animated
{
    //[RevMobAds showBannerAdWithDelegate:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc 
{
    [downloadProcess release], downloadProcess = nil;
    [adScrollView release], adScrollView = nil;
    [adPageControl release], adPageControl = nil;
    [adDataArray release], adDataArray = nil;
    [super dealloc];
}


- (IBAction)done:(id)sender
{
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = adScrollView.frame.size.width;
    int page = floor((adScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    adPageControl.currentPage = page;
    
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

#pragma mark - downlaod process delegate
- (void)downloadDelegate:(downloadStoreDelegate *)obj didFaildDownloadWithError:(NSString *)errorMessage
{
    adDataArray = [[NSArray alloc] init];
}

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFinishDownloadWithData:(NSArray *)array
{
    adDataArray = [[NSArray alloc] initWithArray:array];
    [self loadAdDataImageView];
}

#pragma mark flowCover Control
/************************************************************************/
/*																		*/
/*	FlowCover Callbacks													*/
/*																		*/
/************************************************************************/

- (int)flowCoverNumberImages:(FlowCoverView *)view
{
	return 5;
}

- (UIImage *)flowCover:(FlowCoverView *)view cover:(int)image
{
	switch (image % 6) {
		case 0:
		default:
			return [UIImage imageNamed:cover1Image];
		case 1:
			return [UIImage imageNamed:cover2Image];
		case 2:
			return [UIImage imageNamed:cover3Image];
		case 3:
			return [UIImage imageNamed:cover4Image];
		case 4:
			return [UIImage imageNamed:cover5Image];
		case 5:
			return [UIImage imageNamed:@"xx.png"];
	}
}

- (void)flowCover:(FlowCoverView *)view didSelect:(int)image
{
	NSLog(@"Selected Index %d",image);
    [self tappedWithFlowCoverIndex:image];
}


- (void)tappedWithFlowCoverIndex:(NSUInteger)index
{
    StoreListTableViewController *storeList = [[StoreListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    TopicListTableViewController *topicView = [[TopicListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    brandListTableViewController *brandView = [[brandListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    sylinCoinViewController *sylinCoinView = [[sylinCoinViewController alloc] initWithStyle:UITableViewStylePlain];
    sylinCardTableViewController *sylinView = [[sylinCardTableViewController alloc] initWithStyle:UITableViewStylePlain];
    moreTableViewController *moreView = [[moreTableViewController alloc] initWithStyle:UITableViewStylePlain];

    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:storeList];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:topicView];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:sylinView];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:sylinCoinView];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:moreView];
    
    UITabBarController *tabControl = [[UITabBarController alloc] init];
    
    tabControl.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nav5, nil];
    tabControl.selectedIndex = index;
    
    storeList.title = [[appConfigRecord appConfigInstance] tabTitle1];
    topicView.title = [[appConfigRecord appConfigInstance] tabTitle2];
    sylinView.title = [[appConfigRecord appConfigInstance] tabTitle3];
    sylinCoinView.title = [[appConfigRecord appConfigInstance] tabTitle4];
    //brandView.title = [[appConfigRecord appConfigInstance] tabTitle5];
    moreView.title = [[appConfigRecord appConfigInstance] tabTitle5];
    
    [tabControl setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:tabControl animated:YES];
    [storeList release];
    [topicView release];
    [sylinCoinView release];
    [brandView release];
    [sylinView release];
    [moreView release];
    [nav1 release];
    [nav2 release];
    [nav3 release];
    [nav4 release];
    [nav5 release];
    /*
    UITabBarItem *tabBar01 = [[UITabBarItem alloc] initWithTitle:@"士林好康" image:[UIImage imageNamed:@"Item01.png"] tag:0] ;
    UITabBarItem *tabBar02 = [[UITabBarItem alloc] initWithTitle:@"主題好康" image:[UIImage imageNamed:@"Item02.png"] tag:1];
    UITabBarItem *tabBar03 = [[UITabBarItem alloc] initWithTitle:@"我的士林卡" image:[UIImage imageNamed:@"Item03.png"] tag:2];
    UITabBarItem *tabBar04 = [[UITabBarItem alloc] initWithTitle:@"聯名品牌" image:[UIImage imageNamed:@"Item04.png"] tag:3];
    UITabBarItem *tabBar05 = [[UITabBarItem alloc] initWithTitle:@"更多..." image:[UIImage imageNamed:@"Item05.png"] tag:4];
    sylc001.tabBarItem = tabBar01;
    sylc002.tabBarItem = tabBar02;
    sylc003.tabBarItem = tabBar03;
    sylc004.tabBarItem = tabBar04;
    sylc005.tabBarItem = tabBar05;
    
    tabViewController = [[UITabBarController alloc] init];
    tabViewController.viewControllers = [NSArray arrayWithObjects:sylc001,sylc002,sylc003, sylc004,sylc005,nil];
     */
    
    
}

- (void)loadAdDataImageView
{
    float startX = adImageViewStartX;
    float startY = adImageViewStartY;
    adScrollView.contentSize = CGSizeMake(320*[adDataArray count], adScrollView.bounds.size.height);
    for (int i = 0 ; i < [adDataArray count] ; i ++)
    {
        CGRect rect = CGRectMake(startX, startY, adImageViewWidth, adImageViewHeight);
        adRecord *adInfo = [adDataArray objectAtIndex:i];
        customImgaeView *adImageView = [[customImgaeView alloc] initWithFrame:rect andImageName:[NSString stringWithFormat:@"%@",adInfo.adNo] andSmallInd:NO];
        adImageView.tag = i;
        [adImageView setDelegate:self];
        [adImageView downloadAndDisplayImageWithURL:[NSURL URLWithString:adInfo.adImageUrl]];
        [adScrollView addSubview:adImageView];
        startX += 320;
        [adImageView release];
    }
    [adPageControl setNumberOfPages:[adDataArray count]];
}

- (void)loadAdImageView
{
    float startX = adImageViewStartX;
    float startY = adImageViewStartY;
    adScrollView.contentSize = CGSizeMake(320*6, adScrollView.bounds.size.height);
    for (int i = 0 ; i < 6 ; i ++)
    {
        UIImage *img = nil;
        if (i == 0)
        {
            img = [UIImage imageNamed:@"a.png"];
        }
        else if (i == 1)
        {
            img = [UIImage imageNamed:@"b.png"];
        }
        else if (i == 2)
        {
            img = [UIImage imageNamed:@"c.png"];
        }
        else if (i == 3)
        {
            img = [UIImage imageNamed:@"x.png"];
        }
        else if (i == 4)
        {
            img = [UIImage imageNamed:@"y.png"];
        }
        else if (i == 5)
        {
            img = [UIImage imageNamed:@"z.png"];
        }
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
        CGRect rect = CGRectMake(startX, startY, adImageViewWidth, adImageViewHeight);
        [imgView setFrame:rect];
        [adScrollView addSubview:imgView];
        startX += 320;
        [imgView release];
    }
    [adPageControl setNumberOfPages:6];
}

- (void)setTimer
{
    NSTimer *timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval: 5
                                             target: self
                                           selector: @selector(timerTick)
                                           userInfo: nil
                                            repeats: YES];
}

- (void)removeTimer
{
    NSTimer *timer = nil;
    timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
    timer = nil;
    
}

- (void)timerTick
{
    NSUInteger page = adPageControl.currentPage;
    if (page >= [adDataArray count] - 1)
    {
        page = -1;
    }
    page ++;
    [adScrollView setContentOffset:CGPointMake((320 * page), 0) animated:YES];
    [adPageControl setCurrentPage:page];
}


- (void)reloadAdData
{
    [downloadProcess startGetStoreWithRefreshing:NO];
}

#pragma mark custom image delegate
- (void)didPressButtonWithTag:(NSInteger)imageTag
{
    bannerContentTableViewController *bannerView = [[bannerContentTableViewController alloc] initWithStyle:UITableViewStylePlain];
    bannerView.currentAdRecord = [adDataArray objectAtIndex:imageTag];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bannerView];
    [nav setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:nav animated:YES];
    [bannerView release];
}
- (void)didPressButtonWithImage:(UIImage *)image
{
    
}

@end
