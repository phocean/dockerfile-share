FROM ubuntu:bionic

MAINTAINER Phocean <jc@phocean.net>

ARG WRITE_PASSWORD

# Samba
RUN apt-get update && apt-get install -yq samba gettext quota quotatool && rm -rf /var/lib/apt/lists/*

ADD conf/samba/smb.conf /etc/samba/smb.conf

RUN useradd -c "Guest User" -d /dev/null -s /bin/false guest
RUN useradd -c "Write Samba User" -d /dev/null -s /bin/false master
RUN  printf "$WRITE_PASSWORD\n$WRITE_PASSWORD\n" | smbpasswd -a master -s
RUN smbpasswd -a guest -n
RUN mkdir /srv/share; chown master:guest /srv/share
RUN mkdir /srv/upload; chown master:guest /srv/upload; chmod 775 /srv/upload

EXPOSE 445

CMD ["/usr/sbin/smbd" , "-FS"]
