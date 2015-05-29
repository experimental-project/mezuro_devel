#
# Regular cron jobs for the kalibro-configurations package
#
0 4	* * *	root	[ -x /usr/bin/kalibro-configurations_maintenance ] && /usr/bin/kalibro-configurations_maintenance
