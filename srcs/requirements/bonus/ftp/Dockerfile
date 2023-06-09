FROM	alpine:3.13

ARG		FTP_ROOTDIR

RUN		apk update && apk upgrade \
		&& apk add --no-cache vsftpd gettext

COPY	tools/setup.sh /tmp/setup.sh
COPY	conf/vsftpd.conf /tmp/vsftpd.conf.template
RUN		export FTP_ROOTDIR=${FTP_ROOTDIR} \
		&& envsubst '$FTP_ROOTDIR' < /tmp/vsftpd.conf.template > /tmp/vsftpd.conf \
		&& rm -rf /tmp/vsftpd.conf.template

EXPOSE	21

CMD		["sh", "/tmp/setup.sh"]