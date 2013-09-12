//
//  appConfigRecord.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/10.
//
//

#import "appConfigRecord.h"

appConfigRecord *appConfigInstance;

@implementation appConfigRecord
@synthesize dayURL, tabURL1, tabURL2, tabURL3, tabURL4, tabURL5;
@synthesize tabTitle1, tabTitle2, tabTitle3, tabTitle4, tabTitle5;
@synthesize popupWelcome, cardType, latitude, longitude, showCardLoc, slyTypePmo;
@synthesize movieTicketPmo, fbFootString, fbHeader, showiAD, iadUrl, cardAuthorize;
@synthesize applySylinCardUrl, createSylinCardUrl, adUrl;
@synthesize currentAddress, currentLocation;
@synthesize pccuNews1, pccuNews2, pccuNews3, pccuNews4, pccuNews5, pccuNews6, pccuNews7;
@synthesize pccuMedia1, pccuMedia2, pccuMedia3, pccuMedia4, pccuMedia5, pccuMedia6, pccuMedia7 ,ymsWeather;

+ (appConfigRecord*)appConfigInstance
{
    if (appConfigInstance == nil)
    {
        appConfigInstance = [[appConfigRecord alloc] init];
    }
    return appConfigInstance;
}

- (void)dealloc
{
    [dayURL release], dayURL = nil;
    [tabURL1 release], tabURL1 = nil;
    [tabURL2 release], tabURL2 = nil;
    [tabURL3 release], tabURL3 = nil;
    [tabURL4 release], tabURL4 = nil;
    [tabURL5 release], tabURL5 = nil;
    [tabTitle1 release], tabTitle1 = nil;
    [tabTitle2 release], tabTitle2 = nil;
    [tabTitle3 release], tabTitle3 = nil;
    [tabTitle4 release], tabTitle4 = nil;
    [tabTitle5 release], tabTitle5 = nil;
    [popupWelcome release], popupWelcome = nil;
    [cardType release], cardType = nil;
    [latitude release], latitude = nil;
    [longitude release], longitude = nil;
    [showCardLoc release], showCardLoc = nil;
    [slyTypePmo release], slyTypePmo = nil;
    [movieTicketPmo release], movieTicketPmo = nil;
    [fbFootString release], fbFootString = nil;
    [fbHeader release], fbHeader = nil;
    [showiAD release], showiAD = nil;
    [iadUrl release], iadUrl = nil;
    [adUrl release], adUrl = nil;
    [cardAuthorize release], cardAuthorize = nil;
    [applySylinCardUrl release], applySylinCardUrl = nil;
    [createSylinCardUrl release], createSylinCardUrl = nil;
    [currentAddress release], currentAddress = nil;
    [currentLocation release], currentLocation = nil;
    [pccuNews1 release], pccuNews1 = nil;
    [pccuNews2 release], pccuNews2 = nil;
    [pccuNews3 release], pccuNews3 = nil;
    [pccuNews4 release], pccuNews4 = nil;
    [pccuNews5 release], pccuNews5 = nil;
    [pccuNews6 release], pccuNews6 = nil;
    [pccuNews7 release], pccuNews7 = nil;
    [pccuMedia1 release], pccuMedia1 = nil;
    [pccuMedia2 release], pccuMedia2 = nil;
    [pccuMedia3 release], pccuMedia3 = nil;
    [pccuMedia4 release], pccuMedia4 = nil;
    [pccuMedia5 release], pccuMedia5 = nil;
    [pccuMedia6 release], pccuMedia6 = nil;
    [pccuMedia7 release], pccuMedia7 = nil;
    [ymsWeather release], ymsWeather = nil;
    [super dealloc];
}

@end
