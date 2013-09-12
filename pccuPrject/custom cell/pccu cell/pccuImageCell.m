//
//  pccuImageCell.m
//  pccuPrject
//
//  Created by sinss on 12/11/17.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "pccuImageCell.h"
#import "customImgaeView.h"

@implementation pccuImageCell
@synthesize imageIntroLabel;

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
    [imageIntroLabel release], imageIntroLabel = nil;
    [super dealloc];
}

- (void)setImageWithImageName:(NSString*)mNo andUrl:(NSString*)imageUrl
{
    customImgaeView *imageview = [[customImgaeView alloc] initWithFrame:CGRectMake(0, 0, 320, 200) andImageName:mNo andSmallInd:NO];
    [self addSubview:imageview];
    [imageview downloadAndDisplayImageWithURL:[NSURL URLWithString:imageUrl]];
    [imageview release];
}
@end
