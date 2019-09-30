FROM ambakshi/perforce-server

RUN yum install -y \
    helix-git-fusion \
    helix-swarm-triggers \
    helix-cli-base \
    helix-git-connector \
    helix-git-fusion-3rdparty-git \
    helix-git-fusion-3rdparty-python3 \
    helix-git-fusion-3rdparty-python3-pytz \
    helix-git-fusion-3rdparty-pygit2 \
    openssh-server \
    && yum clean all --enablerepo='*' \
    && rm -rf /var/cache/yum

RUN yum install -y sudo

RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd \
    && sed -i 's@session\s*include\s*system-auth$@session optional system-auth@g' /etc/pam.d/su \
    && sed -i 's@PermitRootLogin without-password@PermitRootLogin yes@' /etc/ssh/sshd_config

EXPOSE 22 80

COPY ./setup-git-fusion.sh /usr/local/bin/
COPY setup-perforce.sh setup-perforce.sh
COPY setup-perforce.sh /usr/local/bin/setup-perforce.sh
RUN ["cp", "/opt/perforce/git-fusion/libexec/p4gf_submit_trigger_wrapper.sh", "/usr/local/bin/"]
RUN ["chmod", "+x", "/run.sh", "/usr/local/bin/setup-git-fusion.sh", "/usr/local/bin/p4gf_submit_trigger_wrapper.sh"]

COPY ./run.sh /
CMD ["/run.sh"]
