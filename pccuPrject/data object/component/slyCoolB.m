//
//  slyCoolB.m
//  SlyCool001
//
//  Created by EricHsiao on 2011/8/22.
//  Copyright 2011年 EricHsiao. All rights reserved.
//

#import "slyCoolB.h"


@implementation slyCoolB
@synthesize BNo,BName,BOrg,BFee,BExp,BPlace,BDesc,BFunc,BOtherDesc,PicA,PicB, ExInfo, ExInfoURL,FBURL;

- (void)dealloc
{
    [BNo release], BNo = nil;
    [BName release], BName = nil;
    [BOrg release], BOrg = nil;
    [BFee release], BFee = nil;
    [BExp release], BExp = nil;
    [BPlace release], BPlace = nil;
    [BDesc release], BDesc = nil;
    [BFunc release], BFunc = nil;
    [BOtherDesc release], BOtherDesc = nil;
    [PicA release], PicA = nil;
    [PicB release], PicB = nil;
    [ExInfo release], ExInfo = nil;
    [ExInfoURL release], ExInfoURL = nil;
    [FBURL release], FBURL = nil;
    [super dealloc];
}
@end
