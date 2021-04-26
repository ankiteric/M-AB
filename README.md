# M-AB

MySQL automatic binary installation. Usually, to make our life easy while installing mysql, we use rpm files which straight away install the mysql engine on the linux machine. But one of the main disadvantage is that it binds you with the file locations or the path locations of data directory or log file (where error log resides ). The user cannot choose the file location on their own and they need to rely on rpm packages solely. This can also cause security issues because the file location will remain the same and it will be easy to find the paths. But with a binary installation - i.e. tar file - the user has total liberty to define their own path and has an option to make sure if all the files has been successfully installed. Moreover in case mysql is not running it becomes quite easy to troubleshoot. With M-AB the user can install the mysqld according to their own requirements i.e without going through all the steps needed to execute manually in tar files. M-AB will start by checking if any other mysqld is already running on the system. With M-AB, the user should make sure that the untar file of mysql is placed on the system (where mysql required to be installed) before running this programm.



# Limitations and future road map

However there are few limitaions which comes with M-AB. Currently it doesn't update the root user very first time on its own which is in future road map to implement. Additonally at the present moment, the configuration file contains only data directory and log directory but in future road map more parameters while installing can be introduced. User should remember that in order for M-AB to work properly mysql binary files should already be downloaded and must be untared without which it will fail.


# Things to take care of while using this tool :

Make ensure that you use absolute path instead of relative path when passing data directory and log directory. Absolute path is the one which starts from root i.e. the complete path. For example "/var/data01/mysql" is an absolute path if mysql is your data dorectory. It doesn't make any sense to install database in the directory where this script has been located. Hence it is safe to pass asolute path.
