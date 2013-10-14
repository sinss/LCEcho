//
//  pccuNewsDetailViewController.m
//  pccuPrject
//
//  Created by sinss on 12/11/17.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "pccuNewsDetailViewController.h"
#import "pccuNewsRecord.h"
#import "topicInformationCell.h"
#import "pccuImageCell.h"
#import "MoreContentViewController.h"
#import "infoPanel.h"

@interface pccuNewsDetailViewController ()

@end

@implementation pccuNewsDetailViewController
@synthesize currentPccuRecord;

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
    [aTableView setDelegate:self];
    [aTableView setDataSource:self];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"maker_bg.png"]];
    [aTableView setBackgroundView:bgView];
    [bgView release];
    [aTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (void)dealloc
{
    [contentArray release], contentArray = nil;
    [currentPccuRecord release], currentPccuRecord = nil;
    [aTableView release], aTableView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate , UITableviewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        NSUInteger cnt = 0;
        if ([currentPccuRecord.nContentTitle length] > 0)
            cnt ++;
        if ([currentPccuRecord.nContentTitle2 length] > 0)
            cnt ++;
        return cnt;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    if (sec == 0)
    {
        if (row == 0)
        {
            NSUInteger lineNo = [currentPccuRecord.nContent length] / klineWordUnit + 3;
            NSUInteger newHeight = kdefaultTextViewHeight + lineNo * ktextViewHeightUnit;
            return newHeight;
        }
        else if (row == 1)
        {
            NSUInteger lineNo = [currentPccuRecord.nContent2 length] / klineWordUnit + 3;
            NSUInteger newHeight = kdefaultTextViewHeight + lineNo * ktextViewHeightUnit;
            return newHeight;
        }
    }
    else if (sec == 1)
    {
        return 238;
    }
    else if (sec == 2)
    {
        return 40;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    static NSString *textCellIdentifier = @"textCellIdentifier";
    static NSString *imageCellIdentifier = @"imageCellIdentifier";
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    if (sec == 0)
    {
        topicInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:textCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"topicInformationCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[topicInformationCell class]])
                {
                    cell = currentObj;
                    break;
                }
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        if (row == 0)
        {
            [cell.titleLabel setText:currentPccuRecord.nContentTitle];
            [cell.contentTextView setText:currentPccuRecord.nContent];
            //重新調整textview的高度
            NSUInteger lineNo = [currentPccuRecord.nContent length] / klineWordUnit;
            NSUInteger newHeight = kdefaultTextViewHeight + lineNo * ktextViewHeightUnit;
            CGRect rect = cell.contentTextView.frame;
            [cell.contentTextView setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, newHeight)];
        }
        else if (row == 1)
        {
            [cell.titleLabel setText:currentPccuRecord.nContentTitle2];
            [cell.contentTextView setText:currentPccuRecord.nContent2];
            //重新調整textview的高度
            NSUInteger lineNo = [currentPccuRecord.nContent2 length] / klineWordUnit;
            NSUInteger newHeight = kdefaultTextViewHeight + lineNo * ktextViewHeightUnit;
            CGRect rect = cell.contentTextView.frame;
            [cell.contentTextView setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, newHeight)];
        }
        
        return cell;
    }
    else if (sec == 1)
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
        [cell setImageWithImageName:currentPccuRecord.nNo andUrl:currentPccuRecord.nImageUrl2];
        [cell.imageIntroLabel setText:@""];
        
        return cell;
    }
    else if (sec == 2)
    {
        //延伸網址
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
            [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
        }
        [cell.textLabel setText:@"延伸網址"];
        return cell;
        
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger sec = [indexPath section];
    if (sec == 2)
    {
        NSURL *url = [NSURL URLWithString:currentPccuRecord.otherUrl];
        if ([currentPccuRecord.otherUrl length] > 0 && ![currentPccuRecord.otherUrl isEqualToString:@"n/a"])
        {
            if (url != nil)
            {
                MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
                [moreContentView setCurrentUrl:url];
                [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:moreContentView animated:YES completion:nil];
                [moreContentView release];
            }
        }
        else
        {
            [infoPanel showPanelInView:self.view type:infoPanelTypeInfo title:@"訊息" subTitle:@"無延伸網址提供" hideAfter:2];
        }
    }
}

@end
