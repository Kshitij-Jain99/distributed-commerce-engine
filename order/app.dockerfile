FROM golang:1.25-alpine AS builder

RUN apk --no-cache add gcc g++ make ca-certificates
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY order ./order

RUN CGO_ENABLED=0 go build -o order-service ./order/cmd/order

FROM alpine:3.19
RUN apk --no-cache add ca-certificates
WORKDIR /usr/bin
COPY --from=builder /app/order-service .

EXPOSE 8080
CMD ["./order-service"]
