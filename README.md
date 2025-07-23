# docker-build-bun-nextjs

A lightweight Docker setup for building and running a Next.js application using [Bun](https://bun.sh), powered by a minimal Alpine-based container. This project leverages Docker Compose for simple orchestration and includes a multistage Docker build for production-ready deployments.

> ✅ **Built with Bun + Next.js + Docker**  
> 📦 **Minimal, fast, and production-ready**  
> 🐳 **Based on oven/bun:alpine image from ArvanCloud Docker registry**

---

## Features

- 🐇 Fast build and runtime powered by [Bun](https://bun.sh)
- 🏗️ Multistage Dockerfile for lean final image
- 🧱 Uses Docker Compose for development/production orchestration
- 🔁 Automatic restart policy in production
- 🌐 Exposes port `3000` by default

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/BaseMax/docker-build-bun-nextjs.git
cd docker-build-bun-nextjs
````

### 2. Add Your Next.js Code

Place your existing Next.js project inside this directory or use it as a template.

Ensure you have `package.json`, `bun.lock`, and your source files ready.

### 3. Build and Run with Docker Compose

```bash
docker-compose up --build
```

The app will be available at [http://localhost:3000](http://localhost:3000)

---

## Dockerfile Overview

This project uses a **multistage Dockerfile**:

### Builder Stage

* Uses `docker.arvancloud.ir/oven/bun:alpine`
* Installs dependencies using Bun
* Builds the Next.js app (`bun run build`)

### Runtime Stage

* Copies only necessary build artifacts
* Uses Bun to run `bun run start` in production mode
* Exposes port 3000

---

## docker-compose.yml

```yaml
services:
  frontend:
    build:
      context: .
      args:
        UID: 0
        GID: 0
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    restart: unless-stopped
```

You can customize `UID` and `GID` if needed.

---

## Notes

* Bun must be compatible with your Next.js version (check for experimental issues).
* Image is based on ArvanCloud's mirror of Bun images, which may speed up regional builds.

---

## License

This project is licensed under the [MIT License](./LICENSE).
© 2025 Max Base

---

## Author

**Max Base**
🔗 [github.com/BaseMax](https://github.com/BaseMax)
