# Use Julia official image
FROM julia:1.11-bullseye

# Set working directory
WORKDIR /app

# Copy project files
COPY Project.toml Manifest.toml* ./
RUN julia -e 'using Pkg; Pkg.instantiate()'

# Copy source files
COPY . .

# Expose Render’s port
EXPOSE 10000

# Run your app
CMD ["julia", "app.jl"]