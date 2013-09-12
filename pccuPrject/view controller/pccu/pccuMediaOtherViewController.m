//
//  pccuMediaOtherViewController.m
//  pccuPrject
//
//  Created by sinss on 12/11/15.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "pccuMediaOtherViewController.h"
#import "pccuMediaOther.h"
#import "customTextViewCell.h"
#import "pccuImageCell.h"

enum
{
    contentDetailTypeText = 0,
    contentDetailTypeImage = 1,
};

@interface pccuMediaOtherViewController ()

- (void)resetContentData;

@end

@implementation pccuMediaOtherViewController
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
    [contentTableView setDataSource:self];
    [contentTableView setDelegate:self];
    [self resetContentData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (IS_IPHONE_5)
    {
        CGRect frame = self.view.bounds;
        CGFloat height = 44.f;
        CGFloat width = 320.f;
        [contentTableView setFrame:CGRectMake(contentTableView.frame.origin.x,
                                              contentTableView.frame.origin.y,
                                              contentTableView.frame.size.width,
                                              contentTableView.frame.size.height - 20)];
        [bannerImageView setFrame:CGRectMake(0,
                                             frame.size.height - height- 20,
                                             width,
                                             height)];
    }
}

- (void)dealloc
{
    [titleLabel release], titleLabel = nil;
    [subTitleLabel release], subTitleLabel = nil;
    [contentTableView release], contentTableView = nil;
    [bannerImageView release], bannerImageView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger sec = [indexPath section];
    if (sec == contentDetailTypeText)
    {
        NSString *contentText = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", currentMediaRecord.mContent, currentMediaRecord.mContent2, currentMediaRecord.mContent3, currentMediaRecord.mContent4];
        NSUInteger lineNo = [contentText length] / klineWordUnit + 3;
        NSUInteger newHeight = kdefaultTextViewHeight + lineNo * ktextViewHeightUnit;
        return newHeight;
    }
    else if (sec == contentDetailTypeImage)
    {
        return 238;
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    static NSString *textCellIdentifier = @"textCellIdentifier";
    static NSString *imageCellIdentifier = @"imageCellIdentifier";
    
    NSUInteger sec = [indexPath section];
    if (sec == contentDetailTypeText)
    {
        customTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customTextViewCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[customTextViewCell class]])
                {
                    cell = currentObj;
                    break;
                }
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        NSString *contentText = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", currentMediaRecord.mContent, currentMediaRecord.mContent2, currentMediaRecord.mContent3, currentMediaRecord.mContent4];
        NSUInteger lineNo = [contentText length] / klineWordUnit + 3;
        NSUInteger newHeight = kdefaultTextViewHeight + lineNo * ktextViewHeightUnit;
        CGRect rect = cell.contentTextView.frame;
        [cell.contentTextView setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, newHeight)];
        [cell.contentTextView setText:contentText];
        return cell;
    }
    else if (sec == contentDetailTypeImage)
    {
        pccuImageCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"pccuImageCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[pccuImageCell class]])
                {
                    cell = currentObj;
                    break;
                }
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [cell setImageWithImageName:currentMediaRecord.mNo andUrl:currentMediaRecord.mImageUrl2];
        [cell.imageIntroLabel setText:currentMediaRecord.mImageContent];
        
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    return cell;
}

- (void)resetContentData
{
    [titleLabel setText:currentMediaRecord.mTitle2];
    [subTitleLabel setText:currentMediaRecord.mSubTitle2];
    
    int64_t delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:currentMediaRecord.mAdvitise]];
        UIImage *image = [UIImage imageWithData:imageData];
        [bannerImageView setImage:image];
    });
}

@end
