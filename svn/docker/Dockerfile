FROM fedora:29

MAINTAINER https://github.com/apuex

VOLUME /var/www/svn
EXPOSE 80

RUN dnf -y update
RUN dnf -y install httpd mod_ldap mod_dav_svn subversion
RUN dnf -y clean all 

RUN htpasswd -cmb /etc/svn-auth-users admin password
RUN htpasswd -mb /etc/svn-auth-users user password
RUN chown -R apache:apache /var/www/svn

COPY ./conf.d/server.conf /etc/httpd/conf.d/
COPY ./conf.d/svn.conf /etc/httpd/conf.d/

CMD ["httpd", "-D", "FOREGROUND"]

