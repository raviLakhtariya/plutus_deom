//
//  ViewController.h
//  plutus_demo
//
//  Created by ravi lakhtariya on 05/08/21.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSMutableArray * arrayPost;
}
@property (weak, nonatomic) IBOutlet UITableView *tblView;


@end

