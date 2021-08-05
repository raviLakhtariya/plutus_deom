//
//  PostCell.m
//  plutus_demo
//
//  Created by ravi lakhtariya on 05/08/21.
//

#import "PostCell.h"
#import "PostModel.h"
#import "ImageCollectionCell.h"
@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _commentView.layer.cornerRadius = 5.0;
    _postView.layer.cornerRadius = 5.0;
    _commentView.backgroundColor = UIColor.systemGray5Color;
    _postView.backgroundColor = UIColor.systemGray5Color;
//    _commentView.layer.borderColor = UIColor.blackColor.CGColor;
//    _postView.layer.borderColor = UIColor.blackColor.CGColor;
//    _commentView.layer.borderWidth = 0.5;
//    _postView.layer.borderWidth = 0.5;
    [self.btnAddImg addTarget:self action:@selector(didImageTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.addComment addTarget:self action:@selector(didCommentTapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UINib *nib = [UINib nibWithNibName:@"ImageCollectionCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"ImageCollectionCell"];
  
    // Initialization code
}
-(void)setConfigure:(PostModel*) model{
    postModel = model;
    [_postView setHidden:NO];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.reloadData;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didImageTapButton:(id)sender {
    if (self.didTapButtonImageBlock)
    {
        self.didTapButtonImageBlock(sender);
    }
}

- (void)didCommentTapButton:(id)sender {
    if (self.didTapButtonBlock)
    {
        self.didTapButtonBlock(sender);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return postModel.image.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCollectionCell * cell = (ImageCollectionCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionCell" forIndexPath:indexPath];
    NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"ImageCollectionCell" owner:self options:nil];
    NSString *object = [postModel.image objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:object];
       NSData *imageData = [NSData dataWithContentsOfURL:url];
       UIImage *image = [UIImage imageWithData:imageData];
    
    cell.imgView.image = image;
    return  cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((_collectionView.frame.size.width / 3), (_collectionView.frame.size.width / 3));
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}


@end
