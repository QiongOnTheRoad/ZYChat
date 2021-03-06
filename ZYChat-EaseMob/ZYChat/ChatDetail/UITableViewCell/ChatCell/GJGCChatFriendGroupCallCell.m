//
//  GJGCChatFriendGroupCallCell.m
//  ZYChat
//
//  Created by ZYVincent QQ:1003081775 on 15/4/16.
//  Copyright (c) 2015年 ZYProSoft.  QQ群:219357847  All rights reserved.
//

#import "GJGCChatFriendGroupCallCell.h"

@interface GJGCChatFriendGroupCallCell ()

@property (nonatomic,strong)GJCFCoreTextContentView *titleLabel;

@property (nonatomic,strong)GJCFCoreTextContentView *contentLabel;

@property (nonatomic,assign)CGFloat contentInnerMargin;

@end

@implementation GJGCChatFriendGroupCallCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentInnerMargin = 11.f;
        CGFloat bubbleToBordMargin = 56;
        CGFloat maxTextContentWidth = GJCFSystemScreenWidth - bubbleToBordMargin - 40 - 3 - 5.5 - 13 - 2*self.contentInnerMargin;
        
        self.bubbleBackImageView.gjcf_width = maxTextContentWidth + 13*2;
        
        self.titleLabel = [[GJCFCoreTextContentView alloc]init];
        self.titleLabel.gjcf_left = self.contentInnerMargin;
        self.titleLabel.gjcf_size = CGSizeMake(maxTextContentWidth, 10);
        self.titleLabel.contentBaseSize = self.titleLabel.gjcf_size;
        [self.bubbleBackImageView addSubview:self.titleLabel];

        self.contentLabel = [[GJCFCoreTextContentView alloc]init];
        self.contentLabel.gjcf_size = CGSizeMake(maxTextContentWidth, 10);
        self.contentLabel.contentBaseSize = self.contentLabel.gjcf_size;
        self.contentLabel.gjcf_left = self.titleLabel.gjcf_left;
        [self.bubbleBackImageView addSubview:self.contentLabel];
        
    }
    return self;
}

- (UIImage *)bubbleBackImage
{
    UIImage *originImage = [UIImage imageNamed:@"群主召唤-bg-card"];
    
    CGFloat centerX = originImage.size.width/2;
    CGFloat centerY = originImage.size.height/2;
    
    CGFloat top = centerY - 2;
    CGFloat bottom = centerY + 2;
    CGFloat left = centerX - 2;
    CGFloat right = centerX + 2;
    
    UIImage *stretchImage = GJCFImageResize(originImage, top, bottom, left, right);
    
    return stretchImage;
}

- (void)setContentModel:(GJGCChatContentBaseModel *)contentModel
{
    if (!contentModel) {
        return;
    }
    
    [super setContentModel:contentModel];
    
    GJGCChatFriendContentModel *chatContentModel = (GJGCChatFriendContentModel *)contentModel;
  
    /* 重设置大小 */
    self.titleLabel.gjcf_size = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:chatContentModel.summonTitleString forBaseContentSize:self.titleLabel.contentBaseSize];
    self.titleLabel.contentAttributedString = chatContentModel.summonTitleString;
    self.titleLabel.gjcf_top = (76/2 - self.titleLabel.gjcf_height)/2 - 2;

    self.contentLabel.gjcf_size = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:chatContentModel.summonContentString forBaseContentSize:self.contentLabel.contentBaseSize];
    self.contentLabel.gjcf_top = 76/2 + self.contentInnerMargin - 7;
    self.contentLabel.contentAttributedString = chatContentModel.summonContentString;

    self.bubbleBackImageView.gjcf_height = self.contentLabel.gjcf_bottom + self.contentInnerMargin;
    
    /* 重设背景图片 */
    self.bubbleBackImageView.image = [self bubbleBackImage];
    
    if (self.isFromSelf) {
        
        /* 头像矫正 */
        self.headView.gjcf_right = GJCFSystemScreenWidth - self.contentBordMargin ;
        self.bubbleBackImageView.gjcf_right = self.headView.gjcf_left - self.contentBordMargin + 5;
        
    }else{
        
        /* 头像矫正 */
        self.headView.gjcf_left = self.contentBordMargin;
    }
    
    if (self.isGroupChat && !self.isFromSelf) {
        
        self.nameLabel.gjcf_top = 0.f;
        self.nameLabel.hidden = NO;
        self.nameLabel.gjcf_left = self.headView.gjcf_right + self.contentBordMargin;
        self.bubbleBackImageView.gjcf_left = self.nameLabel.gjcf_left - 5;
        self.headView.gjcf_top = 0.f;
        self.bubbleBackImageView.gjcf_top = self.nameLabel.gjcf_bottom + 3;
        
    }else{
        
        self.headView.gjcf_top = 0.f;
        self.nameLabel.hidden = YES;
        self.bubbleBackImageView.gjcf_top = self.headView.gjcf_top;
        
    }
}


@end
