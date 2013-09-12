//
//  StoreTemp.h
//  SlyCool001
//
//  Created by EricHsiao on 2011/6/30.
//  Copyright 2011年 EricHsiao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StoreTemp : NSObject {
    NSString * StoreID;
    NSString * StoreType;
    NSString * slyPush;
    NSString * slyRanking;
    NSString * StoreName;
    NSString * StoreAddress;
    NSString * StoreTel;
    NSString * MapX;
    NSString * MapY;
    NSString * PicA;
    NSString * PicB;
    NSString * StoreNews;
    NSString * StoreNewsDate;
    NSString * StoreP1;
    NSString * StoreP1URL;
    NSString * StoreP2;
    NSString * StoreP2URL;
    NSString * StoreP3;
    NSString * StoreP3URL;
    NSString * StoreP4;
    NSString * StoreP4URL;
    NSString * MovTicket;
    NSString * MovTicketDate;
    NSString * slyCardSrv;
    NSString * slyCardSrvDate;
    NSString * StoreHR;
    NSString * StoreHRDate;
    NSString * StoreHRContent;
    NSInteger  Distance;
    NSString * FBURL;
    NSString * Enable;
//    NSString * MemberScore;

}

@property (nonatomic, retain) NSString * StoreID;
@property (nonatomic, retain) NSString * StoreType;
@property (nonatomic, retain) NSString * slyPush;
@property (nonatomic, retain) NSString * slyRanking;
@property (nonatomic, retain) NSString * StoreName;
@property (nonatomic, retain) NSString * StoreAddress;
@property (nonatomic, retain) NSString * StoreTel;
@property (nonatomic, retain) NSString * MapX;
@property (nonatomic, retain) NSString * MapY;
@property (nonatomic, retain) NSString * PicA;
@property (nonatomic, retain) NSString * PicB;
@property (nonatomic, retain) NSString * StoreNews;
@property (nonatomic, retain) NSString * StoreNewsDate;
@property (nonatomic, retain) NSString * StoreP1;
@property (nonatomic, retain) NSString * StoreP1URL;
@property (nonatomic, retain) NSString * StoreP2;
@property (nonatomic, retain) NSString * StoreP2URL;
@property (nonatomic, retain) NSString * StoreP3;
@property (nonatomic, retain) NSString * StoreP3URL;
@property (nonatomic, retain) NSString * StoreP4;
@property (nonatomic, retain) NSString * StoreP4URL;
@property (nonatomic, retain) NSString * MovTicket;
@property (nonatomic, retain) NSString * MovTicketDate;
@property (nonatomic, retain) NSString * slyCardSrv;
@property (nonatomic, retain) NSString * slyCardSrvDate;
@property (nonatomic, retain) NSString * StoreHR;
@property (nonatomic, retain) NSString * StoreHRDate;
@property (nonatomic, retain) NSString * StoreHRContent;
@property (nonatomic, assign) NSInteger  Distance;
@property (nonatomic, retain) NSString * FBURL;
@property (nonatomic, retain) NSString * Enable;
//@property (nonatomic, retain) NSString * MemberScore;

@end

