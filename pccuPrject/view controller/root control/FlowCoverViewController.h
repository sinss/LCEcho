//
//  FlowCoverViewController.h
//  FlowCover
//
//  Created by William Woody on 12/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowCoverView.h"
#import "downloadStoreDelegate.h"
#import "customImgaeView.h"


#define adImageViewWidth 320
#define adImageViewHeight 200
#define adImageViewStartX 0
#define adImageViewStartY 0

@interface FlowCoverViewController : UIViewController
<FlowCoverViewDelegate, UIScrollViewDelegate, downloadStoreListProcess, customImageViewButtonDelegate>
{
    IBOutlet UIScrollView *adScrollView;
    IBOutlet UIPageControl *adPageControl;
    BOOL pageControlUsed;
    downloadStoreDelegate *downloadProcess;
    NSArray *adDataArray;
}

- (IBAction)done:(id)sender;

@end

