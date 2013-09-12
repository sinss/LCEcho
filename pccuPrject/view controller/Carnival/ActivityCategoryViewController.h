//
//  ActivityCategoryViewController.h
//  SlyCool001
//
//  Created by sinss on 12/9/22.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import <UIKit/UIKit.h>

enum
{
    categoryTypeA = 0,
    categoryTypeB = 1,
    categoryTypeC = 2,
    categoryTypeD = 3,
    categoryTypeE = 4,
    categoryTypeF = 5,
};

@interface ActivityCategoryViewController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIImageView *imageView;
    NSArray *categoryArray;
    NSArray *categoryNameArray;
}

- (IBAction)categoryButtonPress:(UIButton*)sender;

@end
