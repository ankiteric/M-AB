# M-AB

MySQL automatic binary installation. Usually to make our life easy while installing mysql we usually use rpm files which straight away install the mysql engine on the linux machine. But one of the main disadvantage is that it bound you with the file locations or the path locations of data directory or log file (where error log resides ). User cannot choose the file location on their own and user needs to rely on rpm packages solely. This can also cause security issues because the file location will remain same and will be easy to find the paths. But with binary installation i.e. tar file user has an independence to define their own path and has an option to make sure if all the files has been successfully installed. Moreover in case if mysql is not running then it becomes quite easy to troubleshoot. With M-AB user can install the mysqld according to their own requirements i.e without going through all the steps needed to execute manually in tar files. M-AB will start from checking if any other mysqld is already running on the system. With M-AB user should make sure that the untar file of mysql must be placed on the system (where mysql required to be installed) before running this programm.



# Limitations and future road map

However there are few limitaions which comes with M-AB. Currently it doesn't update the root user very first time on its own which is in future road map to implement. Additonally at the prsent moment configuration file contain only data directory and log directory but in future road map more paramters while installing can be introduced. User should remember that in order for M-AB to work properly mysql binary files should already be downloaded and must be untar without which it will fail.
