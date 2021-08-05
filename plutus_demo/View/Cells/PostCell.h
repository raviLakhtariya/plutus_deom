//
//  PostCell.h
//  plutus_demo
//
//  Created by ravi lakhtariya on 05/08/21.
//

#import <UIKit/UIKit.h>
#import "PostModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    PostModel *postModel;
}
@property (copy, nonatomic) void (^didTapButtonBlock)(id sender);
@property (copy, nonatomic) void (^didTapButtonImageBlock)(id sender);
@property (weak, nonatomic) IBOutlet UILabel *postName;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *txtInput;
@property (weak, nonatomic) IBOutlet UIButton *btnAddImg;
@property (weak, nonatomic) IBOutlet UIButton *addComment;
@property (weak, nonatomic) IBOutlet UIView *commentView;

@property (weak, nonatomic) IBOutlet UIView *postView;
@property (weak, nonatomic) IBOutlet UIView *parentCollectionView;

- (void)setDidTapCommentButtonBlock:(void (^)(id sender))didTapButtonBlock;
- (void)setDidTapImageButtonBlock:(void (^)(id sender))didTapButtonImageBlock;

-(void)setConfigure:(PostModel*) model;
@end

NS_ASSUME_NONNULL_END
