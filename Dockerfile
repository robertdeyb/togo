# Specify the base image for the go app.
FROM golang:alpine as builder
# Specify that we now need to execute any commands in this directory.
# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git

# Set the current working directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and the go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the working Directory inside the container
COPY . .

# Expose port 8080 to the outside world
EXPOSE 5050

#Command to run the executable
CMD ["go","run","main.go"]