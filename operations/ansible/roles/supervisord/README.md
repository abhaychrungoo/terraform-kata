# Universal role for installing supervisord / CentOS6-7

Each program's config shall lie in /etc/supervisord.d in it's own file.

Supervisor rotates it's log files so no need to setup logrotate.

Supported vars:
 - svd_programs (default: []) - array composed of:
    - name - name of the program used for file naming, etc.
    - command
    - owner
    - directory
    - log_directory
    - autostart (default: true)
    - autorestart (default: true)
    - exitcodes (default: '0,2')


