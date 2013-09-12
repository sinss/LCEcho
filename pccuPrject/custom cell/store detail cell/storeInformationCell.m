//
//  storeInformationCell.m
//  SlyCoolForEst
//
//  Created by sinss on 12/7/31.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import "storeInformationCell.h"
#import "customImgaeView.h"

#define customQuestionImageFrame CGRectMake(20, 35, 280, 128)

@implementation storeInformationCell
@synthesize titleLabel, addressLabel, storeImageView, phoneTextView, distanceLabel;

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
    [titleLabel release], titleLabel = nil;
    [addressLabel release], addressLabel = nil;
    [storeImageView release], storeImageView = nil;
    [phoneTextView release], phoneTextView = nil;
    [distanceLabel release], distanceLabel = nil;
    [super dealloc];
}

- (IBAction)phoneButtonPress:(UIButton*)sender
{
    
}

- (void)initImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName;
{
    CGRect frame = customQuestionImageFrame;
    storeImageView = [[customImgaeView alloc] initWithFrame:frame andImageName:imageName andSmallInd:NO];
    [storeImageView downloadAndDisplayImageWithURL:url];
    [self addSubview:storeImageView];
}
@end
