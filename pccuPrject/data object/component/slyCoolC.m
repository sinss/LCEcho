//
//  slyCoolC.m
//  SlyCool001Project
//
//  Created by Wan Jung Liu on 11/12/21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "slyCoolC.h"

@implementation slyCoolC
@synthesize CName,CContent;
@synthesize CType, Mail;

- (void)dealloc
{
    [CName release], CName = nil;
    [CContent release], CContent = nil;
    [CType release], CType = nil;
    [Mail release], Mail = nil;
    [super dealloc];
}
@end
