FROM debian:stable

# Samba
RUN apt-get update && apt-get install -yq samba gettext quota quotatool

ADD conf/samba/smb.conf /etc/samba/smb.conf

ENV WRITE_PASSWORD eeShee3eiz

RUN useradd -c "Guest User" -d /dev/null -s /bin/false eleve
RUN useradd -c "Write Samba User" -d /dev/null -s /bin/false formateur
RUN  printf "$WRITE_PASSWORD\n$WRITE_PASSWORD\n" | smbpasswd -a formateur -s
RUN smbpasswd -a eleve -n
RUN mkdir /srv/eleve; chown formateur:eleve /srv/eleve
RUN mkdir /srv/depot; chown formateur:eleve /srv/depot; chmod 775 /srv/depot

EXPOSE 445

CMD ["/usr/sbin/smbd" , "-FS"]
