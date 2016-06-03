//
//  JJRadioListCell.m
//  NewProject
//
//  Created by 金晓浩 on 16/5/14.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJRadioListCell.h"

@implementation JJRadioListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImage];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.lineView];
        
        [self layoutFrame];
        
    }
    return self;
}


- (void)layoutFrame
{
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.mas_equalTo(60);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImage.mas_top);
        make.left.equalTo(_iconImage.mas_right).offset(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left);
        make.right.mas_equalTo(-10);
        make.top.equalTo(_iconImage.mas_bottom).offset(10);
        make.height.mas_equalTo(0.5);
        
    }];
    
    
}

- (UIImageView *)iconImage
{
    if (!_iconImage) {
        UIImageView *imageView = [[UIImageView alloc]init];
        _iconImage = imageView;
    }
    return _iconImage;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.numberOfLines = 0;
      
   
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
