FROM centos:centos6
MAINTAINER miko@cafelounge.net

# networking & timezone && user
ADD init.sh /boot/init
RUN echo "NETWORKING=yes" > /etc/sysconfig/network \
 && echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock \
 && rm -f /etc/localtime \
 && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 \
 && rm -rf /etc/init/*tty* \
 && chmod 700 /boot/init \
 && chkconfig iptables off \
 && chkconfig network off \
 && chkconfig udev-post off \
 && echo 'root:root' | chpasswd

# packages
RUN yum -y install epel-release; yum clean all \
 && cd /tmp \
 && curl -OL http://rpms.famillecollet.com/enterprise/remi-release-6.rpm \
 && curl -OL http://repo.mysql.com/mysql-community-release-el6.rpm \
 && curl -OL http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm \
 && yum -y localinstall remi-release-6.rpm mysql-community-release-el6.rpm groonga-release-1.1.0-1.noarch.rpm \
 && yum clean all \
 && rm -f /tmp/*.rpm

# shell
ENV LANG ja_JP.utf-8
CMD ["/boot/init", "3"]
