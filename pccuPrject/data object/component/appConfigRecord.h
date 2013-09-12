//
//  appConfigRecord.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/10.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface appConfigRecord : NSObject
{
    NSString *dayURL;
    NSString *tabURL1;
    NSString *tabURL2;
    NSString *tabURL3;
    NSString *tabURL4;
    NSString *tabURL5;
    NSString *popupWelcome;
    NSString *cardType;
    NSNumber *latitude;
    NSNumber *longitude;
    NSString *showCardLoc;
    NSString *slyTypePmo;
    NSString *movieTicketPmo;
    NSString *fbHeader;
    NSString *fbFootString;
    NSString *tabTitle1;
    NSString *tabTitle2;
    NSString *tabTitle3;
    NSString *tabTitle4;
    NSString *tabTitle5;
    NSString *showiAD;
    NSString *iadUrl;
    NSString *cardAuthorize;
    NSString *adurl;
    /*
     pccu
     */
    NSString *pccuNews1;
    NSString *pccuNews2;
    NSString *pccuNews3;
    NSString *pccuNews4;
    NSString *pccuNews5;
    NSString *pccuNews6;
    NSString *pccuNews7;
    
    NSString *pccuMedia1;
    NSString *pccuMedia2;
    NSString *pccuMedia3;
    NSString *pccuMedia4;
    NSString *pccuMedia5;
    NSString *pccuMedia6;
    NSString *pccuMedia7;
    
    CLLocation *currentLocation;
    NSMutableString *currentAddress;
    NSString *applySylinCardUrl;
    NSString *createSylinCardUrl;
    NSString *ymsWeather;
    
}
@property (nonatomic, retain) NSString *dayURL;
@property (nonatomic, retain) NSString *tabURL1;
@property (nonatomic, retain) NSString *tabURL2;
@property (nonatomic, retain) NSString *tabURL3;
@property (nonatomic, retain) NSString *tabURL4;
@property (nonatomic, retain) NSString *tabURL5;
@property (nonatomic, retain) NSString *popupWelcome;
@property (nonatomic, retain) NSString *cardType;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSString *showCardLoc;
@property (nonatomic, retain) NSString *slyTypePmo;
@property (nonatomic, retain) NSString *movieTicketPmo;
@property (nonatomic, retain) NSString *fbHeader;
@property (nonatomic, retain) NSString *fbFootString;
@property (nonatomic, retain) NSString *tabTitle1;
@property (nonatomic, retain) NSString *tabTitle2;
@property (nonatomic, retain) NSString *tabTitle3;
@property (nonatomic, retain) NSString *tabTitle4;
@property (nonatomic, retain) NSString *tabTitle5;
@property (nonatomic, retain) NSString *showiAD;
@property (nonatomic, retain) NSString *iadUrl;
@property (nonatomic, retain) NSString *cardAuthorize;
@property (nonatomic, retain) NSString *applySylinCardUrl;
@property (nonatomic, retain) NSString *createSylinCardUrl;
@property (nonatomic, retain) NSString *adUrl;
@property (nonatomic, retain) NSString *pccuNews1;
@property (nonatomic, retain) NSString *pccuNews2;
@property (nonatomic, retain) NSString *pccuNews3;
@property (nonatomic, retain) NSString *pccuNews4;
@property (nonatomic, retain) NSString *pccuNews5;
@property (nonatomic, retain) NSString *pccuNews6;
@property (nonatomic, retain) NSString *pccuNews7;
@property (nonatomic, retain) NSString *pccuMedia1;
@property (nonatomic, retain) NSString *pccuMedia2;
@property (nonatomic, retain) NSString *pccuMedia3;
@property (nonatomic, retain) NSString *pccuMedia4;
@property (nonatomic, retain) NSString *pccuMedia5;
@property (nonatomic, retain) NSString *pccuMedia6;
@property (nonatomic, retain) NSString *pccuMedia7;
@property (nonatomic, retain) NSString *ymsWeather;
/*
 目前位置
 */
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) NSMutableString *currentAddress;


+(appConfigRecord*)appConfigInstance;

@end
