//
//  pccuMoreViewController.m
//  pccuPrject
//
//  Created by sinss on 12/10/28.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "pccuMoreViewController.h"
#import "shareHeaderView2.h"
#import "shareHeaderView3.h"

@interface pccuMoreViewController ()

@end

@implementation pccuMoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        groupArray = [[NSArray alloc] initWithObjects:@"文化Echo (8co)",@"特別感謝",@"設計理念 - 8co", nil];
        ecoArray = [[NSArray alloc] initWithObjects:
                    @"總策劃:鍾易衡 (資訊傳播學系)",
                    @"程式工程:張振興",
                    @"美術工程:鍾易衡",
                    @"UI設計:鍾易衡、張振興",nil];
        thankArray = [[NSArray alloc] initWithObjects:
                      @"士林夢工場 團隊 (執行長:戴偉哲)",
                      @"文化學生會(理事長:簡正昕 公關部長:黃彥瑋)",
                      @"華岡電視台、文化一周、華岡廣播電台",
                      @"資訊傳播學系 李亦君老師、謝翠如老師",
                      @"第九屆資傳系學會(99學年度)",
                      @"英文系 4B 莊雅婷",
                      @"藝術學院院秘書 王禎綺、研究生 周暐閎",
                      @"文化Focus團隊",
                      @"Facebook 知名部落客 珍妮梁、喂,wei",nil];
        otherArray = [[NSArray alloc] initWithObjects:
                      @"由 Echo (回聲)作發想，再加入聲紋、幾何元素設計而成",
                      @"文化大學的學生多元性十足豐富，但其資訊佈達缺乏一個及時且",
                      @"能見度高的平台，因此”文化Echo” 整合各種媒體、學生組織，",
                      @"希望使文化全體師生可以有效、立即的接收到各類訊息，創建此",
                      @"平台也期望使更多學生的聲音得以被聽見、被重視。", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [aTableView setSeparatorColor:[UIColor clearColor]];
    [aTableView setDelegate:self];
    [aTableView setDataSource:self];
}

- (void)dealloc
{
    [aTableView release], aTableView = nil;
    [groupArray release], groupArray = nil;
    [ecoArray release], ecoArray = nil;
    [thankArray release], thankArray = nil;
    [otherArray release], otherArray = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate , UITableviewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [groupArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [ecoArray count];
    }
    else if (section == 1)
    {
        return [thankArray count];
    }
    else if (section == 2)
    {
        return [otherArray count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 25;
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        shareHeaderView2 *headerView = nil;
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"shareHeaderView" owner:self options:nil];
        for (id currentObj in topLevelObjects)
        {
            if ([currentObj isKindOfClass:[shareHeaderView2 class]])
            {
                headerView = currentObj;
                break;
            }
        }
        [headerView.titleLabel setText:[groupArray objectAtIndex:section]];
        
        return headerView;
    }
    else if (section == 2)
    {
        shareHeaderView2 *headerView = nil;
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"shareHeaderView" owner:self options:nil];
        for (id currentObj in topLevelObjects)
        {
            if ([currentObj isKindOfClass:[shareHeaderView2 class]])
            {
                headerView = currentObj;
                break;
            }
        }
        [headerView.titleLabel setText:[groupArray objectAtIndex:section]];
        
        return headerView;
    }
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2)
    {
        shareHeaderView3 *headerView = nil;
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"shareHeaderView" owner:self options:nil];
        for (id currentObj in topLevelObjects)
        {
            if ([currentObj isKindOfClass:[shareHeaderView3 class]])
            {
                headerView = currentObj;
                break;
            }
        }
        [headerView.titleLabel setText:@"本程式所發佈之所有活動均與Apple無關。"];
        
        return headerView;
    }
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (sec == 0)
    {
        [cell.textLabel setText:[ecoArray objectAtIndex:row]];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    }
    else if (sec == 1)
    {
        [cell.textLabel setText:[thankArray objectAtIndex:row]];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    }
    else if (sec == 2)
    {
        [cell.textLabel setText:[otherArray objectAtIndex:row]];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:10]];
    }
    
    return cell;
}

@end
