//
//  DistanceSelectViewController.m
//  SlyCoolForEst
//
//  Created by sinss on 12/7/30.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import "DistanceSelectViewController.h"

@interface DistanceSelectViewController ()

@end

@implementation DistanceSelectViewController
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
    [distancePicker setDelegate:self];
    [distancePicker setDataSource:self];
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
    delegate = nil;
    [distancePicker release], distancePicker = nil;
    [distanceArray release], distanceArray = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [distanceArray count];
}
- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    NSString *desc = [distanceArray objectAtIndex:row];
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
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor darkGrayColor]];
    
    return label;
}

- (IBAction)doneButtonPress:(id)sender
{
    NSString *desc = [distanceArray objectAtIndex:[distancePicker selectedRowInComponent:0]];
    NSString *predictStr = nil;
    if ([desc isEqualToString:@"-1"])
    {
        predictStr = [NSString stringWithFormat:@"Distance > 0"];
    }
    else if ([desc isEqualToString:@"9999999999"])
    {
        predictStr = [NSString stringWithFormat:@"Distance > 2000"];
    }
    else
    {
        predictStr = [NSString stringWithFormat:@"Distance < %@", desc];
    }
    [delegate distanceView:self didSelectDistanceWithPredict:predictStr];
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)backButtonPress:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
