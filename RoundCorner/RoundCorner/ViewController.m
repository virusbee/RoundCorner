//
//  ViewController.m
//  RoundCorner
//
//  Created by virusbee on 2021/4/23.
//

#import "ViewController.h"
#import "CALayer+RoundCorner.h"
#import "RoundSectionTableViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *emptyView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.button];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.emptyView];
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _contentView.center = self.view.center;
        RCConfiguration *config = [[RCConfiguration alloc] init];
        config.cornerMask = RCCornerMaskAll;
        config.rect = _contentView.bounds;
        config.cornerRadius = 20;
        config.strokeColor = UIColor.redColor.CGColor;
        [_contentView.layer setRoundCorner:config];
    }
    return _contentView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 125)];
        RCConfiguration *config = [[RCConfiguration alloc] init];
        config.cornerMask = RCCornerMaskAll ^ RCCornerMaskMaxXMaxY;
        config.rect = _label.bounds;
        config.cornerRadius = 20;
        config.fillColor = UIColor.redColor.CGColor;
        [_label.layer setRoundCorner:config];
    }
    return _label;
}

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(155, 20, 125, 125)];
        [_button setTitle:@"Touch Me" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(showRoundSectionTableViewController) forControlEvents:UIControlEventTouchUpInside];
        RCConfiguration *config = [[RCConfiguration alloc] init];
        config.cornerMask = RCCornerMaskAll ^ RCCornerMaskMinXMaxY;
        config.rect = _button.bounds;
        config.cornerRadius = 20;
        config.fillColor = UIColor.redColor.CGColor;
        [_button.layer setRoundCorner:config];
    }
    return _button;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 155, 125, 125)];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.placeholder = @"Input";
        RCConfiguration *config = [[RCConfiguration alloc] init];
        config.cornerMask = RCCornerMaskAll ^ RCCornerMaskMaxXMinY;
        config.rect = _textField.bounds;
        config.cornerRadius = 20;
        config.strokeColor = UIColor.redColor.CGColor;
        [_textField.layer setRoundCorner:config];
    }
    return _textField;
}

- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(155, 155, 125, 125)];
        RCConfiguration *config = [[RCConfiguration alloc] init];
        config.cornerMask = RCCornerMaskMaxXMinY | RCCornerMaskMinXMaxY | RCCornerMaskMaxXMaxY;
        config.rect = _emptyView.bounds;
        config.cornerRadius = 20;
        config.strokeColor = UIColor.redColor.CGColor;
        [_emptyView.layer setRoundCorner:config];
    }
    return _emptyView;
}

- (void)showRoundSectionTableViewController {
    RoundSectionTableViewController *vc = [[RoundSectionTableViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
