//
//  pccuImageCell.h
//  pccuPrject
//
//  Created by sinss on 12/11/17.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pccuImageCell : UITableViewCell
{
    UILabel *imageIntroLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *imageIntroLabel;

- (void)setImageWithImageName:(NSString*)mNo andUrl:(NSString*)imageUrl;

@end
