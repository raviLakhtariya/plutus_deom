//
//  ViewController.m
//  plutus_demo
//
//  Created by ravi lakhtariya on 05/08/21.
//

#import "ViewController.h"
#import "PostCell.h"
#import "PostModel.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSIndexPath * selecteIndexPath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
    arrayPost = [[NSMutableArray alloc]init];
    UINib *nib = [UINib nibWithNibName:@"PostCell" bundle:nil];
    [_tblView registerNib:nib forCellReuseIdentifier:@"PostCell"];
}

-(void) initialSetup{
    
    UIImage *image = [[UIImage imageNamed:@"addIcon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * customBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(addNewPost:)];
    [self.navigationItem setRightBarButtonItem:customBtn];

}

-(void)addNewPost:(id)sender {
    PostModel *post = [[PostModel alloc]init];
    post.name = @"";//[NSString stringWithFormat:@"%i", (arrayPost.count + 1)];
    post.commentHidden = YES;
    [arrayPost addObject:post];
    _tblView.delegate = self;
    _tblView.dataSource = self;
    [_tblView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayPost.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostCell * cell = (PostCell *)[_tblView dequeueReusableCellWithIdentifier:@"PostCell"];
    NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"PostCell" owner:self options:nil];
    PostModel *object = [[PostModel alloc] init];
    object = [arrayPost objectAtIndex:indexPath.row];
    if(cell == nil){
       cell = nibs[0];
    }
    
    cell.postName.text = object.name;
    [cell.postView setHidden:object.commentHidden];
        
    cell.btnAddImg.tag = indexPath.row;
    cell.addComment.tag = indexPath.row;
    cell.didTapButtonImageBlock = ^(id  _Nonnull sender) {
        self->selecteIndexPath = indexPath;
        [self pickImage];
    };
    
    cell.didTapButtonBlock = ^(id  _Nonnull sender) {

        if (cell.txtInput.text && cell.txtInput.text.length > 0)
        {
            cell.postName.text = cell.txtInput.text;
            object.name = cell.txtInput.text;
            if(object.image.count > 0){
                
                [cell.collectionView reloadData];
            }else{
                [cell.parentCollectionView setHidden:YES];
            }
            object.commentHidden = NO;
            [arrayPost replaceObjectAtIndex:indexPath.row withObject:object];
            
            _tblView.reloadData;
            
            [cell.postView setHidden: NO];
            [cell.txtInput setEnabled:NO];
            [cell.btnAddImg setEnabled:NO];
            NSLog(@"ISDisabled");
            
        }
        else
        {
            if(object.image.count > 0){
                
                [cell.collectionView reloadData];
            }else{
                [cell.parentCollectionView setHidden:YES];
            }
            object.commentHidden = YES;
            [cell.postView setHidden: YES];
        }
    };
    return cell;
}





- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)pickImage{
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePicker setAllowsEditing:false];
    [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *image2 = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImagePNGRepresentation(image2);
    NSString * base64String = [imageData base64EncodedStringWithOptions:0];
    [self dismissViewControllerAnimated:YES completion:nil];
    PostCell *cell = [_tblView cellForRowAtIndexPath:selecteIndexPath];
    PostModel *object = [[PostModel alloc] init];
    object = [arrayPost objectAtIndex:selecteIndexPath.row];
    if(cell.txtInput.text.length > 0){
        object.name = cell.txtInput.text;
        
    }else{
        object.name = @"";
    }
    object.commentHidden = NO;
    
    [object.image addObject:base64String];
    
    [arrayPost replaceObjectAtIndex:selecteIndexPath.row withObject:object];
    
    [cell.parentCollectionView setHidden: NO];
    [cell setConfigure:object];
    [cell.collectionView reloadData];
    _tblView.reloadData;
}
@end
