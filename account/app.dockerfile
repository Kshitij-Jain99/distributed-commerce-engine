# ---------- BUILD STAGE ----------
FROM golang:1.25-alpine AS builder

RUN apk --no-cache add gcc g++ make ca-certificates

WORKDIR /app

# Copy module files
COPY go.mod go.sum ./

# Copy vendor directory (same logic as first Dockerfile)
COPY vendor vendor

# Copy account service source
COPY account account

# Build account service using vendored deps
RUN GO111MODULE=on go build -mod=vendor -o /go/bin/account-service ./account/cmd/account

# ---------- RUNTIME STAGE ----------
FROM alpine:3.19

WORKDIR /usr/bin

COPY --from=builder /go/bin/account-service .

EXPOSE 8080
CMD ["account-service"]
