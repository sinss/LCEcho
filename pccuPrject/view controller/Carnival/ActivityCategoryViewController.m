//
//  ActivityCategoryViewController.m
//  SlyCool001
//
//  Created by sinss on 12/9/22.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import "ActivityCategoryViewController.h"
#import "activityTableViewController.h"

@interface ActivityCategoryViewController ()

@end

@implementation ActivityCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"活動總表", @"活動總表");
        self.tabBarItem.image = [UIImage imageNamed:tab1Image];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (categoryArray == nil)
    {
        /*
         防竊宣導 A區
         反詐騙宣導 B區
         少年警察隊宣導 C區
         婦幼警察隊宣導 D區
         交通警察大隊宣導 E區
         防制毒品宣導 F區
         */
        categoryArray = [[NSArray alloc] initWithObjects:
                         @"縣府宣導攤位",
                         @"六大主題區",
                         @"互動攤位",
                         @"美食攤位",
                         @"公益攤位",
                         @"展示攤位",
                         @"充氣遊戲",
                         @"主舞台",
                         @"副舞台",nil];
    }
    if (categoryNameArray == nil)
    {
        categoryNameArray = [[NSArray alloc] initWithObjects:
                             @"縣府宣導攤位",
                             @"六大主題",
                             @"互動攤位",
                             @"美食攤位",
                             @"公益攤位",
                             @"展示攤位",
                             @"充氣遊戲",
                             @"主舞台",
                             @"副舞台",nil];
    }
    /*
     調整scrollView的大小
     */
    UIImage *image = [UIImage imageNamed:@"carvinalMap.png"];
    [imageView setFrame:CGRectMake(0, 0, 640, 367)];
    [scrollView setContentSize:CGSizeMake(640, 367)];
    [image release];
    
    scrollView.maximumZoomScale = 2;
    scrollView.minimumZoomScale = 1;
    scrollView.delegate = self;
    scrollView.zoomScale = 1.0;
}

- (void)dealloc
{
    [scrollView release], scrollView = nil;
    [imageView release], imageView = nil;
    [categoryArray release], categoryArray = nil;
    [categoryNameArray release], categoryNameArray = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - user define function

- (IBAction)categoryButtonPress:(UIButton *)sender
{
    NSInteger tag = [sender tag];
    activityTableViewController *activityListView = [[activityTableViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:activityListView];
    [nav setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [activityListView setActivityType:[categoryArray objectAtIndex:tag]];
    [activityListView setTitle:[categoryNameArray objectAtIndex:tag]];
    [self presentViewController:nav animated:YES completion:nil];
    [nav release];
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)inScroll
{
    return imageView;
}


@end
