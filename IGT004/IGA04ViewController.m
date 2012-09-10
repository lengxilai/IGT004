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
        // Custom initialization
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
            textLable.text = @"@i果儿网";
        }else if(indexPath.row == 2){
            titleLabel.text = @"推荐:";
            textLable.text = @"推荐给朋友";
        }else if(indexPath.row == 3){
            titleLabel.text = @"评价:";
            textLable.text = @"给我们评价";
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
        if (indexPath.row == 0) return 80.0f;
        if (indexPath.row == 1) return 80.0f;
    }
    
    return 0.0f;
}
//更多应用
-(void)getTripAppPanel:(UIView *)moreAppPanel withRow:(int)row{
    moreAppPanel.tag = 99;
    UIImageView *moreAppImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 57, 57)];
    [moreAppPanel addSubview:moreAppImageView];
    
    UILabel *appTravelTitle = [[UILabel alloc]initWithFrame:CGRectMake(72, 5, 150, 20)];
    
    appTravelTitle.backgroundColor = [UIColor clearColor];
    [appTravelTitle setFont:[UIFont systemFontOfSize:18.0]];
    appTravelTitle.textColor = [UIColor whiteColor];
    [moreAppPanel addSubview:appTravelTitle];
    
    UILabel *appTravelMemo = [[UILabel alloc]initWithFrame:CGRectMake(72, 25, 200, 40)];
    appTravelMemo.lineBreakMode = UILineBreakModeWordWrap;
    appTravelMemo.numberOfLines = 0;
    
    appTravelMemo.backgroundColor = [UIColor clearColor];
    [appTravelMemo setFont:[UIFont systemFontOfSize:12.0]];
    appTravelMemo.textColor = [UIColor whiteColor];
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
    //return moreAppPanel;
}
@end
