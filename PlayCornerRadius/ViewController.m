//
//  ViewController.m
//  PlayCornerRadius
//
//  Created by 肖文 on 2017/1/18.
//  Copyright © 2017年 肖文. All rights reserved.
//

#import "ViewController.h"
#import "UIView+XWAddForRoundedCorner.h"
#import "YYWebImage.h"
#import "YYFPSLabel.h"

CGFloat XWScreenWidthRatio(){
    static CGFloat ratio;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ratio = [UIScreen mainScreen].bounds.size.width / 375.0f;
    });
    return ratio;
}

#define widthRatio(_f_) (_f_) * XWScreenWidthRatio()

static inline CGSize XWSizeMake(CGFloat width, CGFloat height){
    CGSize size; size.width = widthRatio(width); size.height = widthRatio(height); return size;
}

static inline CGPoint XWPointMake(CGFloat x, CGFloat y){
    CGPoint point; point.x = widthRatio(x); point.y = widthRatio(y); return point;
}

static inline CGRect XWRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
    CGRect rect;
    rect.origin.x = widthRatio(x); rect.origin.y = widthRatio(y);
    rect.size.width = widthRatio(width); rect.size.height = widthRatio(height);
    return rect;
}

@interface XWTestRoundedCell : UITableViewCell

+ (XWTestRoundedCell *)xw_cellWithTableView:(__weak UITableView *)tableView imageURL:(NSString *)imageURL;

@end

@implementation XWTestRoundedCell{
    __weak UITableView *_tableView;
    UIView *_headerView;
    UIView *_nameLabel;
    UILabel *_aLabel;
    UIColor *_backColor;
    NSMutableArray<UIView *> *_circles;
}

+ (XWTestRoundedCell *)xw_cellWithTableView:(UITableView *__weak)tableView imageURL:(NSString *)imageURL{
    static NSString *identifier = @"XWTestRoundedCellIdentifier";
    XWTestRoundedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[XWTestRoundedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell->_tableView = tableView;
        [cell _xw_initailizeUI];
    }
    [cell _xw_updateWithURL:imageURL];
    return cell;
}

- (void)_xw_initailizeUI{
    UIColor *backColor = [UIColor whiteColor];
    _backColor = backColor;
    self.contentView.backgroundColor = backColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layer.opaque = YES;
    _headerView = ({
        UIView *headerView = [UIView new];
        headerView.layer.opaque = YES;
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.bounds = XWRectMake(0, 0, 100, 100);
        headerView.center = XWPointMake(55, 60);
        headerView.layer.contentsGravity = kCAGravityResizeAspectFill;
        headerView.layer.masksToBounds = YES;
        [headerView xw_roundedCornerWithCornerRadii:XWSizeMake(40, 40) cornerColor:backColor corners:UIRectCornerAllCorners borderColor:[UIColor redColor] borderWidth:widthRatio(2)];
        [self.contentView addSubview:headerView];
        headerView;
    });
    
    _nameLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:widthRatio(9)];
        label.text = @"wazrx";
        label.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.layer.opaque = YES;
        label.layer.masksToBounds = YES;
        label.bounds = XWRectMake(0, 0, 80, 20);
        label.center = XWPointMake(50, 90);
        [_headerView addSubview:label];
        label;
    });
    _aLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:widthRatio(14)];
        label.text = @"这是测试文字";
        label.backgroundColor = [UIColor redColor];
        label.textColor = [UIColor blackColor];
        label.textAlignment = 1;
        label.layer.masksToBounds = YES;
        label.layer.opaque = YES;
        label.bounds = XWRectMake(0, 0, 150, 30);
        label.center = XWPointMake(200, 60);
        [label xw_roundedCornerWithRadius:widthRatio(15) cornerColor:backColor corners:UIRectCornerTopLeft | UIRectCornerBottomRight];
        [self.contentView addSubview:label];
        label;
    });
    
    _circles = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 10; i ++) {
        UIView *littleCircle = [UIView new];
        littleCircle.layer.opaque = YES;
        littleCircle.backgroundColor = [UIColor blueColor];
        littleCircle.bounds = XWRectMake(0, 0, 15, 15);
        littleCircle.center = XWPointMake(110 + 7.5 + 20 * i, 30);
        [littleCircle xw_roundedCornerWithRadius:widthRatio(7.5) cornerColor:backColor];
        [self.contentView addSubview:littleCircle];
        [_circles addObject:littleCircle];
    }
}

- (void)_xw_updateWithURL:(NSString *)imageURL{
    [_headerView.layer yy_setImageWithURL:[NSURL URLWithString:imageURL] options:YYWebImageOptionSetImageWithFadeAnimation];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if (self.selected == selected) return;
    [self _xw_colorWithSelectedorHighlighted:selected];
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if (self.selected) return;
    if (self.highlighted == highlighted) return;
    [self _xw_colorWithSelectedorHighlighted:highlighted];
    [super setHighlighted:highlighted animated:animated];
}

- (void)_xw_colorWithSelectedorHighlighted:(BOOL)flag{
    UIColor *color = flag ? [UIColor lightGrayColor] : _backColor;
    self.contentView.backgroundColor = color;
    [_headerView xw_roundedCornerWithCornerRadii:XWSizeMake(40, 40) cornerColor:color corners:UIRectCornerAllCorners borderColor:[UIColor redColor] borderWidth:widthRatio(2)];
    [_aLabel xw_roundedCornerWithRadius:widthRatio(15) cornerColor:color corners:UIRectCornerTopLeft | UIRectCornerBottomRight];
    [_circles enumerateObjectsUsingBlock:^(UIView * _Nonnull littleCircle, NSUInteger idx, BOOL * _Nonnull stop) {
        [littleCircle xw_roundedCornerWithRadius:widthRatio(7.5) cornerColor:color];
    }];
}

@end

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [UITableView new];
    tableView.rowHeight = widthRatio(120);
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.frame = self.view.bounds;
    [self.view addSubview:tableView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [YYFPSLabel xw_addFPSLableOnWidnow];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [XWTestRoundedCell xw_cellWithTableView:tableView imageURL:[NSString stringWithFormat:@"https://oepjvpu5g.qnssl.com/avatar%zd.jpg", indexPath.row % 20]];
}

@end
