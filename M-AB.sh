/*****************************************************************************
Copyright (c) 2021 M-AB

All Rights Reserved.
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License, version 2.0,
as published by the Free Software Foundation.
This program is also distributed with certain software (including
but not limited to OpenSSL) that is licensed under separate terms,
as designated in a particular file or component or in included license
documentation.  The authors of M-AB hereby grant you an additional
permission to link the program and your derivative works with the
separately licensed software that they have included with M-AB.
*****************************************************************************/


### Written by Ankit Kapoor

#!/bin/bash

### This script will install the mysqld from the binary files.User can download the binary files
### from the mysql official website. Only condition for this script to work is that the tar or zipped file should be untar and the folder should be in a place.
### This script will start from creating the group and user and if already exist will skip to the next path where it will create the data directory,log directory 
### and the configuration file after taking input from the user.


########### Step 0 to check if there is already an existing process of mysql  ######################

echo "Checking if mysqld is already running on this system"
is_running=yes
ps cax | grep mysql > /dev/null
if [ $? -eq 0 ];
  then
  echo "mysqld is already running."
  echo "Do you want to kill this process and re-install database"
        read input
         if [ "${input^^}" == "${is_running^^}" ];
            then
            id=$(ps cax | grep mysql | grep -o '^[ ]*[0-9]*')
            echo $id && kill $id
            result=$?
              if [ "$result" = 0 ];
                 then
                 echo "mysqld process has been killed successfully"
                 else
                 echo "cannot kill, please kill manually and re-run this script"
                 echo "exiting program"
                 exit 1
               fi
            echo "Proceeding towards the installation"
            else
            echo "exiting this programm"
            exit 1
         fi
   else
   echo "Process is not running and hence proceed towards the installation"
fi


sleep 3


############# Step 1 is to check if mysql group exist ####################
b=mysql

echo "Checking if group "$b "already exist and if not create one........."  

a=$(grep mysql /etc/group | cut -d : -f 1)
if [ "$a" = $b ];
   then
     echo "Group "$b "already exist"
   else
     echo "Group "$b "not exist and thus adding..."
     groupadd mysql
     result=$?
      if [ "$result" = 0 ];
       then
         echo "group succesfully added"
       else
         echo "group addition failed"
      fi
fi

sleep 2

########### Step 2 is to create the user mysql and add it to the group mysql################

echo "Now Add user "$b

useradd -r -g $b $b 2>/dev/null
result=$?

 if [ "$result" = 0 ];
    then
    echo "user succesfully added to the group "$b
    else
    echo "user already existing"
 fi

sleep 2

############## Step 3 is to create the data directory, log file directory, configuration file with minimum parameters required to start mysqld #################

echo "Enter the data directory path.For example /data01/"
read  dpath

until mkdir $dpath 2>/dev/null 
  do    
      mkdir $dpath 2>/dev/null
      echo "this path already exist. Please try again"
      read  dpath
 done
chmod -R 750 $dpath && chown -R mysql:mysql $dpath
echo "Data directory created and permission and ownership assigned"

sleep 2

echo "Now creating the log file directory where error file exist. Please enter the log directory.For example /log01"
read lpath

until mkdir $lpath 2>/dev/null
  do
      mkdir $lpath 2>/dev/null
      echo "this path already exist. Please try again"
      read  lpath
  done

  echo "creating log error file now...."
  touch $lpath/error.log && chmod -R 750 $lpath && chown -R mysql:mysql $lpath
  echo "created successfully"
  echo "log directory successfully created, permission and ownership assigned"


sleep 2

echo "cnf file will be created in the /etc folder for ease of understanding and user can move it to another location if required....."
echo "creating now...."

touch /etc/my.cnf
  result=$?
  if [ "$result" = 0 ];
     then
      echo "cnf file succesfully created adding parameters now"
      a="[mysqld]"
      b="user=mysql"
      c="datadir=$dpath"
      d="log-error=$lpath/error.log"
      echo -e "$a\n$b\n$c\n$d" > /etc/my.cnf
    else
     echo "configuration file not created..."
  fi
sleep 2

######## Step 4 ################### 

echo "Now mysql database will install.Installing........"
echo "please provide the path to the mysql bin folder. For example /mysql-8.0.23-linux-glibc2.12-x86_64/bin"
read mysqld
echo "database installing........."
$mysqld/mysqld --datadir=$dpath --initialize --user=mysql

   if [ "$result" = 0 ];
      then
        echo "database has been successfully installed under "$dpath
      else
        echo "Database creation failed please check..."
   fi
sleep 3

########## Step 5 ###################

echo "initialising database..........."
nohup $mysqld/mysqld_safe --defaults-file=/etc/my.cnf --user=mysql > /dev/null 2>&1 &
result=$?
 if [ "$result" = 0 ];
    then
     echo "Database has been initialised successfully"
    else
     echo "Not installed...Error in installing"
 fi

sleep 2
########## Step 6 ###################

######## to change the password #######

rpassword=$(grep -w "A temporary password is generated for root@localhost" $lpath/error.log | cut -d " " -f 13)
echo "Your password is "$rpassword
echo "Login into database using mysql -uroot -p'"$rpassword"'and change the password using alter user root@localhost identified by 'your password'; and then followed by 'flush privileges;'"
sleep 2
echo "exiting now...."
