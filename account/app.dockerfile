# ---------- BUILD STAGE ----------
FROM golang:1.25-alpine AS builder

WORKDIR /app

RUN apk --no-cache add ca-certificates

# Copy go mod files from root
COPY go.mod go.sum ./
RUN go mod download

# Copy account service source
COPY account account

# Build account service
WORKDIR /app/account/cmd/account
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o account-service

# ---------- RUNTIME STAGE ----------
FROM alpine:3.19

WORKDIR /app

COPY --from=builder /app/account/cmd/account/account-service ./account-service

EXPOSE 8080
CMD ["./account-service"]
