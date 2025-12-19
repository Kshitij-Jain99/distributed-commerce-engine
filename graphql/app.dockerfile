FROM golang:1.25-alpine AS builder

RUN apk --no-cache add gcc g++ make ca-certificates
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o graphql ./graphql


FROM alpine:3.19
RUN apk --no-cache add ca-certificates
WORKDIR /usr/bin
COPY --from=builder /app/graphql .

EXPOSE 8080
CMD ["./graphql"]
