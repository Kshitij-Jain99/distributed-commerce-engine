# ---------- BUILD STAGE ----------
FROM golang:1.25-alpine AS builder

RUN apk --no-cache add gcc g++ make ca-certificates

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY account ./account

RUN CGO_ENABLED=0 GOOS=linux go build -o account-service ./account/cmd/account


# ---------- RUNTIME STAGE ----------
FROM alpine:3.19

RUN apk --no-cache add ca-certificates

WORKDIR /usr/bin
COPY --from=builder /app/account-service .

EXPOSE 8080
CMD ["./account-service"]
