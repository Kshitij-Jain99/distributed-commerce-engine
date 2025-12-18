# ---------- BUILD STAGE ----------
FROM golang:1.25-alpine AS builder

RUN apk --no-cache add gcc g++ make ca-certificates

WORKDIR /app

# Copy module files
COPY go.mod go.sum ./

# Copy vendor directory (vendored deps)
COPY vendor ./vendor

# Copy catalog service source
COPY catalog ./catalog

# Build catalog service
RUN GO111MODULE=on CGO_ENABLED=0 \
    go build -mod=vendor -o /catalog-service ./catalog/cmd/catalog


# ---------- RUNTIME STAGE ----------
FROM alpine:3.19

RUN apk --no-cache add ca-certificates

WORKDIR /usr/bin

COPY --from=builder /catalog-service .

EXPOSE 8080

CMD ["./catalog-service"]


# TO BUILD, repo root: docker build -t catalog-service -f catalog/app.dockerfile .
# Run: docker run --rm -p 8081:8080 catalog-service
