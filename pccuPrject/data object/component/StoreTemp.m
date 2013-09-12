//
//  StoreTemp.m
//  SlyCool001
//
//  Created by EricHsiao on 2011/6/30.
//  Copyright 2011年 EricHsiao. All rights reserved.
//

#import "StoreTemp.h"


@implementation StoreTemp
@synthesize StoreID,StoreType,slyPush,slyRanking,StoreName,StoreAddress,StoreTel,MapX,MapY,PicA,PicB,StoreNews,StoreNewsDate,StoreP1,StoreP1URL,StoreP2,StoreP2URL,StoreP3,StoreP3URL,StoreP4,StoreP4URL,MovTicket,MovTicketDate,slyCardSrv,slyCardSrvDate,StoreHR,StoreHRDate,StoreHRContent,Distance,Enable, FBURL;

- (void)dealloc
{
    [StoreID release], StoreID = nil;
    [StoreType release], StoreType = nil;
    [slyPush release], slyPush = nil;
    [slyRanking release], slyRanking = nil;
    [StoreName release], StoreName = nil;
    [StoreAddress release], StoreAddress = nil;
    [StoreTel release], StoreTel = nil;
    [MapX release], MapX = nil;
    [MapY release], MapY = nil;
    [PicA release], PicA = nil;
    [PicB release], PicB = nil;
    [StoreNews release], StoreNews = nil;
    [StoreNewsDate release], StoreNewsDate = nil;
    [StoreP1 release], StoreP1 = nil;
    [StoreP1URL release], StoreP1URL = nil;
    [StoreP2 release], StoreP2 = nil;
    [StoreP2URL release], StoreP2URL = nil;
    [StoreP3 release], StoreP3 = nil;
    [StoreP3URL release], StoreP3URL = nil;
    [StoreP4 release], StoreP4 = nil;
    [StoreP4URL release], StoreP4URL = nil;
    [MovTicket release], MovTicket = nil;
    [MovTicketDate release], MovTicketDate = nil;
    [slyCardSrv release], slyCardSrv = nil;
    [slyCardSrvDate release], slyCardSrvDate = nil;
    [StoreHR release], StoreHR = nil;
    [StoreHRContent release], StoreHRContent = nil;
    [StoreHRDate release], StoreHRDate = nil;
    [Enable release], Enable = nil;
    [super dealloc];
}
@end
