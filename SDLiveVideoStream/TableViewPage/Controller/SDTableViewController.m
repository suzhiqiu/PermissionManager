//
//  SDTableViewController.m
//  SDLiveVideoStream
//
//  Created by suzq on 2018/3/2.
//  Copyright © 2018年 suzq. All rights reserved.
//

#import "SDTableViewController.h"
#import "IMYDataViewModel.h"
#import "FHWStudentCell.h"
#import "FHWTeacherCell.h"


@interface SDTableViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) IMYDataViewModel *dataViewModel;

@end

@implementation SDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self  initSubView];
}

-(void)initSubView
{
    //tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
 
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.tableView registerClass:[FHWStudentCell class] forCellReuseIdentifier:[FHWStudentCell identifier]];
    [self.tableView registerClass:[FHWTeacherCell class] forCellReuseIdentifier:[FHWTeacherCell identifier]];

    self.dataViewModel =[[IMYDataViewModel alloc] init];
    
    self.tableView.delegate=self.dataViewModel;
    self.tableView.dataSource=self.dataViewModel;
    
    [self.dataViewModel getData];
    [self.tableView reloadData];
}





@end
