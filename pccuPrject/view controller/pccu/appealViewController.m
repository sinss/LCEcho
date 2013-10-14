//
//  appealViewController.m
//  pccuPrject
//
//  Created by sinss on 12/10/21.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "appealViewController.h"
#import "infoPanel.h"

@interface appealViewController ()

@end

@implementation appealViewController
@synthesize currentUrl, type;

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
    [webView setDelegate:self];
    [webView loadRequest:[NSURLRequest requestWithURL:currentUrl]];
    // Do any additional setup after loading the view from its nib.
}

- (void) dealloc
{
    [currentUrl release], currentUrl = nil;
    [webView release], webView = nil;
    [activityView release], activityView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView delegate

- (void)webViewDidStartLoad:(UIWebView *)web
{
    [activityView startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)web
{
    //表示為載入天氣，自動放大
    if (type == 1)
    {
        [webView stringByEvaluatingJavaScriptFromString:@"document. body.style.zoom = 3.0;"];
    }
    else
    {
        [webView stringByEvaluatingJavaScriptFromString:@"document. body.style.zoom = 2.0;"];
    }
    [activityView stopAnimating];
    [infoPanel showPanelInView:webView type:infoPanelTypeInfo title:@"提示訊息" subTitle:@"網頁載入完成" hideAfter:3];
}
- (void)webView:(UIWebView *)web didFailLoadWithError:(NSError *)error
{
    [activityView stopAnimating];
    [infoPanel showPanelInView:webView type:infoPanelTypeError title:@"提示訊息" subTitle:@"網頁載入失敗" hideAfter:3];
}

- (IBAction)backItemPress:(id)sender
{
    [webView goBack];
}
- (IBAction)nextItemPress:(id)sender
{
    [webView goForward];
}
- (IBAction)refreshItemPress:(id)sender
{
    [webView reload];
}


@end
