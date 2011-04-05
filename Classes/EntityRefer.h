//
//  EntityRefer.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/27.
//  Copyright 2010 Macricho. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "padOrderAppDelegate.h"

@interface EntityRefer : NSManagedObject {

}

+ (NSFetchRequest *) fetchRequestTemplateForName:(NSString *)name;
- (padOrderAppDelegate *) getApplicationDelegate;

@end
