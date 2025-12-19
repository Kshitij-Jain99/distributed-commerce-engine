# ---------- BUILD STAGE ----------
FROM golang:1.25-alpine AS builder

RUN apk --no-cache add gcc g++ make ca-certificates

WORKDIR /app

# Copy module files
COPY go.mod go.sum ./

# Copy vendor directory
COPY vendor ./vendor

# Copy service source code
COPY account ./account
COPY catalog ./catalog
COPY order ./order

# Build order service (same target as before)
RUN GO111MODULE=on CGO_ENABLED=0 \
    go build -mod=vendor -o /order-service ./order/cmd/order


# ---------- RUNTIME STAGE ----------
FROM alpine:3.19

RUN apk --no-cache add ca-certificates

WORKDIR /usr/bin

COPY --from=builder /order-service .

EXPOSE 8080

CMD ["./order-service"]
