# syntax=docker/dockerfile:1
FROM golang:1.22-alpine AS build
WORKDIR /src
COPY . .
RUN go mod init example.com/oklah-api || true
RUN go mod tidy || true
RUN CGO_ENABLED=0 go build -o /out/api ./cmd/api

FROM gcr.io/distroless/static:nonroot
COPY --from=build /out/api /api
USER nonroot:nonroot
ENTRYPOINT ["/api"]
