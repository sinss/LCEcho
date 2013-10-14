//
//  sylinCardTableViewController.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import "sylinCardTableViewController.h"
#import "sylinCard.h"
#import "customTextfieldCell.h"
#import "sylinCardCell.h"
#import "sylinCard.h"
#import "infoPanel.h"
#import "MoreContentViewController.h"
#import "shareHeaderView.h"
#import "AutoScrollLabel.h"

@interface sylinCardTableViewController ()

- (void)createBarButton;
- (void)closeItemPress;
- (void)autoItemPress;
- (void)loadSylinCard;
- (void)saveSylinCardInfoWithCard:(sylinCard*)card;

@end

@implementation sylinCardTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.tabBarItem.image = [UIImage imageNamed:tab3Image];
        isExpired = YES;
        cardAuthInd = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tableView_bg]];
    [self.tableView setBackgroundView:bgView];
    [bgView release];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    if (downloadProcess == nil)
    {
        NSString *authUrl = [[appConfigRecord appConfigInstance] cardAuthorize];
        if (authUrl != nil)
        {
            downloadProcess = [[downloadStoreDelegate alloc] initWithURL:authUrl];
            [downloadProcess setCsvLoadtype:csvloadtypeCardAuthorize];
            [downloadProcess setDelegate:self];
        }
    }
    if (currentSylinCard == nil)
    {
        currentSylinCard = [[sylinCard alloc] init];
    }
    [self loadSylinCard];
    [self createBarButton];
    inputCardName = [[NSString alloc] init];
    inputCardNo = [[NSString alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [cardAuthorizeArray release], cardAuthorizeArray = nil;
    [downloadProcess release], downloadProcess = nil;
    [currentSylinCard release], currentSylinCard = nil;
    [inputCardNo release], inputCardNo = nil;
    [inputCardName release], inputCardName = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (cardAuthInd)
        return 1;
    else
        return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cardAuthInd)
        return 200;
    else
        return 40;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    shareHeaderView *headerView = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"shareHeaderView" owner:self options:nil];
    for (id currentObj in topLevelObjects)
    {
        if ([currentObj isKindOfClass:[shareHeaderView class]])
        {
            headerView = currentObj;
            break;
        }
    }
    headerView.autoScrollInd = YES;
    if (!cardAuthInd)
    {
        [headerView.titleLabel setText:@"尚未開卡"];
    }
    else
    {
        if (!isExpired)
            [headerView.titleLabel setText:@"卡片已過有效期限"];
        else
            [headerView.titleLabel setText:[NSString stringWithFormat:@"卡片有效:%@",currentSylinCard.cardExpireDate]];
    }
    return headerView;
}
/*
- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (!cardAuthInd)
    {
        return @"尚未開卡";
    }
    else
    {
        if (!isExpired)
            return @"卡片已過有效期限";
        else
            return @"卡片有效";
    }
    return @"";
}
 */

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    shareHeaderView *headerView = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"shareHeaderView" owner:self options:nil];
    for (id currentObj in topLevelObjects)
    {
        if ([currentObj isKindOfClass:[shareHeaderView class]])
        {
            headerView = currentObj;
            break;
        }
    }
    if (cardAuthInd)
        [headerView.titleLabel setText:[NSString stringWithFormat:@"%@ 你好，歡迎你使用士林虛擬卡",currentSylinCard.cardName]];
    else
        [headerView.titleLabel setText:@"請先進行虛擬卡開通服務"];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cardTypeCellIdentifier = @"cardTypeCellIdentifier";
    static NSString *cardAuthCellIdentifier = @"cardAuthCellIdentifier";
    static NSString *cardTextCellIdentifier = @"cardTextCellIdentifier";
    NSUInteger row = [indexPath row];
    if (cardAuthInd)
    {
        sylinCardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cardTypeCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"sylinCardCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[sylinCardCell class]])
                {
                    cell = currentObj;
                    break;
                }
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        NSLog(@"image:%@",[NSString stringWithFormat:@"card_%@.png",currentSylinCard.cardType]);
        [cell.cardImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"card_%@.png",currentSylinCard.cardType]]];
        [cell.cardNoLabel setText:currentSylinCard.cardNo];
        [cell.cardExpireDateLabel setText:currentSylinCard.cardExpireDate];
        [cell.expireLabel setHidden:isExpired];
        return cell;
    }
    else
    {
        /*
        sylinCreateCell *cell = [tableView dequeueReusableCellWithIdentifier:cardAuthCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"sylinCreateCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[sylinCreateCell class]])
                {
                    cell = currentObj;
                    break;
                }
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setDelegate:self];
        }
        cardNoField = cell.cardNoField;
        cardNameField = cell.cardNameField;
        
        return cell;
         */
        if (row == 0 || row == 1)
        {
            customTextfieldCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cardAuthCellIdentifier];
            if (cell == nil)
            {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customTextfieldCell" owner:self options:nil];
                for (id currentObj in topLevelObjects)
                {
                    if ([currentObj isKindOfClass:[customTextfieldCell class]])
                    {
                        cell = currentObj;
                        break;
                    }
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            if (row == 0)
            {
                [cell.titleLabel setText:@"卡號"];
                [cell.contentField setPlaceholder:@"請輸入欲驗證的卡號"];
                [cell.contentField setTag:0];
                [cell.contentField setDelegate:self];
            }
            else if (row == 1)
            {
                [cell.titleLabel setText:@"姓名"];
                [cell.contentField setPlaceholder:@"請輸入卡片持有者的姓名"];
                [cell.contentField setTag:1];
                [cell.contentField setDelegate:self];
            }
            return cell;
        }
        else if (row == 2 || row == 3)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cardTextCellIdentifier];
            if (cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cardTextCellIdentifier] autorelease];
                [cell.textLabel setBackgroundColor:[UIColor clearColor]];
                [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
                [cell.textLabel setShadowColor:[UIColor whiteColor]];
                [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
            }
            if (row == 2)
            {
                //申請士林卡
                [cell.textLabel setText:@"若尚未申請士林卡，前往申請"];
            }
            else if (row == 3)
            {
                //開通士林卡
                [cell.textLabel setText:@"尚末開通士林卡或各聯名卡，往前開卡"];
            }
            return cell;
        }
    }
    
    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    if (!cardAuthInd)
    {
        NSString *urlString = nil;
        if (row == 2)
        {
            urlString = [[appConfigRecord appConfigInstance] applySylinCardUrl];
        }
        else if (row == 3)
        {
            urlString = [[appConfigRecord appConfigInstance] createSylinCardUrl];
        }
        MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
        [moreContentView setCurrentUrl:[NSURL URLWithString:urlString]];
        [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:moreContentView animated:YES completion:nil];
        [moreContentView release];
    }
}

#pragma mark - download process

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFaildDownloadWithError:(NSString *)errorMessage
{
    NSLog(@"下載認證卡片清單失敗");
}

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFinishDownloadWithData:(NSArray *)array
{
    inputCardNo = cardNoField.text;
    inputCardName = cardNameField.text;
    //cardAuthorizeArray = [[NSArray alloc] initWithArray:array];
    NSString *predictString = [NSString stringWithFormat:@"cardNo = '%@' and cardName = '%@'",inputCardNo, inputCardName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predictString];
    NSArray *result = [array filteredArrayUsingPredicate:predicate];
    if ([result count] == 1)
    {
        sylinCard *authCard = [result lastObject];
        [self saveSylinCardInfoWithCard:authCard];
        [self loadSylinCard];
        [self createBarButton];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [infoPanel showPanelInView:self.view type:infoPanelTypeInfo title:@"虛擬卡開通服務" subTitle:@"驗證成功" hideAfter:3];
        [cardNoField setText:@""];
        [cardNameField setText:@""];
    }
    else
    {
        //驗證失敗
        [infoPanel showPanelInView:self.view type:infoPanelTypeError title:@"虛擬卡開通服務" subTitle:@"驗證失敗" hideAfter:3];
    }
}

#pragma mark sylinCreateCell delegate
- (void)didPressStartAuthorizeSylinCard
{
    
}
- (void)didPressApplySylinButton
{
    NSString *urlString = [[appConfigRecord appConfigInstance] applySylinCardUrl];
    MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
    [moreContentView setCurrentUrl:[NSURL URLWithString:urlString]];
    [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:moreContentView animated:YES completion:nil];
}
- (void)didPressCreateSylinButton
{
    NSString *urlString = [[appConfigRecord appConfigInstance] createSylinCardUrl];
    MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
    [moreContentView setCurrentUrl:[NSURL URLWithString:urlString]];
    [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:moreContentView animated:YES completion:nil];
}

#pragma mark - UITextField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@",[textField text]);
    NSInteger tag = [textField tag];
    if (tag == 0)
    {
        //卡號
        inputCardNo = [[NSString alloc] initWithFormat:@"%@%@",textField.text, string];
    }
    else if (tag == 1)
    {
        //姓名
        inputCardName = [[NSString alloc] initWithFormat:@"%@%@",textField.text, string];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger tag = [textField tag];
    if (tag == 0)
    {
        //卡號
        inputCardNo = [[NSString alloc] initWithFormat:@"%@",textField.text];
    }
    else if (tag == 1)
    {
        //姓名
        inputCardName = [[NSString alloc] initWithFormat:@"%@",textField.text];
    }
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSInteger tag = [textField tag];
    if (tag == 0)
    {
        //卡號
        inputCardNo = [[NSString alloc] initWithFormat:@"%@",textField.text];
        cardNoField = textField;
    }
    else if (tag == 1)
    {
        //姓名
        inputCardName = [[NSString alloc] initWithFormat:@"%@",textField.text];
        cardNameField = textField;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger tag = [textField tag];
    if (tag == 0)
    {
        //卡號
        inputCardNo = [[NSString alloc] initWithFormat:@"%@",textField.text];
    }
    else if (tag == 1)
    {
        //姓名
        inputCardName = [[NSString alloc] initWithFormat:@"%@",textField.text];
    }
}

#pragma mark 載入士林卡
- (void)loadSylinCard
{
    currentSylinCard.cardNo = [[NSUserDefaults standardUserDefaults] valueForKey:sylinCardNo];
    currentSylinCard.cardName = [[NSUserDefaults standardUserDefaults] valueForKey:sylinCardName];
    currentSylinCard.cardExpireDate = [[NSUserDefaults standardUserDefaults] valueForKey:sylinCardExpireDate];
    currentSylinCard.cardType = [[NSUserDefaults standardUserDefaults] valueForKey:sylinCardType];
    if (currentSylinCard.cardNo == nil || [currentSylinCard.cardNo length] == 0)
        cardAuthInd = NO;
    else
    {
        NSLog(@"expire:%@",currentSylinCard.cardExpireDate);
        if ([[globalFunction getTodayString] compare:currentSylinCard.cardExpireDate] > 0)
        {
            //有效
            isExpired = NO;
        }
        else
        {
            //卡片過期
            isExpired = YES;
        }
        cardAuthInd = YES;
    }
}

- (void)saveSylinCardInfoWithCard:(sylinCard*)card
{
    [[NSUserDefaults standardUserDefaults] setValue:card.cardNo forKey: sylinCardNo];
    [[NSUserDefaults standardUserDefaults] setValue:card.cardName forKey: sylinCardName];
    [[NSUserDefaults standardUserDefaults] setValue:card.cardType forKey: sylinCardType];
    [[NSUserDefaults standardUserDefaults] setValue:card.cardExpireDate forKey: sylinCardExpireDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)createBarButton
{
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:mainPageItemName style:UIBarButtonItemStylePlain target:self action:@selector(closeItemPress)];
    UIBarButtonItem *authItem = [[UIBarButtonItem alloc] initWithTitle:@"驗證" style:UIBarButtonItemStylePlain target:self action:@selector(autoItemPress)];
    UIBarButtonItem *resetItem = [[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(resetItemPress)];
    self.navigationItem.rightBarButtonItem = closeItem;
    if (!cardAuthInd)
    {
        self.navigationItem.leftBarButtonItem = authItem;
    }
    else
    {
        self.navigationItem.leftBarButtonItem = resetItem;
    }
    [closeItem release];
    [authItem release];
    [resetItem release];
}
- (void)closeItemPress
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)autoItemPress
{
    [cardNoField resignFirstResponder];
    [cardNameField resignFirstResponder];
    [infoPanel showPanelInView:self.view type:infoPanelTypeInfo title:@"提示" subTitle:@"驗證中，請稍候" hideAfter:3];
    [downloadProcess startGetStoreWithRefreshing:YES];
}
- (void)resetItemPress
{
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey: sylinCardNo];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey: sylinCardName];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey: sylinCardType];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey: sylinCardExpireDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
    cardAuthInd = NO;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self createBarButton];
}

@end
