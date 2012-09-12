//
//  IGA04ViewController.m
//  IGT004
//
//  Created by wang chong on 12-9-10.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGA04ViewController.h"

@interface IGA04ViewController ()

@end

@implementation IGA04ViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        [self.view setBackgroundColor:[UIColor colorWithHex:0xefefef alpha:1.0]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    // Custom initialization
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 4;
    else if (section == 1) return 2;
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *cellID = @"IGA04TableViewCell";
    cell = [tView dequeueReusableCellWithIdentifier:@"SwitchCell"];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    if (indexPath.section == 0)
    {

        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 38, 25)];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        titleLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:titleLabel];
        
        UILabel *textLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 25)];
        textLable.textColor = [UIColor blackColor];
        textLable.backgroundColor = [UIColor clearColor];
        textLable.font = [UIFont fontWithName:@"Helvetica" size:14];
        [cell.contentView addSubview:textLable];
        if(indexPath.row == 0){
            titleLabel.text = @"邮箱:";
            textLable.text = @"iguorhelp@163.com";
        }else if(indexPath.row == 1){
            titleLabel.text = @"微博:";
            textLable.text = @"@i果儿网(新浪)";
        }else if(indexPath.row == 2){
            titleLabel.text = @"推荐:";
            textLable.text = @"推荐给朋友";
        }else if(indexPath.row == 3){
            titleLabel.text = @"评价:";
            textLable.text = @"打个分呗。";
        }
    }
    else if (indexPath.section == 1)
    {
        [self getTripAppPanel:cell.contentView withRow:indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return 40.0f;
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0) return 70.0f;
        if (indexPath.row == 1) return 70.0f;
    }
    
    return 0.0f;
}
//更多应用
-(void)getTripAppPanel:(UIView *)moreAppPanel withRow:(int)row{
    moreAppPanel.tag = 99;
    UIImageView *moreAppImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 57, 57)];
    [moreAppPanel addSubview:moreAppImageView];
    
    UILabel *appTravelTitle = [[UILabel alloc]initWithFrame:CGRectMake(72, 8, 150, 20)];
    
    appTravelTitle.backgroundColor = [UIColor clearColor];
    [appTravelTitle setFont:[UIFont systemFontOfSize:18.0]];
    appTravelTitle.textColor = [UIColor blackColor];
    [moreAppPanel addSubview:appTravelTitle];
    
    UILabel *appTravelMemo = [[UILabel alloc]initWithFrame:CGRectMake(72, 25, 200, 40)];
    appTravelMemo.lineBreakMode = UILineBreakModeWordWrap;
    appTravelMemo.numberOfLines = 0;
    
    appTravelMemo.backgroundColor = [UIColor clearColor];
    [appTravelMemo setFont:[UIFont systemFontOfSize:12.0]];
    appTravelMemo.textColor = [UIColor blackColor];
    [moreAppPanel addSubview:appTravelMemo];
    
    if(row == 0){
        moreAppImageView.image = [UIImage imageNamed:@"tripcheckericon.png"];
        appTravelTitle.text = NSLocalizedString(@"差旅备忘", @"差旅备忘");
        appTravelMemo.text = NSLocalizedString(@"帮您检查出差旅行的行李列表，\n从此解放您的大脑！", @"帮您检查出差旅行的行李列表，\n从此解放您的大脑！");
    }else if(row == 1){
        moreAppImageView.image = [UIImage imageNamed:@"tenyeardiaryicon.png"];
        appTravelTitle.text = NSLocalizedString(@"十年微日记", @"十年微日记");
        appTravelMemo.text = NSLocalizedString(@"将10年中的每一天写在一页，\n每一页记录了10年中的同一天！", @"将10年中的每一天写在一页，\n每一页记录了10年中的同一天！");
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] init];
    
    UILabel *sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, 200, 32)];
    sectionTitle.font = [UIFont systemFontOfSize:16];
    sectionTitle.backgroundColor = [UIColor clearColor];
    if (section == 0) {
        sectionTitle.text = NSLocalizedString(@"关于我们&评价", @"关于我们&评价");
        sectionTitle.textColor = [UIColor grayColor];
    }else {
        sectionTitle.text = NSLocalizedString(@"更多应用", @"更多应用");
        sectionTitle.textColor = [UIColor grayColor];
    }
    [sectionView addSubview:sectionTitle];

    return sectionView;
}
// 点击cell事件的响应规则
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    
    if(indexPath.section == 0){
        //第一个section
        
        if(indexPath.row == 0){
            mailType = 1;
            [self sendMail];
        }
        else if(indexPath.row == 1){
            [self go2Weibo];
        }
        else if(indexPath.row == 2){
            mailType = 2;
            [self sendMail];
            //[self go2DownloadApp:DAIRY_APP_ID];
        }
        else if(indexPath.row == 3){
            [self go2CommentApp];
        }
        
    }else if(indexPath.section == 1){
        //第二个secion
        if(indexPath.row == 0){
            [self go2DownloadApp:TRIP_APP_ID];
        }
        else if(indexPath.row == 1){
            [self go2DownloadApp:DAIRY_APP_ID];
        }
    }
}
#pragma mark - send mail
// 点击发送邮件按钮
-(void)sendMail
{   
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		if ([mailClass canSendMail])
		{
			MFMailComposeViewController *mailView = [self createMailToConnectUs];
            mailView.mailComposeDelegate = self;
            [window.rootViewController presentModalViewController:mailView animated:YES];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
}
// 发送邮件的后处理
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	// 邮件发送提示信息
    NSString *message = nil;
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	switch (result)
	{
		case MFMailComposeResultCancelled:
            [window.rootViewController dismissModalViewControllerAnimated:YES];
			break;
		case MFMailComposeResultSaved:
			message = NSLocalizedString(@"邮件保存成功",@"邮件保存成功");
			break;
		case MFMailComposeResultSent:
			message = NSLocalizedString(@"邮件发送成功",@"邮件发送成功");
			break;
		case MFMailComposeResultFailed:
			message = NSLocalizedString(@"邮件发送失败",@"邮件发送失败");
			break;
		default:
			message = NSLocalizedString(@"邮件发送失败",@"邮件发送失败");
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
    if(message != nil){
        UIAlertView* alertMessage = [[UIAlertView alloc] 
                                     initWithTitle:NSLocalizedString(@"邮件提示",@"邮件提示")
                                     message:message   
                                     delegate:self
                                     cancelButtonTitle:NSLocalizedString(@"完成", @"")
                                     otherButtonTitles:nil];
        [alertMessage show]; 
    }
}

// 创建邮件
-(MFMailComposeViewController*)createMailToConnectUs
{
    MFMailComposeViewController *mailView = [self createMailFrom];
    // 设置邮件主题
    NSString *titileName = NSLocalizedString(@"关于蕃茄工作法", @"关于蕃茄工作法");  
    [mailView setSubject:titileName];
    NSArray *toRecipients = [NSArray arrayWithObject: @"iguorhelp@163.com"];  
    
    [mailView setToRecipients: toRecipients];  
    // 设置邮件正文
    if(mailType == 1){
        [mailView setMessageBody:[self getEmailBodyToConnectUs] isHTML:NO];
    }else if(mailType == 2){
         [mailView setMessageBody:[self getEmailBodyToFriend] isHTML:NO];
    }
    return mailView;
}

-(NSMutableString *)getEmailBodyToConnectUs{
    
    // 邮件正文
	NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@""];
    [emailBody appendString:@"\n\n感谢您联系我们，我们会尽快回复您的建议和意见\n"];
    [emailBody appendString:@"i果儿网(www.iguor.com)"];
    return emailBody;
}

-(NSMutableString *)getEmailBodyToFriend{
    
    // 邮件正文
	NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@""];
    [emailBody appendString:@"\n\n我给你推荐个软件啊？你用没用过舌尖上的大连\n"];
    [emailBody appendString:@"大连哪好歹上面全有，不好歹的一个都没有\n"];
    [emailBody appendString:@"你赶紧下一个吧\n"];
    [emailBody appendString:@"appstore下载地址是："];
    return emailBody;
}

// 如果不支持MFmail的情况下直接调用系统邮件
-(void)launchMailAppOnDevice
{
	NSString *recipients = [NSString stringWithFormat:@"mailto:?subject=%@",NSLocalizedString(@"关于蕃茄工作法", @"关于蕃茄工作法")];
	NSString *body = [NSString stringWithFormat:@"&body="];
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

// 创建邮件发送窗口
-(MFMailComposeViewController *)createMailFrom{
    
    MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
    return mailView;
}
// 返回发邮件的表情文字
-(NSString*)getMailImageName{
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 5) {
        return @"\U0001F4E9";
        
    }else {
        return @"\uE103";
    }
}

// 按钮点击去评论页面
-(void)go2CommentApp{
    NSString *str = [NSString stringWithFormat: 
                     @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",APPID];  
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
// 去下载画面
-(void)go2DownloadApp:(int) appId{
    NSString *str = [NSString stringWithFormat: 
                     @"itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%d", 
                     appId];   
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
// 去微博
-(void)go2Weibo{
    NSString *str = [NSString stringWithFormat: 
                     @"http://e.weibo.com/iguorvip"];  
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end
