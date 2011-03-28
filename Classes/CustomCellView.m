//
//  CustomCellView.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/27.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "CustomCellView.h"


@implementation CustomCellView
-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}
@end
