FROM nginx:1.23.1

## Step 1:
RUN rm /usr/share/nginx/html/index.html

## Step 2:
COPY index.html /usr/share/nginx/html
