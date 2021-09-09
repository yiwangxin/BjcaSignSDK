//
//  YWXBaseBusinessViewController.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import "YWXBaseBusinessViewController.h"
#import "Masonry.h"
#import "YWXSignBusinessCell.h"
#import "YWXSignBusinessSectionHeaderView.h"

static NSString *KEnvironmentKeyName = @"serverType";
static NSString *KPhoneNumberKeyName = @"phoneNumber";

@interface YWXBaseBusinessViewController ()<UITableViewDelegate,UITableViewDataSource,YWXSignBusinessSectionHeaderViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation YWXBaseBusinessViewController

-(NSString *)clientId {
    return self.clientInfoView.clientId;
}

-(NSString *)phoneNumber {
    return self.clientInfoView.phoneNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backButtonItem;
    [self initUI];
    [self initData];
    [self.tableView reloadData];
    [self getCurrentEnvironment];
}

-(void)initData {
    self.businessGroupModelArray = [YWXSignBusinessGroupModel businessGroupModelArray];
    [self.clientInfoView inputClientId:@"2015112716143758"];
    [self.clientInfoView inputPhoneNumber:@"18519115509"];
    NSString *phone = [[NSUserDefaults standardUserDefaults] valueForKey:KPhoneNumberKeyName];
    if (phone.length > 0) {
        [self.clientInfoView inputPhoneNumber:phone];
    }
}

-(void)updateFooterInfoWithVersion:(NSString *)version
                       serviceType:(NSInteger)serviceType
                       isExistCert:(BOOL)isExistCert
                       sdkLanguage:(NSString *)sdkLanguage {
    [self.footerView updateInfoWithVersion:version
                               serviceType:serviceType
                               isExistCert:isExistCert
                               sdkLanguage:sdkLanguage];
    self.tableView.tableFooterView = self.footerView;
}

- (void)initUI {
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.clientInfoView];
    [self.clientInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.leading.mas_equalTo(self.view.mas_leading).offset(10);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-10);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.clientInfoView.mas_bottom).offset(10);
        make.leading.mas_equalTo(self.view.mas_leading);
        make.trailing.mas_equalTo(self.view.mas_trailing);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    self.tableView.rowHeight = 44;
    self.tableView.tableFooterView = self.footerView;
}

#pragma mark - tableview delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.businessGroupModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YWXSignBusinessGroupModel *groupModel = self.businessGroupModelArray[section];
    if (groupModel.isShow == YES) {
        return groupModel.businessModelArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YWXSignBusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cee"];
    if (cell == nil) {
        cell = [[YWXSignBusinessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cee"];
    }
    YWXSignBusinessGroupModel *groupModel = self.businessGroupModelArray[indexPath.section];
    YWXSignBusinessModel *model = groupModel.businessModelArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YWXSignBusinessSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headerView == nil) {
        headerView = [[YWXSignBusinessSectionHeaderView alloc] init];
        headerView.delegate = self;
    }
    YWXSignBusinessGroupModel *groupModel = self.businessGroupModelArray[section];
    headerView.groupModel = groupModel;
    return headerView;
}


-(void)sectionHeader:(YWXSignBusinessSectionHeaderView *)sectionHeader didTap:(YWXSignBusinessGroupModel *)groupModel {
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YWXSignBusinessGroupModel *groupModel = self.businessGroupModelArray[indexPath.section];
    YWXSignBusinessModel *model = groupModel.businessModelArray[indexPath.row];
    [self didSelectSignBusiness:model];
}

- (void)didSelectSignBusiness:(YWXSignBusinessModel *)signBusinessModel {
    
    
}

- (void)changeEnvironmentWith:(YWXDemoEnvironment)currentEnvironment {
    NSLog(@"changeEnvironmentWith");
}

-(void)cleanCert {
    
}

- (void)getCurrentEnvironment {
    __weak typeof(self) weakSelf = self;
    [YWXEnvironmentViewController getCurrentEnviromentWithEnvironmentKeyName:KEnvironmentKeyName
                                                      environmentChangeBlack:^(YWXDemoEnvironment currentEnvironment) {
        [weakSelf changeEnvironmentWith:currentEnvironment];
    }];
}

- (void)didClickChangeButton {
    [self cleanCert];
    [self getCurrentEnvironment];
}

- (void)savePhoneNumber {
    [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumber forKey:KPhoneNumberKeyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)cleanPhoneNumber {
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KPhoneNumberKeyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 懒加载
-(YWXClientIdInfoView *)clientInfoView {
    if (_clientInfoView == nil) {
        _clientInfoView = [[YWXClientIdInfoView alloc] init];
        _clientInfoView.layer.cornerRadius = 10;
        _clientInfoView.layer.masksToBounds = YES;
        __weak typeof(self) weakSelf = self;
        _clientInfoView.didClickChange = ^{
            [weakSelf didClickChangeButton];
        };
    }
    return _clientInfoView;
}

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 44;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

-(YWXSignBusinessFooterView *)footerView {
    if (_footerView == nil) {
        _footerView = [[YWXSignBusinessFooterView alloc] init];
    }
    return _footerView;
}

@end
