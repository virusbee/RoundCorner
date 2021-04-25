//
//  RoundSectionTableViewController.m
//  RoundCorner
//
//  Created by virusbee on 2021/4/23.
//

#import "RoundSectionTableViewController.h"
#import "CALayer+RoundCorner.h"

@interface RoundSectionTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray *> *data;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation RoundSectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:self.tableView];
    self.data = @[
        @[@"The Shawshank Redemption"],
        @[@"Farewell My Concubine", @"Forrest Gump", @"Léon"],
        @[@"Titanic", @"La vita è bella", @"Schindler's List", @"Hachi: A Dog's Tale"]
    ];
    self.titles = @[@"Top 1", @"Top 2-4", @"Top 5-8"];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(20, 20, 20, 20)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data[section].count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titles[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.data[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    RCConfiguration *config = [[RCConfiguration alloc] init];
    config.cornerMask = [self tableView:tableView cornerMaskForIndexPath:indexPath];
    config.rect = cell.bounds;
    config.cornerRadius = 10;
    config.fillColor = UIColor.whiteColor.CGColor;
    config.strokeColor = nil;
    [cell.contentView.layer setRoundCorner:config];
}

- (RCCornerMask)tableView:(UITableView *)tableView cornerMaskForIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastRow = [tableView numberOfRowsInSection:indexPath.section] - 1;
    if (indexPath.row == 0 && indexPath.row == lastRow) {
        return RCCornerMaskAll;
    } else if (indexPath.row == 0) {
        return RCCornerMaskMinXMinY | RCCornerMaskMaxXMinY;
    } else if (indexPath.row == lastRow) {
        return RCCornerMaskMinXMaxY | RCCornerMaskMaxXMaxY;
    } else {
        return 0;
    }
}

@end
