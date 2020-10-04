# Pulling the base image
FROM kalilinux/kali:latest

# Installing Dependencies for kali linux environment
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y python3-pip python3-dev &&\
    cd /usr/local/bin &&\
    ln -s /usr/bin/python3 python &&\
    pip3 install --upgrade pip
    
RUN apt-get install -y git \
    ruby \
    ruby-dev \
    libcurl4-openssl-dev \
    make \
    software-properties-common \
    curl \
    ca-certificates \
    gnupg

# Installing postgresql 
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 &&\
    echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list &&\
    apt-get install -y  \
    postgresql-11

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-9.3``
USER postgres

# Start the PostgreSQL service 
RUN /etc/init.d/postgresql start

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]

#Working Directory of tools
RUN cd /home/$USER &&\
    mkdir tool-for-pentester \
    cd tool-for-pentester

# Installing WP-Scan 
RUN git clone https://github.com/wpscanteam/wpscan.git &&\
    cd wpscan &&\
    gem install bundler && \
    bundle install --without test


# Installing SqlMap
RUN git clone https://github.com/sqlmapproject/sqlmap.git &&\
    cd sqlmap

# Installing Dirbuster
RUN apt-get install -y dirbuster

#Installing Nmap
RUN apt-get install -y nmap

# Installing Metasploit-framework
RUN git clone https://github.com/rapid7/metasploit-framework.git &&\
    cd metasploit-framework &&\
    msfdb init

# Expose the service ports
EXPOSE 5432