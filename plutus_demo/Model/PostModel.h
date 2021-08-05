//
//  PostModel.h
//  plutus_demo
//
//  Created by ravi lakhtariya on 05/08/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostModel : NSObject
    @property (nonatomic, copy)  NSString *name;
    @property (nonatomic, copy)  NSMutableArray<NSString *> *image;
    @property (nonatomic, copy)  NSString *Comments;
    @property (nonatomic, assign)  BOOL *commentHidden;
    
@end

NS_ASSUME_NONNULL_END

