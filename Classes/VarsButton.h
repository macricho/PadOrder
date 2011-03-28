//
//  VarsButton.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/27.
//  Copyright 2010 Macricho. All rights reserved.
//

///自定的按鈕類別，可以存一堆變數
#import <Foundation/Foundation.h>


@interface VarsButton : UIButton {
    NSIndexPath *indexPath;
	BOOL isDetail;
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObject *managerObject;
}

@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic) BOOL isDetail;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObject *managerObject;

@end
