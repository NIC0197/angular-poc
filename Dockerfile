# Use the correct Apache 2.4 image
FROM httpd:2.4

# Enable required Apache modules (MPM is included)
# Ensure only ONE MPM module is enabled
RUN sed -i 's/^LoadModule mpm_.*so/#&/' /usr/local/apache2/conf/httpd.conf && \
    echo "LoadModule mpm_prefork_module modules/mod_mpm_prefork.so" >> /usr/local/apache2/conf/httpd.conf

# Set working directory inside the container
WORKDIR /usr/local/apache2/htdocs/

# Copy Angular build files to Apache's root directory
COPY dist/angular-poc/ .

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Apache server
CMD ["httpd", "-D", "FOREGROUND"]

