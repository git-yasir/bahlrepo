
# Use the official Nginx base image
FROM nginx:alpine

# Copy the website files into the container's Nginx web root
COPY website /usr/share/nginx/html

# Expose port 80 to allow incoming HTTP traffic
EXPOSE 80

