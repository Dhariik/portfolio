# Use Nginx as base image
FROM nginx:alpine

# Copy the HTML file to the Nginx server
COPY index.html /usr/share/nginx/html/

# Copy images folder to the Nginx server
COPY images/ /usr/share/nginx/html/images/

# Copy any CSS or JS files if you have them in separate folders
# COPY css/ /usr/share/nginx/html/css/
# COPY js/ /usr/share/nginx/html/js/

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
