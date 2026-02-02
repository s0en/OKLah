# syntax=docker/dockerfile:1

FROM golang:1.22-alpine AS build
WORKDIR /src

# Copy module files (go.sum may not exist yet)
COPY go.mod ./
COPY go.sum* ./

RUN go mod download || true

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
  go build -trimpath -ldflags="-s -w" -o /out/api ./cmd/api

FROM gcr.io/distroless/static:nonroot
COPY --from=build /out/api /api
USER nonroot:nonroot
EXPOSE 8080
ENTRYPOINT ["/api"]
