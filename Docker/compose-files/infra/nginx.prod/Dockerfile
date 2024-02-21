# Use an official Nginx image as a parent image
FROM nginx:latest

# Copy the built frontend files from the frontend service
COPY --from=docker-registry.setera.com/my-ui:v0.1 /app/build /usr/share/nginx/html

COPY --from=docker-registry.setera.com/my-backend-django:v0.1 /app/my_backend/staticfiles /usr/share/nginx/static/

# Expose the port on which Nginx will run
EXPOSE 80 443

# Command to start Nginx
CMD ["nginx", "-g", "daemon off;"]
