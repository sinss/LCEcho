//
//  storeRateCell.m
//  SlyCoolForEst
//
//  Created by sinss on 12/7/31.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import "storeRateCell.h"

@implementation storeRateCell
@synthesize delegate;
@synthesize rate1Button, rate2Button, rate3Button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [rate1Button release], rate1Button = nil;
    [rate2Button release], rate2Button = nil;
    [rate3Button release], rate3Button = nil;
    delegate = nil;
    [super dealloc];
}

#pragma mark 食記
- (IBAction)rate1ButtonPress:(UIButton*)sender
{
    NSString *urlStr = [NSString stringWithFormat:@"%@",rate1Button.titleLabel.text];
    if ([urlStr isEqualToString:@"N/A"])
    {
        return;
    }
    [delegate didPressWithURL:[NSURL URLWithString:urlStr]];
}
#pragma mark 大改造專區
- (IBAction)rate2ButtonPress:(UIButton*)sender
{
    NSString *urlStr = [NSString stringWithFormat:@"%@",rate2Button.titleLabel.text];
    if ([urlStr isEqualToString:@"N/A"])
    {
        return;
    }
    [delegate didPressWithURL:[NSURL URLWithString:urlStr]];
}
#pragma mark 會員評比
- (IBAction)rate3ButtonPress:(UIButton*)sender
{
    NSString *urlStr = [NSString stringWithFormat:@"%@",rate3Button.titleLabel.text];
    if ([urlStr isEqualToString:@"N/A"])
    {
        return;
    }
    [delegate didPressWithURL:[NSURL URLWithString:urlStr]];
}
@end
