# UNIX Stuff

* Find what process is listening to a given port
  netstat -ltnp | grep 3101
  
* Find what files a process is writing to (locate logdir for example)
  lsof -p {pid}
  
* Generate ssh keys
  ssh-keygen
  
* Become dev service user id
  sudo -u iqf -s
  
* Add jobs to crontab
  crontab -e
  00 07 * * 2-6 ; Run monday to friday (2-6) at 7am (00 07)
  /bin/bash -l -c 'command >> log 2>&1'
  crontab -l

* Replace strings in many files
  cd /path/to/your/folder
  sed -i 's/foo/bar/g' *

* Find file older than 7 days and remove
  find /database/path -mtime +7 -name '????????_*' -execdir rm -rf {} \;


* 2>&1 < /dev/null | tee <LOGPATH>/<JobName>_<JobAgent>_<JobDate.yyyymmdd>.log; test ${PIPESTATUS[0]} -eq 0'
  (2>&1) redirect stderr to stdin,
  (</dev/null) detach process from terminal and point stdin at /dev/null,
  (| tee <logfile>) copy output of a pipe to a logfile,
  (${PIPESTATUS[0]}) List of status codes as list from pipes.

* Backup symfiles
  mkdir -p <PATH> && cd <PATH> && find -name "*Sym" -exec rsync -LRav {} <QPATH>/$(date "+%Y%m%d_%H%M%S")/ \;
  [-L copy Linked data, -R copy relative directory structure]
