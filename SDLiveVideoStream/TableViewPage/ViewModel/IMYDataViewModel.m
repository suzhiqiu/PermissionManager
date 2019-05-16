//
//  IMYDataViewModel.m
//  SDLiveVideoStream
//
//  Created by suzhiqiu on 2019/5/15.
//  Copyright © 2019 suzq. All rights reserved.
//

#import "IMYDataViewModel.h"
#import "FHWStudentCell.h"
#import "FHWTeacherCell.h"

@implementation IMYDataViewModel

-(instancetype)init{
    if(self=[super init]){
        
    }
    return self;
}

/*正常请求数据返回*/
-(void)getData{
    NSMutableArray *dataArray= [[NSMutableArray  alloc] init];
    IMYStudent  *student = [[IMYStudent alloc] init];
    IMYTeacher  *tech = [[IMYTeacher alloc] init];
    student.type=Type_Student;
    student.name=@"我是学生";
    tech.type=Type_Teacher;
    tech.name=@"我是老师";
    [dataArray addObject:student];
    [dataArray addObject:tech];
    self.dataArray=[dataArray copy];
}

/*number of section*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
/*number of row*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
/*height*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

/*cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<IMYItemProtocol>  model= self.dataArray[indexPath.row];
    UITableViewCell *cell =nil;
    switch (model.type) {
        case Type_Student:{
            FHWStudentCell *studetnCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FHWStudentCell class]) forIndexPath:indexPath];
            [studetnCell setModel:model];
            cell=studetnCell;
        }
            break;
        case Type_Teacher:{
            FHWTeacherCell *teacherCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FHWTeacherCell class]) forIndexPath:indexPath];
            [teacherCell setModel:model];
            cell=teacherCell;
        }
            break;
    }
    return cell;
}

/*cell click*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row:%ld",indexPath.row);
}

@end
