# Use Rocky Linux 9 as the base image
FROM rockylinux:9

# Install required packages and Python3 for pip
RUN dnf update -y && \
    dnf install -y mysql-server httpd php php-cli php-gd php-curl php-zip php-mbstring php-mysqlnd python3 python3-pip

# Install supervisor using pip
RUN pip3 install supervisor

# Set the working directory to /home
WORKDIR /home

# Copy the repository files to the /home directory
COPY . /home

# Copy the supervisord configuration file
COPY supervisord.conf /etc/supervisord.conf

# Copy the MySQL initialization script
COPY mysql-init.sh /usr/local/bin/mysql-init.sh

# Make the initialization script executable
RUN chmod +x /usr/local/bin/mysql-init.sh

# Expose the HTTP port
EXPOSE 80

# Start supervisord
CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisord.conf"]