//
//  pccuShareFunction.m
//  pccuPrject
//
//  Created by sinss on 12/10/28.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "pccuShareFunction.h"

pccuShareFunction *pccuShareFunctionInstance;

@implementation pccuShareFunction

+ (pccuShareFunction*)pccuShareFunctionInstance
{
    if (pccuShareFunctionInstance == nil)
    {
        pccuShareFunctionInstance = [[pccuShareFunction alloc] init];
    }
    return pccuShareFunctionInstance;
}

- (NSString*)GetPccuMenuNameWithMenuItem:(pccuMenuItem)item
{
    NSString *desc = nil;
    switch (item)
    {
        case 0:
            desc = [NSString stringWithFormat:@"最新消息"];
            break;
        case 1:
            desc = [NSString stringWithFormat:@"部門動態"];
            break;
        case 2:
            desc = [NSString stringWithFormat:@"財務報表"];
            break;
        case 3:
            desc = [NSString stringWithFormat:@"活動預告"];
            break;
        case 4:
            desc = [NSString stringWithFormat:@"社團活動"];
            break;
        case 5:
            desc = [NSString stringWithFormat:@"申訴回應"];
            break;
        case 6:
            desc = [NSString stringWithFormat:@"申訴管道"];
            break;
        case 7:
            desc = [NSString stringWithFormat:@"華岡廣播電台"];
            break;
        case 8:
            desc = [NSString stringWithFormat:@"華岡電視台"];
            break;
        case 9:
            desc = [NSString stringWithFormat:@"文化一周"];
            break;
        case 10:
            desc = [NSString stringWithFormat:@"文化Focus"];
            break;
        case 11:
            desc = [NSString stringWithFormat:@"藝文快報"];
            break;
        case 12:
            desc = [NSString stringWithFormat:@"珍妮梁/喂,wei"];
            break;
        case 13:
            desc = [NSString stringWithFormat:@"華岡氣象"];
            break;
        case 14:
            desc = [NSString stringWithFormat:@"華岡生活動態"];
            break;
        case 15:
            desc = [NSString stringWithFormat:@"系聯卡"];
            break;
        case 16:
            desc = [NSString stringWithFormat:@"製作團隊"];
            break;
    }
    return desc;
}

@end
