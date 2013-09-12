//
//  sylinCardTableViewController.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import <UIKit/UIKit.h>
#import "downloadStoreDelegate.h"
#import "sylinCreateCell.h"

@class sylinCard;
@interface sylinCardTableViewController : UITableViewController
<downloadStoreListProcess, UITextFieldDelegate, sylinCreateDelegate>
{   
    NSArray *cardAuthorizeArray;
    downloadStoreDelegate *downloadProcess;
    sylinCard *currentSylinCard;
    NSString *inputCardNo;
    NSString *inputCardName;
    UITextField *cardNoField;
    UITextField *cardNameField;
    BOOL cardAuthInd;
    BOOL isExpired;
}

@end
