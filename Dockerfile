# Use official Julia image
FROM julia:1.11-bullseye

# Set working directory
WORKDIR /app

# Copy project files first for dependency installation
COPY Project.toml Manifest.toml* ./

# Install dependencies
RUN julia -e 'using Pkg; Pkg.instantiate()'

# Copy app source code and frontend
COPY . .

# Expose Render default port
EXPOSE 10000

# Run the app
CMD ["julia", "app.jl"]