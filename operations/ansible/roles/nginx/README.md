NGINX installation for Centos 5-6-7 
=========

Install epel, install nginx and push the index.html file

Example Playbook
----------------
    - hosts: web
      remote_user: centos
      become: yes
      
      roles:
         - role: michaellessard.nginx

Author Information
------------------
Michael Lessard - Red Hat
http://twitter.com/michaellessard
