//
//  downloadStoreDelegate.m
//  SlyCoolForEst
//
//  Created by sinss on 12/7/30.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import "downloadStoreDelegate.h"
#import "globalFunction.h"

@interface downloadStoreDelegate()

- (void)parseCSVData;
- (void)checkAppConfigKey:(NSString*)key andValue:(NSString*)value;
- (void)checkAppDateKey:(NSString*)key andValue:(NSString*)value;

@end

@implementation downloadStoreDelegate
@synthesize delegate;
@synthesize currLocation;
@synthesize csvLoadtype;
@synthesize typeOfPccuNews, pccuMediaType;

- (id)initWithURL:(NSString*)url
{
    self = [super init];
    if (self)
    {
        postUrl = [[NSURL alloc] initWithString:url];
        if (currentRow == nil)
        {
            currentRow = [[NSMutableArray alloc] initWithCapacity:0];
            storeArray = [[NSMutableArray alloc] initWithCapacity:0];
            topicArray = [[NSMutableArray alloc] initWithCapacity:0];
            brandArray = [[NSMutableArray alloc] initWithCapacity:0];
            moreArray = [[NSMutableArray alloc] initWithCapacity:0];
            cardAuthArray = [[NSMutableArray alloc] initWithCapacity:0];
            adDataArray = [[NSMutableArray alloc] initWithCapacity:0];
            /*
             carnival
             */
            activityArray = [[NSMutableArray alloc] initWithCapacity:0];
            stageArray = [[NSMutableArray alloc] initWithCapacity:0];
            drawArray = [[NSMutableArray alloc] initWithCapacity:0];
            movieArray = [[NSMutableArray alloc] initWithCapacity:0];
            carnivalArray = [[NSMutableArray alloc] initWithCapacity:0];
            /*
             pccu
             */
            pccuNewsRecordArray = [[NSMutableArray alloc] initWithCapacity:0];
            pccuMediaRecordArray = [[NSMutableArray alloc] initWithCapacity:0];
            pccuMediaOtherArray = [[NSMutableArray alloc] initWithCapacity:0];
        }
    }
    return self;
}

- (void)dealloc
{
    [currLocation release], currLocation = nil;
    [postUrl release], postUrl = nil;
    [storeArray release], storeArray = nil;
    [topicArray release], topicArray = nil;
    [brandArray release], brandArray = nil;
    [moreArray release], moreArray = nil;
    [cardAuthArray release], cardAuthArray = nil;
    [adDataArray release], adDataArray = nil;
    [activityArray release], activityArray = nil;
    [stageArray release], stageArray = nil;
    [drawArray release], drawArray = nil;
    [movieArray release], movieArray = nil;
    [carnivalArray release], carnivalArray = nil;
    [pccuNewsRecordArray release], pccuNewsRecordArray = nil;
    [pccuMediaRecordArray release], pccuMediaRecordArray = nil;
    [pccuMediaOtherArray release], pccuMediaOtherArray = nil;
    delegate = nil;
    [super dealloc];
}

- (void)startGetStoreWithRefreshing:(BOOL)ind
{
    /*
    NSURLRequest *request = [NSURLRequest requestWithURL:postUrl
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:120];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    NSLog(@"postUrl:%@",postUrl);
    if (connection)
    {
        responseData = [NSMutableData new];
    }
    */
    [currentRow removeAllObjects];
    [storeArray removeAllObjects];
    [topicArray removeAllObjects];
    [brandArray removeAllObjects];
    [moreArray removeAllObjects];
    [cardAuthArray removeAllObjects];
    [activityArray removeAllObjects];
    [stageArray removeAllObjects];
    [drawArray removeAllObjects];
    [movieArray removeAllObjects];
    [carnivalArray removeAllObjects];
    [pccuNewsRecordArray removeAllObjects];
    [pccuMediaRecordArray removeAllObjects];
    [pccuMediaOtherArray removeAllObjects];
    isRefreshing = ind;
    [self parseCSVData];
}
- (void)parseCSVData
{
    NSString *fileName = nil;
    NSData *dataDoc = nil;
    BOOL saveInd = YES;
    if (csvLoadtype == csvLoadtypeConfig)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvConfigFile], [globalFunction getTodayString]];
    }
    else if (csvLoadtype == csvLoadtypeDayURL)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvDayFile], [globalFunction getTodayString]];
    }
    else if (csvLoadtype == csvLoadtypeStore)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvStoreFile], [globalFunction getTodayString]];
    }
    else if (csvLoadtype == csvLoadtypeTopic)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvTopicFile], [globalFunction getTodayString]];
    }
    else if (csvLoadtype == csvLoadtypeBrand)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvBrandFile], [globalFunction getTodayString]];
    }
    else if (csvLoadtype == csvloadtypeMore)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvMoreFile], [globalFunction getTodayString]];
    }
    else if (csvLoadtype == csvloadtypeCardAuthorize)
    {
        //認證卡片清單不儲存
        saveInd = NO;
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvCardAuthFile], [globalFunction getTodayString]];
    }
    else if (csvLoadtype == csvloadtypeAdUrl)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvAdDataFile], [globalFunction getTodayString]];
    }
    else if (csvLoadtype == csvLoadTypeActivity)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvActivityFile], [globalFunction getTodayString]];
        saveInd = NO;
    }
    else if (csvLoadtype == csvLoadTypeStage)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvStageFile], [globalFunction getTodayString]];
        saveInd = NO;
    }
    else if (csvLoadtype == csvLoadTypeDraw)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvDrawFile], [globalFunction getTodayString]];
        saveInd = NO;
    }
    else if (csvLoadtype == csvLoadTypeMovie)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvMovieFile], [globalFunction getTodayString]];
        saveInd = NO;
    }
    else if (csvLoadtype == csvLoadTypeCarnival)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvCarnivalFile], [globalFunction getTodayString]];
        saveInd = NO;
    }
    else if (csvLoadtype == csvLoadTypePccuNews)
    {
        switch (typeOfPccuNews)
        {
            case pccuNewsType1:
                fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvPccuNewsFile1], [globalFunction getTodayString]];
                break;
            case pccuNewsType2:
                fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvPccuNewsFile2], [globalFunction getTodayString]];
                break;
            case pccuNewsType3:
                fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvPccuNewsFile3], [globalFunction getTodayString]];
                break;
            case pccuNewsType4:
                fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvPccuNewsFile4], [globalFunction getTodayString]];
                break;
            case pccuNewsType5:
                fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvPccuNewsFile5], [globalFunction getTodayString]];
                break;
            case pccuNewsType6:
                fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvPccuNewsFile6], [globalFunction getTodayString]];
                break;
            case pccuNewsType7:
                fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvPccuNewsFile7], [globalFunction getTodayString]];
                break;
        }
    }
    else if (csvLoadtype == csvLoadTypePccuCards)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvPccuNewsCardsFile], [globalFunction getTodayString]];
    }
    else if (csvLoadtype == csvLoadTypePccuMedia || csvLoadtype == csvLoadTypePccuOther)
    {
        if (pccuMediaType == 1)
        {
            fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvPccuMediaFile1], [globalFunction getTodayString]];
        }
        else if (pccuMediaType == 2)
        {
            fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvPccuMediaFile2], [globalFunction getTodayString]];
        }
        else if (pccuMediaType == 3)
        {
            fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvPccuMediaFile3], [globalFunction getTodayString]];
        }
        else if (pccuMediaType == 4)
        {
            fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvPccuMediaFile4], [globalFunction getTodayString]];
        }
        else if (pccuMediaType == 5)
        {
            fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvPccuMediaFile5], [globalFunction getTodayString]];
        }
    }
    /*
     表示為重新整理
     */
    if (!isRefreshing)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileName])
        {
            NSLog(@"%@ exist",fileName);
            dataDoc = [[NSData alloc] initWithContentsOfFile:fileName];
            /*
             如果檔案為空白，則重新自網路取得
             */
            if ([dataDoc length] == 0)
            {
                dataDoc = [[NSData alloc] initWithContentsOfURL:postUrl];
            }
        }
        else
        {
            /*
             表示過了一天，清除前一天的資料
             */
            NSString *cachePath = [globalFunction getCacheDirectory];
            NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[globalFunction getCacheDirectory] error:nil];
            for (NSString *file in files)
            {
                if ([[file pathExtension] isEqualToString:@"csv"])
                {
                    NSString *delegatePath = [cachePath stringByAppendingPathComponent:file];
                    [[NSFileManager defaultManager] removeItemAtPath:delegatePath error:nil];
                }
            }
            NSLog(@"%@ notexist", fileName);
            dataDoc = [[NSData alloc] initWithContentsOfURL:postUrl];
        }
    }
    else
    {
        dataDoc = [[NSData alloc] initWithContentsOfURL:postUrl];
    }
    
    NSString *csvData = [[NSString alloc] initWithData:dataDoc encoding:NSUTF8StringEncoding];
    /*
     設定為只讀取店家列表
     */
    CHCSVParser *p = [(CHCSVParser *)[CHCSVParser alloc] initWithCSVString:csvData encoding:NSUTF8StringEncoding error:nil];
    [p setParserDelegate:self];
    [p parse];
    if (csvLoadtype == csvLoadtypeStore)
    {
        /*
         排序
         */
        NSArray *sortArray = [storeArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSNumber *first = [NSNumber numberWithInt:[(StoreTemp*)a Distance]];
            NSNumber *second = [NSNumber numberWithInt:[(StoreTemp*)b Distance]];
            return [first compare:second];
        }];
        [delegate downloadDelegate:self didFinishDownloadWithData:sortArray];
    }
    else if (csvLoadtype == csvLoadtypeTopic)
    {
        /*
         排序
         */
        NSArray *sortArray = [topicArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSString *first = [(slyCoolA*)a ANo];
            NSString *second = [(slyCoolA*)b ANo];
            return [first compare:second];
        }];
        [delegate downloadDelegate:self didFinishDownloadWithData:sortArray];
    }
    else if (csvLoadtype == csvLoadtypeBrand)
    {
        NSArray *sortArray = [brandArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSString *first = [(slyCoolB*)a BNo];
            NSString *second = [(slyCoolB*)b BNo];
            return [first compare:second];
        }];
        [delegate downloadDelegate:self didFinishDownloadWithData:sortArray];
    }
    else if (csvLoadtype == csvloadtypeMore)
    {
        [delegate downloadDelegate:self didFinishDownloadWithData:moreArray];
    }
    else if (csvLoadtype == csvloadtypeCardAuthorize)
    {
        [delegate downloadDelegate:self didFinishDownloadWithData:cardAuthArray];
    }
    else if (csvLoadtype == csvloadtypeAdUrl)
    {
        [delegate downloadDelegate:self didFinishDownloadWithData:adDataArray];
    }
    else if (csvLoadtype == csvLoadTypeActivity)
    {
        [delegate downloadDelegate:self didFinishDownloadWithData:activityArray];
    }
    else if (csvLoadtype == csvLoadTypeStage)
    {
        [delegate downloadDelegate:self didFinishDownloadWithData:stageArray];
    }
    else if (csvLoadtype == csvLoadTypeDraw)
    {
        [delegate downloadDelegate:self didFinishDownloadWithData:drawArray];
    }
    else if (csvLoadtype == csvLoadTypeMovie)
    {
        [delegate downloadDelegate:self didFinishDownloadWithData:movieArray];
    }
    else if (csvLoadtype == csvLoadTypeCarnival)
    {
        [delegate downloadDelegate:self didFinishDownloadWithData:carnivalArray];
    }
    else if (csvLoadtype == csvLoadTypePccuNews)
    {
        [delegate downloadDelegate:self didFinishDownloadWithData:pccuNewsRecordArray];
    }
    else if (csvLoadtype == csvLoadTypePccuCards)
    {
        [delegate downloadDelegate:self didFinishDownloadWithData:moreArray];
    }
    else if (csvLoadtype == csvLoadTypePccuMedia)
    {
        [delegate downloadDelegate:self didFinishDownloadWithData:pccuMediaRecordArray];
    }
    else if (csvLoadtype == csvLoadTypePccuOther)
    {
        [delegate downloadDelegate:self didFinishDownloadWithData:pccuMediaOtherArray];
    }
    NSError *error = nil;
    if (saveInd)
    {
        //判斷是否需要儲存
        BOOL saveInd = [csvData writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (!saveInd)
        {
            NSLog(@"save:%@ with rror:%@", fileName, error);
        }
    }
    [p release];
    [csvData release];
    [dataDoc release];
}

#pragma mark - NSURLconnection delegate
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    [responseData release], responseData = nil;
    [delegate downloadDelegate:self didFaildDownloadWithError:@"下載失敗"];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self parseCSVData];
    NSLog(@"did finish download data with %i",responseData.length);
    [responseData release], responseData = nil;
}

#pragma mark CHCSVParserDelegate methods

- (void) parser:(CHCSVParser *)parser didStartDocument:(NSString *)csvFile
{
    // NSLog(@"Tab_%@_Parser!",csvFile);
    switch (csvLoadtype)
    {
        case csvLoadtypeStore:
            [storeArray removeAllObjects];
            break;
    }
}

- (void) parser:(CHCSVParser *)parser didStartLine:(NSUInteger)lineNumber
{
    //   NSLog(@"%d.Psr.startLine!",lineNumber);
    
}

- (void) parser:(CHCSVParser *)parser didEndLine:(NSUInteger)lineNumber
{
    if(lineNumber > 1)
    {
        switch (csvLoadtype)
        {
            case csvLoadtypeConfig:
                if ([currentRow count] == 3)
                {
                    [self checkAppConfigKey:[currentRow objectAtIndex:0] andValue:[currentRow objectAtIndex:1]];
                    
                }
                break;
            case csvLoadtypeDayURL:
                if ([currentRow count] == 5)
                {
                    [self checkAppDateKey:[currentRow objectAtIndex:0] andValue:[currentRow objectAtIndex:1]];
                }
                break;
            case csvLoadtypeStore:
                //                NSLog(@"%d-%d.count:%d/",csvLoadtype, lineNumber,  currentRow.count);
                if (currentRow.count == 30)
                {
                    if ([@"Y" compare:[currentRow objectAtIndex:29]] == 0 )
                    {
                        StoreTemp *StoreA = [[StoreTemp alloc] init];
                        StoreA.StoreID = [currentRow objectAtIndex:0];
                        StoreA.StoreType  = [currentRow objectAtIndex:1];
                        StoreA.slyPush = [currentRow objectAtIndex:2];
                        StoreA.slyRanking  = [currentRow objectAtIndex:3];
                        StoreA.StoreName = [currentRow objectAtIndex:4];
                        StoreA.StoreAddress  = [currentRow objectAtIndex:5];
                        StoreA.StoreTel  = [currentRow objectAtIndex:6];
                        StoreA.MapX = [currentRow objectAtIndex:7];
                        StoreA.MapY = [currentRow objectAtIndex:8];
                        StoreA.PicA = [currentRow objectAtIndex:9];
                        StoreA.PicB  = [currentRow objectAtIndex:10];
                        StoreA.StoreNews = [currentRow objectAtIndex:11];
                        StoreA.StoreNewsDate  = [currentRow objectAtIndex:12];
                        StoreA.StoreP1 = [currentRow objectAtIndex:13];
                        StoreA.StoreP1URL  = [currentRow objectAtIndex:14];
                        StoreA.StoreP2 = [currentRow objectAtIndex:15];
                        StoreA.StoreP2URL  = [currentRow objectAtIndex:16];
                        StoreA.StoreP3 = [currentRow objectAtIndex:17];
                        StoreA.StoreP3URL  = [currentRow objectAtIndex:18];
                        StoreA.StoreP4 = [currentRow objectAtIndex:19];
                        StoreA.StoreP4URL  = [currentRow objectAtIndex:20];
                        StoreA.MovTicket = [currentRow objectAtIndex:21];
                        StoreA.MovTicketDate  = [currentRow objectAtIndex:22];
                        StoreA.slyCardSrv = [currentRow objectAtIndex:23];
                        StoreA.slyCardSrvDate  = [currentRow objectAtIndex:24];
                        StoreA.StoreHR = [currentRow objectAtIndex:25];
                        StoreA.StoreHRContent  = [currentRow objectAtIndex:26];
                        StoreA.StoreHRDate = [currentRow objectAtIndex:27];
                        StoreA.FBURL = [currentRow objectAtIndex:28];
                        StoreA.Enable = [currentRow objectAtIndex:29];
                        CLLocation *distanceLocation = [[[CLLocation alloc] initWithLatitude:[StoreA.MapX doubleValue] longitude:[StoreA.MapY doubleValue]] autorelease] ;
                        CLLocationDistance distance = [currLocation distanceFromLocation:distanceLocation];
                        NSString *distanceString = [[[NSString alloc] initWithFormat:@"%.0f",distance] autorelease] ;
                        
                        /*
                        NSLog(@"Store:%@",StoreA.StoreName);
                        NSLog(@"StoreType:%@",StoreA.StoreType);
                        NSLog(@"Store:%@ distance:%@",StoreA.StoreName,distanceString);
                        NSLog(@"===========================================");
                        */
                        StoreA.Distance = [distanceString integerValue] ;
                        
                        [storeArray addObject:StoreA];
                        [StoreA release];
                    }
                }
                break;
            case csvLoadtypeTopic:
                if ([currentRow count] == 19)
                {
                    if ([[globalFunction getTodayString] compare:[currentRow objectAtIndex:18]] <= 0)
                    {
                        slyCoolA *slyCoolAA     = [[slyCoolA alloc] init];
                        slyCoolAA.ANo           = [currentRow objectAtIndex:0];
                        slyCoolAA.ATitle        = [currentRow objectAtIndex:1];
                        slyCoolAA.ASubTitle     = [currentRow objectAtIndex:2];
                        slyCoolAA.ASubA         = [currentRow objectAtIndex:3];
                        slyCoolAA.AConA         = [currentRow objectAtIndex:4];
                        slyCoolAA.ASubB         = [currentRow objectAtIndex:5];
                        slyCoolAA.AConB         = [currentRow objectAtIndex:6];
                        slyCoolAA.ASubC         = [currentRow objectAtIndex:7];
                        slyCoolAA.AConC         = [currentRow objectAtIndex:8];
                        slyCoolAA.APicA         = [currentRow objectAtIndex:9];
                        slyCoolAA.APicB         = [currentRow objectAtIndex:10];
                        slyCoolAA.APicC         = [currentRow objectAtIndex:11];
                        slyCoolAA.APicD         = [currentRow objectAtIndex:12];
                        slyCoolAA.AStoreID      = [currentRow objectAtIndex:13];
                        slyCoolAA.ASubCon       = [currentRow objectAtIndex:14];
                        slyCoolAA.ExInfo        = [currentRow objectAtIndex:15];
                        slyCoolAA.ExInfoURL     = [currentRow objectAtIndex:16];
                        slyCoolAA.FBURL         = [currentRow objectAtIndex:17];
                        slyCoolAA.AExpireDate   = [currentRow objectAtIndex:18];
                        [topicArray addObject:slyCoolAA];
                        //NSLog(@"slyCoolA.AConA:%@",slyCoolAA.AConA);
                        //NSLog(@"slyCoolA.AConB:%@",slyCoolAA.AConB);
                        //NSLog(@"slyCoolA.AConC:%@",slyCoolAA.AConC);
                        [slyCoolAA release];
                    }
                }
                break;
            case csvLoadtypeBrand:
                if (currentRow.count == 14)
                {
                    slyCoolB *slyCoolBA = [[slyCoolB alloc] init];
                    slyCoolBA.BNo = [currentRow objectAtIndex:0];
                    slyCoolBA.BName = [currentRow objectAtIndex:1];
                    slyCoolBA.BOrg = [currentRow objectAtIndex:2];
                    slyCoolBA.BFee = [currentRow objectAtIndex:3];
                    slyCoolBA.BExp = [currentRow objectAtIndex:4];
                    slyCoolBA.BPlace = [currentRow objectAtIndex:5];
                    slyCoolBA.BDesc = [currentRow objectAtIndex:6];
                    slyCoolBA.BFunc = [currentRow objectAtIndex:7];
                    slyCoolBA.BOtherDesc    = [currentRow objectAtIndex:8];
                    slyCoolBA.ExInfo        = [currentRow objectAtIndex:9];
                    slyCoolBA.ExInfoURL     = [currentRow objectAtIndex:10];
                    slyCoolBA.FBURL         = [currentRow objectAtIndex:11];
                    slyCoolBA.PicA          = [currentRow objectAtIndex:12];
                    slyCoolBA.PicB          = [currentRow objectAtIndex:13];
                    //NSLog(@"slyCoolB:%@",slyCoolBA.BNo);
                    //NSLog(@"slyCoolB:%@",slyCoolBA.BName);
                    [brandArray addObject:slyCoolBA];
                }
                break;
            case csvloadtypeMore:
               // NSLog(@"currentRow.count:%i",[currentRow count]);
                if (currentRow.count == 4)
                {
                    slyCoolC *slyCoolCA = [[slyCoolC alloc] init];
                    slyCoolCA.CName = [currentRow objectAtIndex:0];
                    slyCoolCA.CContent = [currentRow objectAtIndex:1];
                    slyCoolCA.Mail = [currentRow objectAtIndex:2];
                    slyCoolCA.CType = [currentRow objectAtIndex:3];
                    //NSLog(@"  %@...%@",slyCoolCA.CName,slyCoolCA.CContent );
                    //NSLog(@"more:%@",slyCoolCA.CContent);
                    [moreArray addObject:slyCoolCA];
                    if ([[currentRow objectAtIndex:0] isEqualToString:@"網路申請士林卡"])
                    {
                        [[appConfigRecord appConfigInstance] setApplySylinCardUrl:[currentRow objectAtIndex:1]];
                    }
                    else if ([[currentRow objectAtIndex:0] isEqualToString:@"開卡專區"])
                    {
                        [[appConfigRecord appConfigInstance] setCreateSylinCardUrl:[currentRow objectAtIndex:1]];
                    }
                }
                break;
            case csvloadtypeCardAuthorize:
                if (currentRow.count == 5)
                {
                    sylinCard *cardRecord = [[sylinCard alloc] init];
                    cardRecord.cardNo = [currentRow objectAtIndex:1];
                    cardRecord.cardName = [currentRow objectAtIndex:2];
                    cardRecord.cardExpireDate = [currentRow objectAtIndex:3];
                    cardRecord.cardType = [currentRow objectAtIndex:4];
                    [cardAuthArray addObject:cardRecord];
                    [cardRecord release];
                }
                break;
            case csvloadtypeAdUrl:
                if ([currentRow count] == 7)
                {
                    if ([[globalFunction getTodayString] compare:[currentRow objectAtIndex:4]] <= 0)
                    {
                        //日期未過才可以播放
                        if ([[currentRow objectAtIndex:0] isEqualToString:@"AD_IMAGE"])
                        {
                            adRecord *adInfo = [[adRecord alloc] init];
                            adInfo.adTitle = [currentRow objectAtIndex:1];
                            adInfo.adContent = [currentRow objectAtIndex:2];
                            adInfo.adImageUrl = [currentRow objectAtIndex:3];
                            adInfo.expireDate = [currentRow objectAtIndex:4];
                            adInfo.adNo = [currentRow objectAtIndex:5];
                            adInfo.contentUrl = [currentRow objectAtIndex:6];
                            [adDataArray addObject:adInfo];
                            [adInfo release];
                        }
                    }
                }
                break;
            case csvLoadTypeActivity:
                //活動總表
                //NSLog(@"cnt:%i",[currentRow count]);
                //NSLog(@"data:%@",currentRow);
                if ([currentRow count] == 6)
                {
                    activityRecord *activity = [[activityRecord alloc] init];
                    activity.aID = [currentRow objectAtIndex:0];
                    activity.aType = [currentRow objectAtIndex:1];
                    activity.aTitle = [currentRow objectAtIndex:2];
                    activity.aImageUrl = [currentRow objectAtIndex:3];
                    activity.aLocationDesc = [currentRow objectAtIndex:4];
                    activity.aIntroduction = [currentRow objectAtIndex:5];
                    //NSLog(@"%@",activity.aType);
                    [activityArray addObject:activity];
                    [activity release];
                }
                break;
            case csvLoadTypeStage:
                if ([currentRow count] == 7)
                {
                    stageRecord *stage = [[stageRecord alloc] init];
                    stage.sID = [currentRow objectAtIndex:0];
                    stage.sTitle = [currentRow objectAtIndex:1];
                    stage.sImageUrl = [currentRow objectAtIndex:2];
                    stage.sTime = [currentRow objectAtIndex:3];
                    stage.sLocationDesc = [currentRow objectAtIndex:4];
                    stage.sIntroduction = [currentRow objectAtIndex:5];
                    stage.sOtherUrl = [currentRow objectAtIndex:6];
                    
                    [stageArray addObject:stage];
                    [stage release];
                }
                break;
            case csvLoadTypeDraw:
                if ([currentRow count] == 3)
                {
                    drawRecord *draw = [[drawRecord alloc] init];
                    draw.dId = [currentRow objectAtIndex:0];
                    draw.dTitle = [currentRow objectAtIndex:1];
                    draw.dUrl = [currentRow objectAtIndex:2];
                    [drawArray addObject:draw];
                    [draw release];
                }
                break;
            case csvLoadTypeMovie:
                //NSLog(@"cnt:%i",[currentRow count]);
                //NSLog(@"data:%@",currentRow);
                if ([currentRow count] == 8)
                {
                    movieRecord *movie = [[movieRecord alloc] init];
                    movie.mID = [currentRow objectAtIndex:0];
                    movie.mTitle = [currentRow objectAtIndex:1];
                    movie.mImageUrl = [currentRow objectAtIndex:2];
                    movie.mMovieUrl = [currentRow objectAtIndex:3];
                    movie.mDirector = [currentRow objectAtIndex:4];
                    movie.mTeamDesc = [currentRow objectAtIndex:5];
                    movie.mIntroduction = [currentRow objectAtIndex:6];
                    movie.mOtherUrl = [currentRow objectAtIndex:7];
                    [movieArray addObject:movie];
                    [movie release];
                }
                break;
            case csvLoadTypeCarnival:
                if (currentRow.count == 4)
                {
                    slyCoolC *slyCoolCA = [[slyCoolC alloc] init];
                    slyCoolCA.CName = [currentRow objectAtIndex:0];
                    slyCoolCA.CContent = [currentRow objectAtIndex:1];
                    slyCoolCA.Mail = [currentRow objectAtIndex:2];
                    slyCoolCA.CType = [currentRow objectAtIndex:3];
                    [carnivalArray addObject:slyCoolCA];
                }
                break;
            case csvLoadTypePccuNews:
                //NSLog(@"%@",[currentRow objectAtIndex:0]);
                //NSLog(@"%@",[currentRow objectAtIndex:1]);
                //NSLog(@"%@",[currentRow objectAtIndex:3]);
                if ([currentRow count] == 10)
                {
                    pccuNewsRecord *pccuNew = [[pccuNewsRecord alloc] init];
                    pccuNew.nNo = [currentRow objectAtIndex:0];
                    pccuNew.nTitle = [currentRow objectAtIndex:1];
                    pccuNew.nSubTitle = [currentRow objectAtIndex:2];
                    pccuNew.nImageUrl = [currentRow objectAtIndex:3];
                    pccuNew.nContentTitle = [currentRow objectAtIndex:4];
                    //pccuNew.nContent = [currentRow objectAtIndex:5];
                    pccuNew.nContentTitle2 = [currentRow objectAtIndex:6];
                    //pccuNew.nContent2 = [currentRow objectAtIndex:7];
                    pccuNew.nImageUrl2 = [currentRow objectAtIndex:8];
                    pccuNew.otherUrl = [currentRow objectAtIndex:9];
                    NSString *content1 = [currentRow objectAtIndex:5];
                    NSString *content2 = [currentRow objectAtIndex:7];
                    content1 = [content1 stringByReplacingOccurrencesOfString:@"==>" withString:@"\n"];
                    content2 = [content2 stringByReplacingOccurrencesOfString:@"==>" withString:@"\n"];
                    content1 = [content1 stringByReplacingOccurrencesOfString:@"(@)" withString:@"\n"];
                    content2 = [content2 stringByReplacingOccurrencesOfString:@"(@)" withString:@"\n"];
                    pccuNew.nContent = content1;
                    pccuNew.nContent2 = content2;
                    [pccuNewsRecordArray addObject:pccuNew];
                    [pccuNew release];
                }
                break;
            case csvLoadTypePccuCards:
                // NSLog(@"currentRow.count:%i",[currentRow count]);
                NSLog(@"%@",[currentRow objectAtIndex:0]);
                NSLog(@"%@",[currentRow objectAtIndex:1]);
                if (currentRow.count == 4)
                {
                    slyCoolC *slyCoolCA = [[slyCoolC alloc] init];
                    slyCoolCA.CName = [currentRow objectAtIndex:0];
                    slyCoolCA.CContent = [currentRow objectAtIndex:1];
                    slyCoolCA.Mail = [currentRow objectAtIndex:2];
                    slyCoolCA.CType = [currentRow objectAtIndex:3];
                    //NSLog(@"  %@...%@",slyCoolCA.CName,slyCoolCA.CContent );
                    //NSLog(@"more:%@",slyCoolCA.CContent);
                    [moreArray addObject:slyCoolCA];
                }
                break;
            case csvLoadTypePccuMedia:
                //文化媒體-華岡電視台、華岡廣播電台
                if ([currentRow count] == 9)
                {
                    pccuMediaRecord *media = [[pccuMediaRecord alloc] init];
                    media.mNo = [currentRow objectAtIndex:0];
                    media.mImageUrl = [currentRow objectAtIndex:1];
                    media.mTitle = [currentRow objectAtIndex:2];
                    media.mSubTitle = [currentRow objectAtIndex:3];
                    media.mTitle2 = [currentRow objectAtIndex:4];
                    media.mSubTitle2 = [currentRow objectAtIndex:5];
                    media.mMovieUrl = [currentRow objectAtIndex:6];
                    //media.mContent = [currentRow objectAtIndex:7];
                    media.mAdvertise = [currentRow objectAtIndex:8];
                    NSString *content = [currentRow objectAtIndex:7];
                    content = [content stringByReplacingOccurrencesOfString:@"==>" withString:@"\n"];
                    content = [content stringByReplacingOccurrencesOfString:@"(@)" withString:@"\n"];
                    media.mContent = content;
                    [pccuMediaRecordArray addObject:media];
                    [media release];
                }
                break;
            case csvLoadTypePccuOther:
                //文化媒體-其它、文化一周
                if ([currentRow count] == 13)
                {
                    pccuMediaOther *media2 = [[pccuMediaOther alloc] init];
                    media2.mNo = [currentRow objectAtIndex:0];
                    media2.mImageUrl = [currentRow objectAtIndex:1];
                    media2.mTitle = [currentRow objectAtIndex:2];
                    media2.mSubTitle = [currentRow objectAtIndex:3];
                    media2.mTitle2 = [currentRow objectAtIndex:4];
                    media2.mSubTitle2 = [currentRow objectAtIndex:5];
                    //media2.mContent = [currentRow objectAtIndex:6];
                    //media2.mContent2 = [currentRow objectAtIndex:7];
                    //media2.mContent3 = [currentRow objectAtIndex:8];
                    //media2.mContent4 = [currentRow objectAtIndex:9];
                    media2.mImageUrl2 = [currentRow objectAtIndex:10];
                    media2.mImageContent = [currentRow objectAtIndex:11];
                    media2.mAdvitise = [currentRow objectAtIndex:12];
                    NSString *content = [currentRow objectAtIndex:6];
                    NSString *content2 = [currentRow objectAtIndex:7];
                    NSString *content3 = [currentRow objectAtIndex:8];
                    NSString *content4 = [currentRow objectAtIndex:9];
                    content = [content stringByReplacingOccurrencesOfString:@"==>" withString:@"\n"];
                    content2 = [content2 stringByReplacingOccurrencesOfString:@"==>" withString:@"\n"];
                    content3 = [content3 stringByReplacingOccurrencesOfString:@"==>" withString:@"\n"];
                    content4 = [content4 stringByReplacingOccurrencesOfString:@"==>" withString:@"\n"];
                    content = [content stringByReplacingOccurrencesOfString:@"(@)" withString:@"\n"];
                    content2 = [content2 stringByReplacingOccurrencesOfString:@"(@)" withString:@"\n"];
                    content3 = [content3 stringByReplacingOccurrencesOfString:@"(@)" withString:@"\n"];
                    content4 = [content4 stringByReplacingOccurrencesOfString:@"(@)" withString:@"\n"];
                    media2.mContent = content;
                    media2.mContent2 = content2;
                    media2.mContent3 = content3;
                    media2.mContent4 = content4;
                    [pccuMediaOtherArray addObject:media2];
                    [media2 release];
                }
                break;
        }
    }
    [currentRow removeAllObjects];
}

- (void) parser:(CHCSVParser *)parser didReadField:(NSString *)field {
    //NSLog(@"Parser didReadField!");
    [currentRow addObject:field];
}

- (void) parser:(CHCSVParser *)parser didEndDocument:(NSString *)csvFile
{
    NSLog(@"csvFile:%@",csvFile);
    
}

- (void) parser:(CHCSVParser *)parser didFailWithError:(NSError *)error
{
    NSLog(@"Psr.failWithError!");
    [delegate downloadDelegate:self didFaildDownloadWithError:@"解析檔案失敗"];
    
}


#pragma mark - 判斷appconfig檔中的值
- (void)checkAppConfigKey:(NSString*)key andValue:(NSString*)value
{
    if ([key isEqualToString:@"DAY_URL"])
    {
        [[appConfigRecord appConfigInstance] setDayURL:value];
    }
    else if ([key isEqualToString:@"TAB_URL1"])
    {
        [[appConfigRecord appConfigInstance] setTabURL1:value];
    }
    else if ([key isEqualToString:@"TAB_URL2"])
    {
        [[appConfigRecord appConfigInstance] setTabURL2:value];
    }
    else if ([key isEqualToString:@"TAB_URL3"])
    {
        [[appConfigRecord appConfigInstance] setTabURL3:value];
    }
    else if ([key isEqualToString:@"TAB_URL4"])
    {
        [[appConfigRecord appConfigInstance] setTabURL4:value];
    }
    else if ([key isEqualToString:@"TAB_URL5"])
    {
        //https://docs.google.com/spreadsheet/pub?key=0Ai_zNVD47hEJdFhsb1dKdWJQeDlpYmc1OVVVODZIVGc&single=true&gid=0&output=csv
        [[appConfigRecord appConfigInstance] setTabURL5:value];
    }
    else if ([key isEqualToString:@"POPUP_WELCOME"])
    {
        [[appConfigRecord appConfigInstance] setPopupWelcome:@"https://docs.google.com/a/slycool.com/spreadsheet/pub?key=0Ai_zNVD47hEJdEVBZGNjSmFENWdYbXJNRUNpOGpzc2c&single=true&gid=0&output=csv"];
    }
    else if ([key isEqualToString:@"CARD_TYPE"])
    {
        [[appConfigRecord appConfigInstance] setCardType:value];
    }
    else if ([key isEqualToString:@"LOC_CENTER_X"])
    {
        [[appConfigRecord appConfigInstance] setLatitude:[NSNumber numberWithDouble:[value doubleValue]]];
    }
    else if ([key isEqualToString:@"LOC_CENTER_Y"])
    {
        [[appConfigRecord appConfigInstance] setLongitude:[NSNumber numberWithDouble:[value doubleValue]]];
    }
    else if ([key isEqualToString:@"SHOW_CARD_LOC"])
    {
        [[appConfigRecord appConfigInstance] setShowCardLoc:value];
    }
    else if ([key isEqualToString:@"SLY_CARD_PMO"])
    {
        [[appConfigRecord appConfigInstance] setSlyTypePmo:value];
    }
    else if ([key isEqualToString:@"MRM_TICKET_PMO"])
    {
        [[appConfigRecord appConfigInstance] setMovieTicketPmo:value];
    }
    else if ([key isEqualToString:@"FB_HEAD_PREFIX"])
    {
        [[appConfigRecord appConfigInstance] setFbHeader:value];
    }
    else if ([key isEqualToString:@"FB_FOOT_STRING"])
    {
        [[appConfigRecord appConfigInstance] setFbFootString:value];
    }
    else if ([key isEqualToString:@"TAB_TITLE1"])
    {
        [[appConfigRecord appConfigInstance] setTabTitle1:value];
    }
    else if ([key isEqualToString:@"TAB_TITLE2"])
    {
        [[appConfigRecord appConfigInstance] setTabTitle2:value];
    }
    else if ([key isEqualToString:@"TAB_TITLE3"])
    {
        [[appConfigRecord appConfigInstance] setTabTitle3:value];
    }
    else if ([key isEqualToString:@"TAB_TITLE4"])
    {
        [[appConfigRecord appConfigInstance] setTabTitle4:value];
    }
    else if ([key isEqualToString:@"TAB_TITLE5"])
    {
        [[appConfigRecord appConfigInstance] setTabTitle5:value];
    }
    else if ([key isEqualToString:@"SHOW_IAD"])
    {
        [[appConfigRecord appConfigInstance] setShowiAD:value];
    }
    else if ([key isEqualToString:@"IAD_URL"])
    {
        [[appConfigRecord appConfigInstance] setIadUrl:value];
    }
    else if ([key isEqualToString:@"AD_URL"])
    {
        [[appConfigRecord appConfigInstance] setAdUrl:value];
    }
    else if ([key isEqualToString:@"CARD_AUTHORIZE"])
    {
        [[appConfigRecord appConfigInstance] setCardAuthorize:value];
    }
    else if ([key isEqualToString:@"pccu_news1"])
    {
        [[appConfigRecord appConfigInstance] setPccuNews1:value];
    }
    else if ([key isEqualToString:@"pccu_news2"])
    {
        [[appConfigRecord appConfigInstance] setPccuNews2:value];
    }
    else if ([key isEqualToString:@"pccu_news3"])
    {
        [[appConfigRecord appConfigInstance] setPccuNews3:value];
    }
    else if ([key isEqualToString:@"pccu_news4"])
    {
        [[appConfigRecord appConfigInstance] setPccuNews4:value];
    }
    else if ([key isEqualToString:@"pccu_news5"])
    {
        [[appConfigRecord appConfigInstance] setPccuNews5:value];
    }
    else if ([key isEqualToString:@"pccu_news6"])
    {
        [[appConfigRecord appConfigInstance] setPccuNews6:value];
    }
    else if ([key isEqualToString:@"pccu_news7"])
    {
        [[appConfigRecord appConfigInstance] setPccuNews7:value];
    }
    else if ([key isEqualToString:@"pccu_media1"])
    {
        [[appConfigRecord appConfigInstance] setPccuMedia1:value];
    }
    else if ([key isEqualToString:@"pccu_media2"])
    {
        [[appConfigRecord appConfigInstance] setPccuMedia2:value];
    }
    else if ([key isEqualToString:@"pccu_media3"])
    {
        [[appConfigRecord appConfigInstance] setPccuMedia3:value];
    }
    else if ([key isEqualToString:@"pccu_media4"])
    {
        [[appConfigRecord appConfigInstance] setPccuMedia4:value];
    }
    else if ([key isEqualToString:@"pccu_media5"])
    {
        [[appConfigRecord appConfigInstance] setPccuMedia5:value];
    }
    else if ([key isEqualToString:@"pccu_media6"])
    {
        [[appConfigRecord appConfigInstance] setPccuMedia6:value];
    }
    else if ([key isEqualToString:@"pccu_media7"])
    {
        [[appConfigRecord appConfigInstance] setPccuMedia7:value];
    }
    else if ([key isEqualToString:@"yms_weather"])
    {
        [[appConfigRecord appConfigInstance] setYmsWeather:value];
    }
}

- (void)checkAppDateKey:(NSString*)key andValue:(NSString*)value
{
    if ([key isEqualToString:@"WELCOME_PAGE"])
    {
        [[appDateRecord appDateInstance] setWelcomePage:value];
    }
    else if ([key isEqualToString:@"LOTTERY_PAGE"])
    {
        [[appDateRecord appDateInstance] setLotteryPage:value];
    }
    else if ([key isEqualToString:@"LOTTERY_SUB_PAGE"])
    {
        [[appDateRecord appDateInstance] setLotterySubPage:value];
    }
    else if ([key isEqualToString:@"WINNER_PAGE"])
    {
        [[appDateRecord appDateInstance] setWinnerPage:value];
    }
}


@end
