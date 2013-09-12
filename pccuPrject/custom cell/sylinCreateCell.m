//
//  sylinCreateCell.m
//  SlyCool001
//
//  Created by sinss on 12/8/14.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import "sylinCreateCell.h"

@implementation sylinCreateCell
@synthesize delegate, cardNoField, cardNameField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    delegate = nil;
    [cardNoField release], cardNoField = nil;
    [cardNameField release], cardNameField = nil;
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)authorizeButtonPress:(id)sender
{
    [delegate didPressStartAuthorizeSylinCard];
}
- (IBAction)applySylinCardButtonPress:(id)sender
{
    [delegate didPressApplySylinButton];
}
- (IBAction)createSylinCardButtonPress:(id)sender
{
    [delegate didPressCreateSylinButton];
}

@end
