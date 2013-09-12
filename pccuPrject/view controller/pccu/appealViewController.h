//
//  appealViewController.h
//  pccuPrject
//
//  Created by sinss on 12/10/21.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface appealViewController : UIViewController
<UIWebViewDelegate>
{
    NSInteger type;
    NSURL *currentUrl;
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *activityView;
}

@property (assign) NSInteger type;
@property (nonatomic, retain) NSURL *currentUrl;

- (IBAction)backItemPress:(id)sender;
- (IBAction)nextItemPress:(id)sender;
- (IBAction)refreshItemPress:(id)sender;

@end
