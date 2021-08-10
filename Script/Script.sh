#!/bin/sh

#  Script.sh
#  KSLocalization
#
#  Created by Raja Pitchai on 10/08/21.
#  Copyright © 2021 AIT. All rights reserved.

#!/bin/bash
buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${PROJECT_DIR}/${INFOPLIST_FILE}")
buildNumber=$(($buildNumber + 1))
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "${PROJECT_DIR}/${INFOPLIST_FILE}"
