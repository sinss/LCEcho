//
//  StoreTypeSelectViewController.m
//  SlyCoolForEst
//
//  Created by sinss on 12/7/30.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import "StoreTypeSelectViewController.h"
#import "globalFunction.h"

@interface StoreTypeSelectViewController ()

@end

@implementation StoreTypeSelectViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [typePicker setDataSource:self];
    [typePicker setDelegate:self];
    if (typeArray == nil)
    {
        typeArray = [[NSArray alloc] initWithObjects:
                     @"all",
                     @"slyPush",
                     @"slyCardSrv",
                     @"食",
                     @"飲",
                     @"衣",
                     @"樂",
                     @"行",
                     @"住",
                     @"宅",
                     @"藝",
                     @"育",
                     @"StoreHR",
                     nil];
    }
    if (distanceArray == nil)
    {
        distanceArray = [[NSArray alloc] initWithObjects:
                         @"-1",
                         @"100",
                         @"200",
                         @"300",
                         @"500",
                         @"800",
                         @"1000",
                         @"2000",
                         @"9999999999",
                         nil];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [typePicker release], typePicker = nil;
    [typeArray release], typeArray = nil;
    [distanceArray release], distanceArray = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == StoreCategoryType)
        return 180;
    else if (component == StoreCategoryDistance)
        return 140;
    return 0;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == StoreCategoryType)
        return [typeArray count];
    else if (component == StoreCategoryDistance)
        return [distanceArray count];
    return 0;
}
- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = nil;
    NSString *desc = nil;
    if (component == StoreCategoryType)
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
        desc = [typeArray objectAtIndex:row];
        if ([desc isEqualToString:@"all"])
        {
            desc = [NSString stringWithFormat:@"不限條件"];
        }
        else if ([desc isEqualToString:@"slyPush"])
        {
            desc = [NSString stringWithFormat:@"士林商圈本月特推"];
        }
        else if ([desc isEqualToString:@"slyCardSrv"])
        {
            desc = [NSString stringWithFormat:@"可申辦士林卡的店家"];
        }
        else if ([desc isEqualToString:@"StoreHR"])
        {
            desc = [NSString stringWithFormat:@"打工職缺開放"];
        }
        else if ([desc isEqualToString:@"樂"])
        {
            desc = [NSString stringWithFormat:@"%@的店家(含提票點)",desc];
        }
        else
        {
            desc = [NSString stringWithFormat:@"%@的店家",desc];
        }
        [label setText:[NSString stringWithFormat:@"%@", desc]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor darkGrayColor]];
    }
    else if (component == StoreCategoryDistance)
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 44)];
        desc = [distanceArray objectAtIndex:row];
        if ([desc isEqualToString:@"-1"])
        {
            desc = [NSString stringWithFormat:@"不限距離"];
        }
        else if ([desc isEqualToString:@"9999999999"])
        {
            desc = [NSString stringWithFormat:@"2公里以上"];
        }
        else
        {
            desc = [globalFunction formatDistance:[desc integerValue]];
        }
        [label setText:[NSString stringWithFormat:@"%@以內", desc]];
    }
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor darkGrayColor]];
    
    return label;
}

- (IBAction)doneButtonPress:(id)sender
{
    NSString *selectStr = [typeArray objectAtIndex:[typePicker selectedRowInComponent:StoreCategoryType]];
    NSString *predictStr = nil;
    NSString *pre1 = nil;
    NSString *pre2 = nil;
    if ([selectStr isEqualToString:@"all"])
    {
        pre1 = [NSString stringWithFormat:@"1=1"];
    }
    else if ([selectStr isEqualToString:@"slyPush"])
    {
        pre1 = [NSString stringWithFormat:@"slyPush = 'Y'"];
    }
    else if ([selectStr isEqualToString:@"slyCardSrv"])
    {
        pre1 = [NSString stringWithFormat:@"slyCardSrv = 'Y'"];
    }
    else if ([selectStr isEqualToString:@"slyCardSrv"])
    {
        pre1 = [NSString stringWithFormat:@"slyCardSrv = 'Y'"];
    }
    else
    {
        pre1 = [NSString stringWithFormat:@"StoreType = '%@'",selectStr];
    }
    NSString *desc = [distanceArray objectAtIndex:[typePicker selectedRowInComponent:StoreCategoryDistance]];
    if ([desc isEqualToString:@"-1"])
    {
        pre2 = [NSString stringWithFormat:@"Distance > 0"];
    }
    else if ([desc isEqualToString:@"9999999999"])
    {
        pre2 = [NSString stringWithFormat:@"Distance > 2000"];
    }
    else
    {
        pre2 = [NSString stringWithFormat:@"Distance < %@", desc];
    }
    predictStr = [NSString stringWithFormat:@"%@ and %@", pre1, pre2];
    [delegate storeTypeView:self didSelectWithPredict:predictStr];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)backButtonPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
