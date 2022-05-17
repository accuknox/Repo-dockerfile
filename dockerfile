FROM golang:1.16 AS builder
ENV GO111MODULE=on
WORKDIR /home/repo-manager
COPY . .
RUN mkdir bin
RUN go mod download
RUN go build -o bin/repo-manager main.go 

FROM alphine:latest
WORKDIR /home/repo-manager
COPY --from=builder /home/repo-manager/bin/ /home/repo-manager/
RUN ["chmod", "+x", "./bin/repo-manager"]
ENTRYPOINT ["./bin/repo-manager"]

