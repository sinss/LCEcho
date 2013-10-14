//
//  pccuMediaDetailViewController.m
//  pccuPrject
//
//  Created by sinss on 12/11/15.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "pccuMediaDetailViewController.h"
#import "pccuMediaRecord.h"
#import "MoreContentViewController.h"

@interface pccuMediaDetailViewController ()

- (void)resetMediaContent;

@end

@implementation pccuMediaDetailViewController
@synthesize pccuMediaType, currentMediaRecord;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [self resetMediaContent];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (IS_IPHONE_5)
    {
        /*
        CGRect frame = self.view.bounds;
        CGFloat height = 44.f;
        CGFloat width = 320.f;
        
        [contentTextView setFrame:CGRectMake(contentTextView.frame.origin.x,
                                              contentTextView.frame.origin.y,
                                              contentTextView.frame.size.width,
                                              contentTextView.frame.size.height - 20)];
        [bannerImageView setFrame:CGRectMake(0,
                                             frame.size.height - height,
                                             width,
                                             height)];
         */
    }
}

- (void)dealloc
{
    [currentMediaRecord release], currentMediaRecord = nil;
    [titleLabel release], titleLabel = nil;
    [subTitleLabel release], subTitleLabel = nil;
    [movieButton release], movieButton = nil;
    [broadcastButton release], broadcastButton = nil;
    [contentTextView release], contentTextView = nil;
    [bannerImageView release], bannerImageView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetMediaContent
{
    [titleLabel setText:currentMediaRecord.mTitle2];
    [subTitleLabel setText:currentMediaRecord.mSubTitle2];
    if (pccuMediaType == 2)
    {
        [movieButton setHidden:YES];
        [broadcastButton setHidden:NO];
    }
    else if (pccuMediaType == 3)
    {
        [movieButton setHidden:NO];
        [broadcastButton setHidden:YES];
    }
    [contentTextView setText:currentMediaRecord.mContent];
    int64_t delayInSeconds = 0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:currentMediaRecord.mAdvertise]];
        UIImage *image = [UIImage imageWithData:imageData];
        [bannerImageView setImage:image];
    });
}

- (IBAction)movieButtonPress:(id)sender
{
    MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
    [moreContentView setCurrentUrl:[NSURL URLWithString:currentMediaRecord.mMovieUrl]];
    [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:moreContentView animated:YES completion:nil];
    [moreContentView release];
}

- (IBAction)broadcastButtonPress:(id)sender
{
    
}

@end
