//
//  FHWSecretViewController.m
//  fanhuanwang
//
//  Created by suzq on 2019/4/25.
//  Copyright © 2019 lgfz. All rights reserved.
//

#import "FHWSecretViewController.h"
#import "FHWSecretCell.h"
#import "FHWSecretModel.h"
#import "FHWSettingManager.h"
#import "LBXPermissionLocation.h"
#import "LBXPermissionCamera.h"
#import "LBXPermissionPhotos.h"
#import "LBXPermissionCalendar.h"
#import "LBXPermissionMicrophone.h"
#import "YYText.h"
#import "SVWebViewController.h"


@interface FHWSecretViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemGroups;//copy
    
@end

@implementation FHWSecretViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareUI];
    [self prepareData];
    [self registerNotify];
}
-(void)prepareUI{
    self.navigationItem.title = @"隐私设置";
    //tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColorFromRGB(0xf3f4f5);
    self.tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVBAR_HIGHT);
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[FHWSecretCell class] forCellReuseIdentifier:NSStringFromClass([FHWSecretCell class])];
    //
    UIView *headeView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableView.tableHeaderView=headeView;
}

-(void)prepareData{
    self.itemGroups=[[NSMutableArray alloc] init];
    FHWSecretModel *model1 = [[FHWSecretModel alloc] init];
    model1.title=@"开启地理位置定位";
    model1.detail=@"进行营销活动时防止刷单。关于";
    model1.detailHighLight=@"《位置信息》";
    model1.type=SecretType_Location;
    
    NSString *targetName=@"QQ";
    
    FHWSecretModel *model2 = [[FHWSecretModel alloc] init];
    model2.title= [NSString stringWithFormat:@"允许%@访问相机",targetName];
    model2.detail=@"用于设置头像。关于";
    model2.detailHighLight=@"《访问相机》";
    model2.type=SecretType_Camera;
    
    FHWSecretModel *model3 = [[FHWSecretModel alloc] init];
    model3.title=[NSString stringWithFormat:@"允许%@访问相册",targetName];
    model3.detail=@"用于设置头像。关于";
    model3.detailHighLight=@"《访问相册》";
    model3.type=SecretType_Photo;
    
    FHWSecretModel *model4 = [[FHWSecretModel alloc] init];
    model4.title=[NSString stringWithFormat:@"允许%@访问日历",targetName];
    model4.detail=@"用于大促活动的提醒。关于";
    model4.detailHighLight=@"《访问日历》";
    model4.type=SecretType_Calendar;
    
    FHWSecretModel *model5 = [[FHWSecretModel alloc] init];
    model5.title=[NSString stringWithFormat:@"允许%@访问音频",targetName];
    model5.detail=@"与客服联系时使用。关于";
    model5.detailHighLight=@"《语音信息》";
    model5.type=SecretType_Voice;
    
    [self.itemGroups addObject:model1];
    [self.itemGroups addObject:model2];
    [self.itemGroups addObject:model3];
    [self.itemGroups addObject:model4];
    [self.itemGroups addObject:model5];
    
    [self refreshAuthStauts];
}
-(void)registerNotify{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAuthStauts) name:UIApplicationDidBecomeActiveNotification object:nil];
}
/*重新刷新状态*/
-(void)refreshAuthStauts{
    for(NSInteger i=0;i<self.itemGroups.count;i++){
        FHWSecretModel *model = self.itemGroups[i];
        switch (model.type) {
            case SecretType_Location:{
                model.bOpen= [LBXPermissionLocation authorized];
            }
                break;
            case SecretType_Camera:{
                model.bOpen= [LBXPermissionCamera authorized];
            }
                break;
            case SecretType_Photo:{
                model.bOpen= [LBXPermissionPhotos authorized];
            }
                break;
            case SecretType_Calendar:{
                model.bOpen= [LBXPermissionCalendar authorized];
            }
                break;
            case SecretType_Voice:{
                model.bOpen= [LBXPermissionMicrophone authorized];
            }
                break;
            default:
                break;
        }
    }
    [self.tableView reloadData];
}

/*number of section*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.itemGroups count];
}
/*number of row*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(self.itemGroups.count>0){
        return 41;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 41)];
    YYLabel *label = [[YYLabel alloc] init];

    FHWSecretModel *model=self.itemGroups[section];
    NSString *content=[NSString stringWithFormat:@"%@%@",model.detail,model.detailHighLight];
    CGFloat hightLightCount=[model.detailHighLight length];
    NSRange range=NSMakeRange(content.length-hightLightCount,hightLightCount);
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:content];
    text.yy_font=[UIFont systemFontOfSize:12];
    text.yy_color=UIColorFromRGB(0x999999);
    __block NSString *type=[NSString stringWithFormat:@"%ld",(long)model.type];
    @weakify(self);
    [text yy_setTextHighlightRange:range color:UIColorFromRGB(0x37BFE) backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        @strongify(self);
        [self clickCommonShareView:type];

    }];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(10);
        make.left.mas_equalTo(view).offset(15);
    }];
    label.attributedText = text;
    
    return view;
}
    /*height*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [FHWSecretCell cellHeight];
}
    /*cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FHWSecretCell * cell= [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FHWSecretCell class])];
    FHWSecretModel *model=self.itemGroups[indexPath.section];
    [cell setModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
/*cell click*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    FHWSecretModel *model=self.itemGroups[indexPath.section];
    if(model.bOpen){//已经开启直接跳转设置页面
        [FHWSettingManager openSettingPage];
        return;
    }
    switch (model.type) {
        case SecretType_Location:{
            @weakify(self);
            [LBXPermissionLocation authorizeWithCompletion:^(BOOL granted, BOOL firstTime) {
                @strongify(self);
                [self authComplete:model grant:granted frist:firstTime];
            }];
        }
            break;
        case SecretType_Camera:{
            @weakify(self);
            [LBXPermissionCamera authorizeWithCompletion:^(BOOL granted, BOOL firstTime) {
                @strongify(self);
                [self authComplete:model grant:granted frist:firstTime];
            }];
        }
            break;
        case SecretType_Photo:{
            @weakify(self);
            [LBXPermissionPhotos authorizeWithCompletion:^(BOOL granted, BOOL firstTime) {
                @strongify(self);
                [self authComplete:model grant:granted frist:firstTime];
            }];
        }
            break;
        case SecretType_Calendar:{
            @weakify(self);
            [LBXPermissionCalendar authorizeWithCompletion:^(BOOL granted, BOOL firstTime) {
                @strongify(self);
                [self authComplete:model grant:granted frist:firstTime];
            }];
        }
            break;
        case SecretType_Voice:{
            @weakify(self);
            [LBXPermissionMicrophone authorizeWithCompletion:^(BOOL granted, BOOL firstTime) {
                @strongify(self);
                [self authComplete:model grant:granted frist:firstTime];
            }];
        }
            break;
        default:
            break;
    }
}
/*授权完成统一处理*/
-(void)authComplete:(FHWSecretModel *)model grant:(BOOL)granted  frist:(BOOL)firstTime{
    model.bOpen=granted;
    if(!granted && !firstTime){//1.未授权跳转到设置页面去 2.不是第一次 不允许
        [FHWSettingManager openSettingPage];
        return;
    }
    [self.tableView reloadData];
}
    
/*跳转去哪里*/
-(void)clickCommonShareView:(NSString *)type{
    NSString *url=@"https:\\www.baidu.com";
    if(imy_isEmptyString(url)){
        return;
    }
    //添加url type参数 打开不同的页面
//    url=[url imy_appendingURLParams:@{@"type":type}];
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithAddress:url];
    [self.navigationController pushViewController:webViewController animated:YES];

}

    

    

@end
